"! ロジスティクス伝票紐付追跡<br>
"! <ul>***** 前提条件 *****
"! <li>Dropship：海外販社→NKK管理→グループ工場</li>
"! <li>二国間取引：グループ会社→グループ会社</li>
"! <li>上記のプロセスでまたぐグループ会社数は2～3とは限らない</li>
"! <li>1つのプロセスで、あるグループ会社での受発注が2セット以上発生することもある</li>
"! <li>ジョブ連携1日目：MRPにより、グループ会社の全ての購買依頼と計画手配が登録される</li>
"! <li>ジョブ連携1日目：伝票紐付更新：起点受注→購買依頼→計画手配→・・・</li>
"! <li>ジョブ連携2日目：会社間取引用のアドオンジョブにより、グループ会社の全ての購買発注と会社間受注が登録される</li>
"! <li>ジョブ連携2日目：伝票紐付更新：起点受注→購買発注→会社間受注→・・・</li>
"! <li>伝票紐付の『枝分かれ』：MRPにより複数の購買依頼/計画手配が作られると伝票紐付フローに枝分かれが発生する</li>
"! </ul>
class zcl_logi_document_tracking definition public final create private .
  public section.
    types:
      begin of ty_s_document_tracking,
        ro_document_tracking type ref to zcl_logi_document_tracking,
      end   of ty_s_document_tracking,
      ty_t_document_tracking type standard table of ty_s_document_tracking with empty key
      .
    class-methods:
      "! インスタンス生成<br>
      "! 基準の伝票によっては伝票追跡フローが複数存在するケースがあります
      "! @parameter im_base_document      | 伝票番号（基準）
      "! @parameter im_base_document_item | 明細番号（基準）
      "! @parameter rt_document_tracking  | 伝票追跡フロー
      "! @raising cx_aia_static           | 伝票紐付登録なしの場合
      create  importing
        im_base_document      type zi_pi925_01-FromDocument
        im_base_document_item type zi_pi925_01-FromDocumentItem optional
        returning value(rt_document_tracking) type ty_t_document_tracking
        raising cx_aia_static
        .
    methods:
      "! まとめ出荷 1stインボイス番号<br>
      "! <ul>***** 前提条件 *****
      "! <li>対象受注：基準伝票以降にある最初の受注</li>
      "! <li>除外：プラント1003の受注</li>
      "! </ul>
      "! *** 259 入出庫伝票更新 ***
      "! @parameter rv_1st_invoice | 1stインボイス番号
      "! @raising cx_aia_static    | 基準伝票以降に受注がない
      get_1st_invoice
        returning value(rv_1st_invoice)         type ZI_VF903_01-CombineShippingID
        raising cx_aia_static
        ,
      "! まとめ出荷 2ndインボイス番号<br>
      "! *** 259 入出庫伝票更新 ***
      "! @parameter rv_2nd_invoice | 2ndインボイス番号
      "! @raising cx_aia_static    | 対象のグループ工場に受注がない
      get_2nd_invoice
        returning value(rv_2nd_invoice)         type ZI_VF903_01-CombineShippingID2nd
        raising cx_aia_static
        ,
      "! 伝票起点の受注明細<br>
      "! *** BADI｜受注明細チェック ***
      "! @parameter rs_sales_document_item  | 受注明細
      "! @raising cx_aia_static             | 伝票起点に受注明細がない場合
      get_root_sales_doc_item
        returning value(rs_sales_document_item) type I_SalesDocumentItem
        raising cx_aia_static
        ,
      "! 前プラントでの受注明細<br>
      "! *** 025 海外出荷帳票 ***<br>
      "! @parameter rs_sales_document_item  | 受注明細
      "! @raising cx_aia_static             | 前プラントで受注明細がない場合
      get_sales_item_in_prev_plant
        returning value(rs_sales_document_item) type I_SalesDocumentItem
        raising cx_aia_static
        ,
      "! 同一プラント内の製造指図<br>
      "! *** 025 海外出荷帳票 ***<br>
      "! [前提] 各プラントで登録される製造指図は最大1伝票であること<br>
      "! @parameter rs_manufacturing_order | 製造指図
      "! @raising cx_aia_static            | （基準伝票と）同一プラント内に製造指図がない場合
      get_manufacturing_in_plant
        returning value(rs_manufacturing_order) type I_ManufacturingOrder
        raising cx_aia_static
        .
  protected section.
  private section.
    data:
      "! インスタンス生成時基準とした伝票情報
      begin of s_base,
        document                  type zi_pi925_01-FromDocument,
        item                      type zi_pi925_01-FromDocumentItem,
        type                      type zi_pi925_01-FromDocumentTypeCode,
        plant                     type zi_pi925_01-FromDocumentPlant,
        is_from                   type abap_boolean,
      end   of s_base
      ,
      "! グループ会社（プラント）
      begin of s_plant_conditions,
        sales_company             type range of I_Plant-Plant,
        nkk_sales                 type range of I_Plant-Plant,
        nkk_manage                type range of I_Plant-Plant,
        group_factory             type range of I_Plant-Plant,
      end   of s_plant_conditions
      ,
      "! 伝票追跡全フロー情報
      t_document_tracking type standard table of zi_pi925_01 with default key.

    methods:
      "! コンストラクタ
      "! @parameter im_base_document      | 基準伝票
      "! @parameter im_base_document_item | 基準伝票明細
      "! @parameter im_root_document      | 先頭伝票
      "! @parameter im_root_document_item | 先頭伝票明細
      "! @parameter im_root_working_date  | 先頭稼働日
      "! @parameter is_base_from          | true = 基準伝票がFromで検索できた場合
      "! @parameter is_base_to            | true = 基準伝票がToで検索できた場合
      "! @raising   cx_aia_static         | 伝票追跡情報が未登録の場合
      constructor importing
        im_base_document          type zi_pi925_01-FromDocument
        im_base_document_item     type zi_pi925_01-FromDocumentItem
        im_root_document          type zi_pi925_01-TopFromDocument
        im_root_document_item     type zi_pi925_01-TopFromDocumentItem
        im_root_working_date      type zi_pi925_01-TopFromWorkingdayDate
        is_base_from              type abap_boolean default abap_false
        is_base_to                type abap_boolean default abap_false
        raising cx_aia_static
        ,
      "! 伝票追跡｜先頭
      get_root
        returning value(rs_root)  type zi_pi925_01
        raising cx_sy_itab_line_not_found
        ,
      "! 伝票追跡｜末端
      get_end
        returning value(rs_end)   type zi_pi925_01
        ,
      "! 伝票追跡｜次のフロー
      "! @parameter im_from_document      | 指定：ToDocument
      "! @parameter im_from_document_item | 指定：ToDocumentItem
      get_next importing
        im_from_document          type zi_pi925_01-FromDocument
        im_from_document_item     type zi_pi925_01-FromDocumentItem
        returning value(rs_next)  type zi_pi925_01
        raising cx_sy_itab_line_not_found
        ,
      "! 伝票追跡｜前のフロー
      "! @parameter im_to_document      | 指定：FromDocument
      "! @parameter im_to_document_item | 指定：FromDocumentItem
      get_prev importing
        im_to_document            type zi_pi925_01-ToDocument
        im_to_document_item       type zi_pi925_01-ToDocumentItem
        returning value(rs_prev)  type zi_pi925_01
        raising cx_sy_itab_line_not_found
        ,
      "! 伝票追跡｜基準伝票
      get_base
        returning value(rs_base)  type zi_pi925_01
        raising cx_sy_itab_line_not_found
        ,
      "! 次のプラント<br>
      "! 会社間取引において伝票フローの次の組織（プラント）を検索する<br>
      get_next_plant              importing
        im_base_plant             type zi_pi925_01-FromDocumentPlant
        returning value(rv_plant) type zi_pi925_01-ToDocumentPlant
        raising cx_sy_itab_line_not_found
        ,
      "! 前のプラント<br>
      "! 会社間取引において伝票フローの前の組織（プラント）を検索する<br>
      get_prev_plant              importing
        im_base_plant             type zi_pi925_01-ToDocumentPlant
        returning value(rv_plant) type zi_pi925_01-FromDocumentPlant
        raising cx_sy_itab_line_not_found
        ,
      "! 販売伝票明細
      get_sales_document_item     importing
        im_sales_document         type zi_pi925_01-FromDocument
        im_sales_document_item    type zi_pi925_01-FromDocumentItem
        returning value(rs_sales_document_item)     type I_SalesDocumentItem
        ,
      "! 購買発注明細
      get_purchase_order_item     importing
        im_purchae_order          type zi_pi925_01-FromDocument
        im_purchae_order_item     type zi_pi925_01-FromDocumentItem
        returning value(rs_purchase_order_item)     type I_PurchaseOrderItemTP_2
        ,
      "! 製造指図
      get_manufacturing_order     importing
        im_manufacturing_order    type zi_pi925_01-FromDocument
        returning value(rs_manufactruing_order)     type I_ManufacturingOrder
        ,
      "! まとめ出荷ヘッダ
      get_combine_shipping_header importing
        im_combine_shipping       type ZI_VF903_02-CombineShippingID
        returning value(rs_combine_shipping_header) type zi_vf903_01
        ,
      "! まとめ出荷明細
      get_combine_shipping_item   importing
        im_sales_order            type I_SalesDocumentItem-SalesDocument
        im_sales_order_item       type I_SalesDocumentItem-SalesDocumentItem
        returning value(rs_combine_shipping_item)   type zi_vf903_02
        .
ENDCLASS.



CLASS ZCL_LOGI_DOCUMENT_TRACKING IMPLEMENTATION.


  method constructor.
    select * from zi_pi925_01 with privileged access
      where TopFromDocument       = @im_root_document
        and TopFromDocumentItem   = @im_root_document_item
        and TopFromWorkingdayDate = @im_root_working_date
       into table @t_document_tracking.

    s_base = cond #(
      when is_base_from = abap_true
        then value #(
          document  = t_document_tracking[ FromDocument = im_base_document FromDocumentItem = im_base_document_item ]-FromDocument
          item      = t_document_tracking[ FromDocument = im_base_document FromDocumentItem = im_base_document_item ]-FromDocumentItem
          type      = t_document_tracking[ FromDocument = im_base_document FromDocumentItem = im_base_document_item ]-FromDocumentTypeCode
          plant     = t_document_tracking[ FromDocument = im_base_document FromDocumentItem = im_base_document_item ]-FromDocumentPlant
          is_from   = abap_true
        )
      when is_base_to = abap_true
        then value #(
          document  = t_document_tracking[ ToDocument   = im_base_document ToDocumentItem   = im_base_document_item ]-ToDocument
          item      = t_document_tracking[ ToDocument   = im_base_document ToDocumentItem   = im_base_document_item ]-ToDocumentItem
          type      = t_document_tracking[ ToDocument   = im_base_document ToDocumentItem   = im_base_document_item ]-ToDocumentTypeCode
          plant     = t_document_tracking[ ToDocument   = im_base_document ToDocumentItem   = im_base_document_item ]-ToDocumentPlant
          is_from   = abap_false
        )
      else throw cx_aia_static( textid = value #( msgid = '>6' msgno = 164 ) )   "パラメータの保存中の予期せぬエラー
    ).

    s_plant_conditions = value #(
      nkk_sales   = value #( ( sign = 'I' option = 'EQ' low = '1001' ) )
      nkk_manage  = value #( ( sign = 'I' option = 'EQ' low = '1003' ) )
    ).

    select Plant from I_Plant with privileged access
      where Plant like '___1' and not Plant = '1001'
      into table @data(lt_sales_company).
    loop at lt_sales_company assigning field-symbol(<sales>).
      append value #( sign = 'I' option = 'EQ' low = <sales>-Plant )    to s_plant_conditions-sales_company.
    endloop.

    select Plant from I_Plant with privileged access
      where Plant like '___2'
      into table @data(lt_group_factory).
    loop at lt_group_factory assigning field-symbol(<factory>).
      append value #( sign = 'I' option = 'EQ' low = <factory>-Plant )  to s_plant_conditions-group_factory.
    endloop.
  endmethod.


  method create.
    select * from zi_pi925_01 with privileged access
      where FromDocument      = @im_base_document
        and FromDocumentItem  = @im_base_document_item
       into table @data(lt_document_tracking_from).

    select * from zi_pi925_01 with privileged access
      where ToDocument        = @im_base_document
        and ToDocumentItem    = @im_base_document_item
       into table @data(lt_document_tracking_to).

    try.
      loop at lt_document_tracking_from assigning field-symbol(<from>).
        append value #( ro_document_tracking = new #(
          im_base_document      = <from>-FromDocument
          im_base_document_item = <from>-FromDocumentItem
          im_root_document      = <from>-TopFromDocument
          im_root_document_item = <from>-TopFromDocumentItem
          im_root_working_date  = <from>-TopFromWorkingdayDate
          is_base_from          = abap_true
        ) ) to rt_document_tracking.
      endloop.
    catch cx_sy_itab_line_not_found.
      raise exception type cx_aia_static exporting textid = value #( msgid = '/PF1/MSG_PO_EH' msgno = 509 attr1 = |{ <from>-TopFromDocument }-{ <from>-TopFromDocumentItem }| ).   "&1 のインスタンス化に失敗しました
    endtry.

    try.
      loop at lt_document_tracking_to assigning field-symbol(<to>).
        check not line_exists( lt_document_tracking_from[ TopFromDocument = <to>-TopFromDocument TopFromDocumentItem = <to>-TopFromDocumentItem TopFromWorkingdayDate = <to>-TopFromWorkingdayDate ] ).
        append value #( ro_document_tracking = new #(
          im_base_document      = <to>-ToDocument
          im_base_document_item = <to>-ToDocumentItem
          im_root_document      = <to>-TopFromDocument
          im_root_document_item = <to>-TopFromDocumentItem
          im_root_working_date  = <to>-TopFromWorkingdayDate
          is_base_to            = abap_true
        ) ) to rt_document_tracking.
      endloop.
    catch cx_sy_itab_line_not_found.
      raise exception type cx_aia_static exporting textid = value #( msgid = '/PF1/MSG_PO_EH' msgno = 509 attr1 = |{ <to>-TopFromDocument }-{ <to>-TopFromDocumentItem }| ).   "&1 のインスタンス化に失敗しました
    endtry.

    if lines( rt_document_tracking ) = 0.
      raise exception type cx_aia_static exporting textid = value #( msgid = 'ZRAP_COM_99' msgno = 148 ).   "対象データが存在しません
    endif.
  endmethod.


  method get_1st_invoice.
    try.
      data(ls_next) = get_base( ).
      do.
        if ls_next-ToDocumentPlant not in s_plant_conditions-nkk_manage.
          if ls_next-ToDocumentTypeCode = 'SO'.
            rv_1st_invoice = get_combine_shipping_item( im_sales_order = conv #( ls_next-ToDocument ) im_sales_order_item = conv #( ls_next-ToDocumentItem ) )-CombineShippingID.
            exit.
          endif.
        endif.
        ls_next = get_next( im_from_document = ls_next-ToDocument im_from_document_item = ls_next-ToDocumentItem ).
      enddo.
    catch cx_sy_itab_line_not_found.
      raise exception type cx_aia_static exporting textid = value #( msgid = 'RPMFIOUT' msgno = 012 ).   "受注 &1 がありません
    endtry.
  endmethod.


  method get_2nd_invoice.
    rv_2nd_invoice = get_combine_shipping_header( get_1st_invoice( ) )-CombineShippingID2nd.
  endmethod.


  method get_root_sales_doc_item.
    try.
      data(ls_root_plant_so)  = t_document_tracking[ FromDocumentTypeCode = 'SO' FromDocumentPlant = get_root( )-TopFromDocumentPlant ].
      rs_sales_document_item  = get_sales_document_item( im_sales_document = ls_root_plant_so-FromDocument im_sales_document_item = ls_root_plant_so-FromDocumentItem ).
    catch cx_sy_itab_line_not_found.
      raise exception type cx_aia_static exporting textid = value #( msgid = 'RPMFIOUT' msgno = 012 ).   "受注 &1 がありません
    endtry.
  endmethod.


  method get_manufacturing_in_plant.
    try.
      rs_manufacturing_order = get_manufacturing_order( t_document_tracking[ ToDocumentTypeCode = 'MO' ToDocumentPlant = s_base-plant ]-ToDocument ).
    catch cx_sy_itab_line_not_found.
      raise exception type cx_aia_static exporting textid = value #( msgid = 'CC' msgno = 392 ).   "製造指図はありません
    endtry.
  endmethod.


  method get_sales_item_in_prev_plant.
    try.
      data(ls_prev_plant_sales) = t_document_tracking[ FromDocumentPlant = get_prev_plant( s_base-plant ) FromDocumentTypeCode = 'SO' ].
      rs_sales_document_item    = get_sales_document_item( im_sales_document = ls_prev_plant_sales-FromDocument im_sales_document_item = ls_prev_plant_sales-FromDocumentItem ).
    catch cx_sy_itab_line_not_found.
      raise exception type cx_aia_static exporting textid = value #( msgid = 'RPMFIOUT' msgno = 012 ).   "受注 &1 がありません
    endtry.
  endmethod.


  method get_base.
    rs_base = cond #( when s_base-is_from = abap_true
      then t_document_tracking[ FromDocument = s_base-document FromDocumentItem = s_base-item ]
      else t_document_tracking[ ToDocument   = s_base-document ToDocumentItem   = s_base-item ]
    ).
  endmethod.


  method get_root.
    data(ls_base) = get_base( ).
    rs_root = t_document_tracking[
      TopFromDocument       = ls_base-TopFromDocument         FromDocument        = ls_base-TopFromDocument
      TopFromDocumentItem   = ls_base-TopFromDocumentItem     FromDocumentItem    = ls_base-TopFromDocumentItem
      TopFromWorkingdayDate = ls_base-TopFromWorkingdayDate   FromWorkingdayDate  = ls_base-TopFromWorkingdayDate
    ].
  endmethod.


  method get_end.
    try.
      data(ls_prev) = get_base( ).
      do.
        data(ls_next) = get_next( im_from_document = ls_prev-ToDocument im_from_document_item = ls_prev-ToDocumentItem ).
        ls_prev = ls_next.
      enddo.
    catch cx_sy_itab_line_not_found.
      rs_end = ls_prev.
    endtry.
  endmethod.


  method get_next.
    rs_next = t_document_tracking[ FromDocument = im_from_document FromDocumentItem = im_from_document_item ].
  endmethod.


  method get_prev.
    rs_prev = t_document_tracking[ ToDocument = im_to_document ToDocumentItem = im_to_document_item ].
  endmethod.


  method get_next_plant.
    data(ls_next) = t_document_tracking[ FromDocumentPlant = im_base_plant ].
    do.
      if ls_next-ToDocumentPlant <> im_base_plant.
        rv_plant = ls_next-ToDocumentPlant.exit.
      endif.
      ls_next = get_next( im_from_document = ls_next-ToDocument im_from_document_item = ls_next-ToDocumentItem ).
    enddo.
  endmethod.


  method get_prev_plant.
    data(ls_prev) = t_document_tracking[ toDocumentPlant = im_base_plant ].
    do.
      if ls_prev-FromDocumentPlant <> im_base_plant.
        rv_plant = ls_prev-FromDocumentPlant.exit.
      endif.
      ls_prev = get_prev( im_to_document = ls_prev-FromDocument im_to_document_item = ls_prev-FromDocumentItem ).
    enddo.
  endmethod.


  method get_sales_document_item.
    data(lv_sales_document)       = conv I_SalesDocumentItem-SalesDocument( im_sales_document ).
    data(lv_sales_document_item)  = conv I_SalesDocumentItem-SalesDocumentItem( im_sales_document_item ).
    select single * from I_SalesDocumentItem with privileged access
      where SalesDocument     = @lv_sales_document
        and SalesDocumentItem = @lv_sales_document_item
       into @rs_sales_document_item.
  endmethod.


  method get_purchase_order_item.
    data(lv_purchase_order)       = conv I_PurchaseOrderItemTP_2-PurchaseOrder( im_purchae_order ).
    data(lv_purchase_order_item)  = conv I_PurchaseOrderItemTP_2-PurchaseOrderItem( im_purchae_order_item ).
    select single * from I_PurchaseOrderItemTP_2 with privileged access
      where PurchaseOrder     = @lv_purchase_order
        and PurchaseOrderItem = @lv_purchase_order_item
       into @rs_purchase_order_item.
  endmethod.


  method get_manufacturing_order.
    data(lv_manufaturing_order) = conv I_ManufacturingOrder-ManufacturingOrder( im_manufacturing_order ).
    select single * from I_ManufacturingOrder with privileged access
      where ManufacturingOrder = @lv_manufaturing_order
       into @rs_manufactruing_order.
  endmethod.


  method get_combine_shipping_header.
    select single * from ZI_VF903_01 with privileged access
      where CombineShippingID = @im_combine_shipping
       into @rs_combine_shipping_header.
  endmethod.


  method get_combine_shipping_item.
    select single * from ZI_VF903_02 with privileged access
      where SalesDocument     = @im_sales_order
        and SalesDocumentItem = @im_sales_order_item
       into @rs_combine_shipping_item.
  endmethod.
ENDCLASS.
