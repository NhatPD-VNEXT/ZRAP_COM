"! SAP標準CDSに対するテストダブルが作れないため、実データを利用しています<br>
class lcl_realdata_selector definition.
  public section.
    types:
      begin of ty_s_any,
        document          type I_JournalEntryItem-AccountingDocument,
        item              type I_JournalEntryItem-LedgerGLLineItem,
      end   of ty_s_any,
      ty_t_any            type standard table of ty_s_any with empty key
      .
    types:
      begin of ty_s_pir,
        id                type I_ActivePlndIndepRqmtItem-PlndIndepRqmtInternalID,
        date              type I_ActivePlndIndepRqmtItem-WorkingDayDate,
        plant             type I_ActivePlndIndepRqmt-Plant,
        doc_type          type zz_doccategory,
      end   of ty_s_pir,
      ty_t_pir            type standard table of ty_s_pir with empty key
      .
    types:
      begin of ty_s_sales,
        document          type I_SalesDocumentItem-SalesDocument,
        item              type I_SalesDocumentItem-SalesDocumentItem,
        plant             type I_SalesDocumentItem-Plant,
        doc_type          type zz_doccategory,
      end   of ty_s_sales,
      ty_t_sales          type standard table of ty_s_sales with empty key
      .
    types:
      begin of ty_s_requisition,
        document          type I_PurchaseRequisitionItemAPI01-PurchaseRequisition,
        item              type I_PurchaseRequisitionItemAPI01-PurchaseRequisitionItem,
        plant             type I_PurchaseRequisitionItemAPI01-Plant,
        doc_type          type zz_doccategory,
      end   of ty_s_requisition,
      ty_t_requisition    type standard table of ty_s_requisition with empty key
      .
    types:
      begin of ty_s_purchase,
        document          type I_PurchaseOrderItemAPI01-PurchaseOrder,
        item              type I_PurchaseOrderItemAPI01-PurchaseOrderItem,
        plant             type I_PurchaseOrderItemAPI01-Plant,
        doc_type          type zz_doccategory,
      end   of ty_s_purchase,
      ty_t_purchase       type standard table of ty_s_purchase with empty key
      .
    types:
      begin of ty_s_planned,
        document          type I_PlannedOrder-PlannedOrder,
        item              type ZI_PI925_01-TopFromDocumentItem,
        plant             type I_PlannedOrder-ProductionPlant,
        doc_type          type zz_doccategory,
      end   of ty_s_planned,
      ty_t_planned        type standard table of ty_s_planned with empty key
      .
    types:
      begin of ty_s_manufacturing,
        document          type I_ManufacturingOrder-ManufacturingOrder,
        item              type ZI_PI925_01-TopFromDocumentItem,
        plant             type I_ManufacturingOrder-ProductionPlant,
        doc_type          type zz_doccategory,
      end   of ty_s_manufacturing,
      ty_t_manufacturing  type standard table of ty_s_manufacturing with empty key
      .
    constants:
      begin of c_plant_group,
        seller            type i value 0,
        nkk_seller        type i value 1,
        nkk_manage        type i value 2,
        factory           type i value 3,
      end   of c_plant_group.
    methods:
      constructor
        ,
      "! 任意伝票明細
      any_document_item
        importing im_count                        type i default 1
        returning value(rt_any)                   type ty_t_any
        ,
      "! 計画独立所要量｜海外販社
      plan_ind_req_seller
        importing im_count                        type i default 1
        returning value(rt_pir)                   type ty_t_pir
        ,
      "! 販売伝票明細｜海外販社
      sales_document_seller
        importing im_count                        type i default 1
        returning value(rt_sales_document_item)   type ty_t_sales
        ,
      "! 販売伝票明細｜NKK販売
      sales_document_nkk_seller
        importing im_count                        type i default 1
        returning value(rt_sales_document_item)   type ty_t_sales
        ,
      "! 販売伝票明細｜NKK管理
      sales_document_nkk_manage
        importing im_count                        type i default 1
        returning value(rt_sales_document_item)   type ty_t_sales
        ,
      "! 販売伝票明細｜グループ工場
      sales_document_factory
        importing im_count                        type i default 1
        returning value(rt_sales_document_item)   type ty_t_sales
        ,
      "! 購買依頼明細｜海外販社
      purchase_request_seller
        importing im_count                        type i default 1
        returning value(rt_purchase_request_item) type ty_t_requisition
        ,
      "! 購買依頼明細｜NKK販売
      purchase_request_nkk_seller
        importing im_count                        type i default 1
        returning value(rt_purchase_request_item) type ty_t_requisition
        ,
      "! 購買依頼明細｜NKK管理
      purchase_request_nkk_manage
        importing im_count                        type i default 1
        returning value(rt_purchase_request_item) type ty_t_requisition
        ,
      "! 購買依頼明細｜グループ工場
      purchase_request_factory
        importing im_count                        type i default 1
        returning value(rt_purchase_request_item) type ty_t_requisition
        ,
      "! 購買発注明細｜海外販社
      purchase_order_seller
        importing im_count                        type i default 1
        returning value(rt_purchase_order_item)   type ty_t_purchase
        ,
      "! 購買発注明細｜NKK販売
      purchase_order_nkk_seller
        importing im_count                        type i default 1
        returning value(rt_purchase_order_item)   type ty_t_purchase
        ,
      "! 購買発注明細｜NKK管理
      purchase_order_nkk_manage
        importing im_count                        type i default 1
        returning value(rt_purchase_order_item)   type ty_t_purchase
        ,
      "! 購買発注明細｜グループ工場
      purchase_order_factory
        importing im_count                        type i default 1
        returning value(rt_purchase_order_item)   type ty_t_purchase
        ,
      "! 計画手配｜グループ工場
      planned_order_factory
        importing im_count                        type i default 1
        returning value(rt_planned_order)         type ty_t_planned
        ,
      "! 製造指図｜グループ工場
      manufacturing_order_factory
        importing im_count                        type i default 1
        returning value(rt_manufacturing_order)   type ty_t_manufacturing
        .
  protected section.
  private section.
    data:
      begin of s_plant_used_onece,
        seller      type range of I_Plant-Plant,
        nkk_seller  type range of I_Plant-Plant,
        nkk_manage  type range of I_Plant-Plant,
        factory     type range of I_Plant-Plant,
      end   of s_plant_used_onece,
      begin of tr_plant_selectable,
        seller      type range of I_Plant-Plant,
        nkk_seller  type range of I_Plant-Plant,
        nkk_manage  type range of I_Plant-Plant,
        factory     type range of I_Plant-Plant,
      end   of tr_plant_selectable.
    methods:
      "! 使用済プラント
      set_used_once
        importing im_plant                        type I_Plant-Plant
                  im_group                        like c_plant_group-seller
        ,
      "! 計画独立所要量
      plan_ind_req
        importing im_count                        type i
                  im_group                        like c_plant_group-seller
        returning value(rt_pir)                   type ty_t_pir
        ,
      "! 販売伝票明細
      sales_document
        importing im_count                        type i
                  im_group                        like c_plant_group-seller
        returning value(rt_sales_document_item)   type ty_t_sales
        ,
      "! 購買依頼明細
      purchase_request
        importing im_count                        type i
                  im_group                        like c_plant_group-seller
        returning value(rt_purchase_request_item) type ty_t_requisition
        ,
      "! 購買発注明細
      purchase_order
        importing im_count                        type i
                  im_group                        like c_plant_group-seller
        returning value(rt_purchase_order_item)   type ty_t_purchase
        ,
      "! 計画手配
      planned_order
        importing im_count                        type i
                  im_group                        like c_plant_group-seller
        returning value(rt_planned_order)         type ty_t_planned
        ,
      "! 製造指図
      manufacturing_order
        importing im_count                        type i
                  im_group                        like c_plant_group-seller
        returning value(rt_manufacturing_order)   type ty_t_manufacturing
        .
endclass.

class lcl_realdata_selector implementation.

  method constructor.
    tr_plant_selectable = value #(
      seller      = value #( sign = 'I' option = 'EQ' ( low = '2001' ) ( low = '3001' ) ( low = '4001' ) ( low = '9001' ) )
      factory     = value #( sign = 'I' option = 'EQ' ( low = '6002' ) ( low = '7002' ) ( low = '8002' ) )
      nkk_seller  = value #( sign = 'I' option = 'EQ' ( low = '1001' ) )
      nkk_manage  = value #( sign = 'I' option = 'EQ' ( low = '1003' ) )
    ).
  endmethod.


  method set_used_once.
    if im_group = c_plant_group-seller     and s_plant_used_onece-seller     is initial.
      s_plant_used_onece-seller     = value #( ( sign = 'I' option = 'EQ' low = im_plant ) ).
    endif.
    if im_group = c_plant_group-factory    and s_plant_used_onece-factory    is initial.
      s_plant_used_onece-factory    = value #( ( sign = 'I' option = 'EQ' low = im_plant ) ).
    endif.
    if im_group = c_plant_group-nkk_seller and s_plant_used_onece-nkk_seller is initial.
      s_plant_used_onece-nkk_seller = value #( ( sign = 'I' option = 'EQ' low = im_plant ) ).
    endif.
    if im_group = c_plant_group-nkk_manage and s_plant_used_onece-nkk_manage is initial.
      s_plant_used_onece-nkk_manage = value #( ( sign = 'I' option = 'EQ' low = im_plant ) ).
    endif.
  endmethod.


  method any_document_item.
    data(ro_random_10) = cl_abap_random_int=>create( min = 10000000 max = 99999999 ).
    data(ro_random_06) = cl_abap_random_int=>create( min = 100000   max = 999999   ).
    do im_count times.
      append value #( document = ro_random_10->get_next( ) item = ro_random_06->get_next( ) ) to rt_any.
    enddo.
  endmethod.


  method plan_ind_req.
    data ltr_plant like tr_plant_selectable-seller.
    ltr_plant = switch #( im_group
      when c_plant_group-seller     then cond #( when s_plant_used_onece-seller     is initial then tr_plant_selectable-seller     else s_plant_used_onece-seller )
      when c_plant_group-nkk_seller then cond #( when s_plant_used_onece-nkk_seller is initial then tr_plant_selectable-nkk_seller else s_plant_used_onece-nkk_seller )
      when c_plant_group-nkk_manage then cond #( when s_plant_used_onece-nkk_manage is initial then tr_plant_selectable-nkk_manage else s_plant_used_onece-nkk_manage )
      when c_plant_group-factory    then cond #( when s_plant_used_onece-factory    is initial then tr_plant_selectable-factory    else s_plant_used_onece-factory )
      else value #( )
    ).
    loop at ltr_plant assigning field-symbol(<range_plant>).
      select item~PlndIndepRqmtInternalID,item~WorkingDayDate,header~Plant,'PIR' as doc_type
        from       I_ActivePlndIndepRqmtItem as item
        inner join I_ActivePlndIndepRqmt     as header
          on item~PlndIndepRqmtInternalID = header~PlndIndepRqmtInternalID
        where header~Plant = @<range_plant>-low
        into table @rt_pir up to @im_count rows options privileged access."#EC CI_NOORDER
      if lines( rt_pir ) = im_count.
        set_used_once( im_group = im_group im_plant = rt_pir[ 1 ]-plant )."#EC CI_NOORDER
        exit.
      endif.
    endloop.
  endmethod.


  method plan_ind_req_seller.
    rt_pir = plan_ind_req( im_group = c_plant_group-seller im_count = im_count ).
  endmethod.


  method sales_document.
    data ltr_plant like tr_plant_selectable-seller.
    ltr_plant = switch #( im_group
      when c_plant_group-seller     then cond #( when s_plant_used_onece-seller     is initial then tr_plant_selectable-seller     else s_plant_used_onece-seller )
      when c_plant_group-nkk_seller then cond #( when s_plant_used_onece-nkk_seller is initial then tr_plant_selectable-nkk_seller else s_plant_used_onece-nkk_seller )
      when c_plant_group-nkk_manage then cond #( when s_plant_used_onece-nkk_manage is initial then tr_plant_selectable-nkk_manage else s_plant_used_onece-nkk_manage )
      when c_plant_group-factory    then cond #( when s_plant_used_onece-factory    is initial then tr_plant_selectable-factory    else s_plant_used_onece-factory )
      else value #( )
    ).
    loop at ltr_plant assigning field-symbol(<range_plant>).
      select SalesDocument,SalesDocumentItem,Plant,'SO' as doc_type
        from I_SalesDocumentItem with privileged access
        where Plant = @<range_plant>-low
        into table @rt_sales_document_item up to @im_count rows."#EC CI_NOORDER
      if lines( rt_sales_document_item ) = im_count.
        set_used_once( im_group = im_group im_plant = rt_sales_document_item[ 1 ]-plant )."#EC CI_NOORDER
        exit.
      endif.
    endloop.
  endmethod.

  method sales_document_seller.
    rt_sales_document_item = sales_document( im_group = c_plant_group-seller im_count = im_count ).
  endmethod.


  method sales_document_nkk_seller.
    rt_sales_document_item = sales_document( im_group = c_plant_group-nkk_seller im_count = im_count ).
  endmethod.


  method sales_document_nkk_manage.
    rt_sales_document_item = sales_document( im_group = c_plant_group-nkk_manage im_count = im_count ).
  endmethod.


  method sales_document_factory.
    rt_sales_document_item = sales_document( im_group = c_plant_group-factory im_count = im_count ).
  endmethod.


  method purchase_request.
    data ltr_plant like tr_plant_selectable-seller.
    ltr_plant = switch #( im_group
      when c_plant_group-seller     then cond #( when s_plant_used_onece-seller     is initial then tr_plant_selectable-seller     else s_plant_used_onece-seller )
      when c_plant_group-nkk_seller then cond #( when s_plant_used_onece-nkk_seller is initial then tr_plant_selectable-nkk_seller else s_plant_used_onece-nkk_seller )
      when c_plant_group-nkk_manage then cond #( when s_plant_used_onece-nkk_manage is initial then tr_plant_selectable-nkk_manage else s_plant_used_onece-nkk_manage )
      when c_plant_group-factory    then cond #( when s_plant_used_onece-factory    is initial then tr_plant_selectable-factory    else s_plant_used_onece-factory )
      else value #( )
    ).
    loop at ltr_plant assigning field-symbol(<range_plant>).
      select PurchaseRequisition,PurchaseRequisitionItem,Plant,'PR' as doc_type
        from I_PurchaseRequisitionItemAPI01 with privileged access
        where Plant = @<range_plant>-low
        into table @rt_purchase_request_item up to @im_count rows."#EC CI_NOORDER
      if lines( rt_purchase_request_item ) = im_count.
        set_used_once( im_group = im_group im_plant = rt_purchase_request_item[ 1 ]-plant )."#EC CI_NOORDER
        exit.
      endif.
    endloop.
  endmethod.


  method purchase_request_seller.
    rt_purchase_request_item = purchase_request( im_group = c_plant_group-seller im_count = im_count ).
  endmethod.


  method purchase_request_nkk_seller.
    rt_purchase_request_item = purchase_request( im_group = c_plant_group-nkk_seller im_count = im_count ).
  endmethod.


  method purchase_request_nkk_manage.
    rt_purchase_request_item = purchase_request( im_group = c_plant_group-nkk_manage im_count = im_count ).
  endmethod.


  method purchase_request_factory.
    rt_purchase_request_item = purchase_request( im_group = c_plant_group-factory im_count = im_count ).
  endmethod.


  method purchase_order.
    data ltr_plant like tr_plant_selectable-seller.
    ltr_plant = switch #( im_group
      when c_plant_group-seller     then cond #( when s_plant_used_onece-seller     is initial then tr_plant_selectable-seller     else s_plant_used_onece-seller )
      when c_plant_group-nkk_seller then cond #( when s_plant_used_onece-nkk_seller is initial then tr_plant_selectable-nkk_seller else s_plant_used_onece-nkk_seller )
      when c_plant_group-nkk_manage then cond #( when s_plant_used_onece-nkk_manage is initial then tr_plant_selectable-nkk_manage else s_plant_used_onece-nkk_manage )
      when c_plant_group-factory    then cond #( when s_plant_used_onece-factory    is initial then tr_plant_selectable-factory    else s_plant_used_onece-factory )
      else value #( )
    ).
    loop at ltr_plant assigning field-symbol(<range_plant>).
      select PurchaseOrder,PurchaseOrderItem,Plant,'PO' as doc_type
        from I_PurchaseOrderItemAPI01 with privileged access
        where Plant = @<range_plant>-low
        into table @rt_purchase_order_item up to @im_count rows."#EC CI_NOORDER
      if lines( rt_purchase_order_item ) = im_count.
        set_used_once( im_group = im_group im_plant = rt_purchase_order_item[ 1 ]-plant )."#EC CI_NOORDER
        exit.
      endif.
    endloop.
  endmethod.


  method purchase_order_seller.
    rt_purchase_order_item = purchase_order( im_group = c_plant_group-seller im_count = im_count ).
  endmethod.


  method purchase_order_nkk_seller.
    rt_purchase_order_item = purchase_order( im_group = c_plant_group-nkk_seller im_count = im_count ).
  endmethod.


  method purchase_order_nkk_manage.
    rt_purchase_order_item = purchase_order( im_group = c_plant_group-nkk_manage im_count = im_count ).
  endmethod.


  method purchase_order_factory.
    rt_purchase_order_item = purchase_order( im_group = c_plant_group-factory im_count = im_count ).
  endmethod.


  method planned_order.
    data ltr_plant like tr_plant_selectable-seller.
    ltr_plant = switch #( im_group
      when c_plant_group-seller     then cond #( when s_plant_used_onece-seller     is initial then tr_plant_selectable-seller     else s_plant_used_onece-seller )
      when c_plant_group-nkk_seller then cond #( when s_plant_used_onece-nkk_seller is initial then tr_plant_selectable-nkk_seller else s_plant_used_onece-nkk_seller )
      when c_plant_group-nkk_manage then cond #( when s_plant_used_onece-nkk_manage is initial then tr_plant_selectable-nkk_manage else s_plant_used_onece-nkk_manage )
      when c_plant_group-factory    then cond #( when s_plant_used_onece-factory    is initial then tr_plant_selectable-factory    else s_plant_used_onece-factory )
      else value #( )
    ).
    loop at ltr_plant assigning field-symbol(<range_plant>).
      select PlannedOrder,'000000' as item,ProductionPlant,'MR' as doc_type
        from I_PlannedOrder with privileged access
        where ProductionPlant = @<range_plant>-low
        into table @rt_planned_order up to @im_count rows."#EC CI_NOORDER
      if lines( rt_planned_order ) = im_count.
        set_used_once( im_group = im_group im_plant = rt_planned_order[ 1 ]-plant )."#EC CI_NOORDER
        exit.
      endif.
    endloop.
  endmethod.


  method planned_order_factory.
    rt_planned_order = planned_order( im_group = c_plant_group-factory im_count = im_count ).
  endmethod.


  method manufacturing_order.
    data ltr_plant like tr_plant_selectable-seller.
    ltr_plant = switch #( im_group
      when c_plant_group-seller     then cond #( when s_plant_used_onece-seller     is initial then tr_plant_selectable-seller     else s_plant_used_onece-seller )
      when c_plant_group-nkk_seller then cond #( when s_plant_used_onece-nkk_seller is initial then tr_plant_selectable-nkk_seller else s_plant_used_onece-nkk_seller )
      when c_plant_group-nkk_manage then cond #( when s_plant_used_onece-nkk_manage is initial then tr_plant_selectable-nkk_manage else s_plant_used_onece-nkk_manage )
      when c_plant_group-factory    then cond #( when s_plant_used_onece-factory    is initial then tr_plant_selectable-factory    else s_plant_used_onece-factory )
      else value #( )
    ).
    loop at ltr_plant assigning field-symbol(<range_plant>).
      select ManufacturingOrder,'000000' as item,ProductionPlant,'MO' as doc_type
        from I_ManufacturingOrder with privileged access
        where ProductionPlant = @<range_plant>-low
        into table @rt_manufacturing_order up to @im_count rows."#EC CI_NOORDER
      if lines( rt_manufacturing_order ) = im_count.
        set_used_once( im_group = im_group im_plant = rt_manufacturing_order[ 1 ]-plant )."#EC CI_NOORDER
        exit.
      endif.
    endloop.
  endmethod.


  method manufacturing_order_factory.
    rt_manufacturing_order = manufacturing_order( im_group = c_plant_group-factory im_count = im_count ).
  endmethod.

endclass.


"! テストダブル投入データ生成 [ 伝票紐付(一覧)APS ]<br>
class lcl_testdata_generator definition.
  public section.
    types:
      ty_t_zp92502t   type standard table of zp92502t with default key,
      ty_t_zv90201t   type standard table of zv90201t with default key,
      ty_t_zv90202t   type standard table of zv90202t with default key.
    constants:
      begin of c_doc_type,
        pir           type zz_doccategory value 'PIR',
        sales         type zz_doccategory value 'SO',
        request       type zz_doccategory value 'PR',
        purchase      type zz_doccategory value 'PO',
        plan          type zz_doccategory value 'MR',
        manufact      type zz_doccategory value 'MO',
      end   of c_doc_type,
      c_no_date       type d              value '00000000'.
    methods:
      constructor,
      "! まとめ出荷ヘッダ
      get_combine_shipping_header
        returning value(rt_header) type ty_t_zv90201t
        ,
      "! まとめ出荷明細
      get_combine_shipping_item
        returning value(rt_item)   type ty_t_zv90202t
        ,
      "! Dropship/在庫品/有償/APS連携1日目<br>
      dropship_instock_paid_day1
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/有償/APS連携2日目<br>
      dropship_instock_paid_day2
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/有償/APS連携3日目<br>
      dropship_instock_paid_day3
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/有償/APS連携1日目/NSA導入前<br>
      dropship_instock_paid_day1_nsa
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/有償/APS連携2日目/NSA導入前<br>
      dropship_instock_paid_day2_nsa
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/有償/APS連携3日目/NSA導入前<br>
      dropship_instock_paid_day3_nsa
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/無償/APS連携1日目<br>
      dropship_instock_free_day1
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! Dropship/在庫品/無償/APS連携2日目<br>
      dropship_instock_free_day2
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! 二国間取引/在庫品/有償/APS連携1日目<br>
      counties2_instock_paid_day1
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! 二国間取引/在庫品/有償/APS連携2日目<br>
      counties2_instock_paid_day2
        returning value(rt_document_flow) type ty_t_zp92502t
        ,
      "! 二国間取引/在庫品/有償/APS連携3日目<br>
      counties2_instock_paid_day3
        returning value(rt_document_flow) type ty_t_zp92502t
        .
  private section.
    data:
      t_combine_shipping_header type standard table of zv90201t with default key,
      t_combine_shipping_item   type standard table of zv90202t with default key,
      ro_generator              type ref to lcl_realdata_selector.
    methods:
      set_combine_shipping importing
        im_sales type zv90202t-salesdocument
        im_item  type zv90202t-salesdocumentitem.
endclass.


class lcl_testdata_generator implementation.

  method constructor.
    ro_generator = new #( ).
  endmethod.


  method set_combine_shipping.
    data(lt_any_number)  = ro_generator->any_document_item( 2 ).
    data(lv_invoice_1st) = lt_any_number[ 1 ]-document.
    data(lv_invoice_2nd) = lt_any_number[ 2 ]-document.
    append value #( client  = sy-mandt
      combineshippingid     = lv_invoice_1st
      combineshippingid2nd  = lv_invoice_2nd
    ) to t_combine_shipping_header.
    append value #( client  = sy-mandt
      combineshippingid     = lv_invoice_1st
      salesdocument         = im_sales
      salesdocumentitem     = im_item
    ) to t_combine_shipping_item.
  endmethod.


  method get_combine_shipping_header.
    rt_header = t_combine_shipping_header.
  endmethod.


  method get_combine_shipping_item.
    rt_item   = t_combine_shipping_item.
  endmethod.


  method dropship_instock_paid_day1.
    data(lt_seller_sales)       = ro_generator->sales_document_seller( ).
    data(lt_seller_request)     = ro_generator->purchase_request_seller( ).
    data(lt_nkk_manage_request) = ro_generator->purchase_request_nkk_manage( ).
    data(lt_factory_planned)    = ro_generator->planned_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: 海外販社-受注
**********************************************************************
        topfromdocument         = lt_seller_sales[ 1 ]-document
        topfromdocumentitem     = lt_seller_sales[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_seller_sales[ 1 ]-plant
        topfromdocumenttypecode = lt_seller_sales[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: 海外販社-受注 -> To: 海外販社-依頼
**********************************************************************
        (
          fromdocument          = lt_seller_sales[ 1 ]-document   todocument          = lt_seller_request[ 1 ]-document
          fromdocumentitem      = lt_seller_sales[ 1 ]-item       todocumentitem      = lt_seller_request[ 1 ]-item
          fromdocumentplant     = lt_seller_sales[ 1 ]-plant      todocumentplant     = lt_seller_request[ 1 ]-plant
          fromdocumenttypecode  = lt_seller_sales[ 1 ]-doc_type   todocumenttypecode  = lt_seller_request[ 1 ]-doc_type
        )
**********************************************************************
*       From: 海外販社-依頼 -> To: NKK管理-依頼
**********************************************************************
        (
          fromdocument          = lt_seller_request[ 1 ]-document   todocument          = lt_nkk_manage_request[ 1 ]-document
          fromdocumentitem      = lt_seller_request[ 1 ]-item       todocumentitem      = lt_nkk_manage_request[ 1 ]-item
          fromdocumentplant     = lt_seller_request[ 1 ]-plant      todocumentplant     = lt_nkk_manage_request[ 1 ]-plant
          fromdocumenttypecode  = lt_seller_request[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_request[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-依頼 -> To: グループ工場-計画手配
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_request[ 1 ]-document   todocument          = lt_factory_planned[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_request[ 1 ]-item       todocumentitem      = lt_factory_planned[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_request[ 1 ]-plant      todocumentplant     = lt_factory_planned[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_request[ 1 ]-doc_type   todocumenttypecode  = lt_factory_planned[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
*    set_combine_shipping( ).
  endmethod.


  method dropship_instock_paid_day2.
    data(lt_seller_sales)           = ro_generator->sales_document_seller( ).
    data(lt_seller_purchase)        = ro_generator->purchase_order_seller( ).
    data(lt_nkk_manage_sales)       = ro_generator->sales_document_nkk_manage( ).
    data(lt_nkk_manage_purchase)    = ro_generator->purchase_order_nkk_manage( ).
    data(lt_factory_sales)          = ro_generator->sales_document_factory( ).
    data(lt_factory_manufacturing)  = ro_generator->manufacturing_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: 海外販社-受注
**********************************************************************
        topfromdocument         = lt_seller_sales[ 1 ]-document
        topfromdocumentitem     = lt_seller_sales[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_seller_sales[ 1 ]-plant
        topfromdocumenttypecode = lt_seller_sales[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: 海外販社-受注 -> To: 海外販社-購買
**********************************************************************
        (
          fromdocument          = lt_seller_sales[ 1 ]-document   todocument          = lt_seller_purchase[ 1 ]-document
          fromdocumentitem      = lt_seller_sales[ 1 ]-item       todocumentitem      = lt_seller_purchase[ 1 ]-item
          fromdocumentplant     = lt_seller_sales[ 1 ]-plant      todocumentplant     = lt_seller_purchase[ 1 ]-plant
          fromdocumenttypecode  = lt_seller_sales[ 1 ]-doc_type   todocumenttypecode  = lt_seller_purchase[ 1 ]-doc_type
        )
**********************************************************************
*       From: 海外販社-購買 -> To: NKK管理-受注
**********************************************************************
        (
          fromdocument          = lt_seller_purchase[ 1 ]-document   todocument          = lt_nkk_manage_sales[ 1 ]-document
          fromdocumentitem      = lt_seller_purchase[ 1 ]-item       todocumentitem      = lt_nkk_manage_sales[ 1 ]-item
          fromdocumentplant     = lt_seller_purchase[ 1 ]-plant      todocumentplant     = lt_nkk_manage_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_seller_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-受注 -> To: NKK管理-購買
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_sales[ 1 ]-document   todocument          = lt_nkk_manage_purchase[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_sales[ 1 ]-item       todocumentitem      = lt_nkk_manage_purchase[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_sales[ 1 ]-plant      todocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-購買 -> To: グループ工場-受注
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_purchase[ 1 ]-document   todocument          = lt_factory_sales[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_purchase[ 1 ]-item       todocumentitem      = lt_factory_sales[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant      todocumentplant     = lt_factory_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_factory_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: グループ工場-受注 -> To: グループ工場-製造指図
**********************************************************************
        (
          fromdocument          = lt_factory_sales[ 1 ]-document   todocument          = lt_factory_manufacturing[ 1 ]-document
          fromdocumentitem      = lt_factory_sales[ 1 ]-item       todocumentitem      = lt_factory_manufacturing[ 1 ]-item
          fromdocumentplant     = lt_factory_sales[ 1 ]-plant      todocumentplant     = lt_factory_manufacturing[ 1 ]-plant
          fromdocumenttypecode  = lt_factory_sales[ 1 ]-doc_type   todocumenttypecode  = lt_factory_manufacturing[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method dropship_instock_paid_day3.
**********************************************************************
*   Dropship/在庫品/有償/APS連携2日目
**********************************************************************
    rt_document_flow = dropship_instock_paid_day2( ).
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
    try.
      set_combine_shipping(
        im_sales  = conv #( rt_document_flow[ 5 ]-fromdocument )
        im_item   = conv #( rt_document_flow[ 5 ]-fromdocumentitem )
      ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method dropship_instock_paid_day1_nsa.
    data(lt_nkk_manage_sales)   = ro_generator->sales_document_nkk_manage( ).
    data(lt_nkk_manage_request) = ro_generator->purchase_request_nkk_manage( ).
    data(lt_factory_planned)    = ro_generator->planned_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: NKK管理-受注
**********************************************************************
        topfromdocument         = lt_nkk_manage_sales[ 1 ]-document
        topfromdocumentitem     = lt_nkk_manage_sales[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_nkk_manage_sales[ 1 ]-plant
        topfromdocumenttypecode = lt_nkk_manage_sales[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: NKK管理-受注 -> To: NKK管理-依頼
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_sales[ 1 ]-document   todocument          = lt_nkk_manage_request[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_sales[ 1 ]-item       todocumentitem      = lt_nkk_manage_request[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_sales[ 1 ]-plant      todocumentplant     = lt_nkk_manage_request[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_request[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-依頼 -> To: グループ工場-計画手配
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_request[ 1 ]-document   todocument          = lt_factory_planned[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_request[ 1 ]-item       todocumentitem      = lt_factory_planned[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_request[ 1 ]-plant      todocumentplant     = lt_factory_planned[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_request[ 1 ]-doc_type   todocumenttypecode  = lt_factory_planned[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
*    set_combine_shipping( ).
  endmethod.


  method dropship_instock_paid_day2_nsa.
    data(lt_nkk_manage_sales)     = ro_generator->sales_document_nkk_manage( ).
    data(lt_nkk_manage_purchase)  = ro_generator->purchase_order_nkk_manage( ).
    data(lt_factory_sales)        = ro_generator->sales_document_factory( ).
    data(lt_factory_manufacture)  = ro_generator->manufacturing_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: NKK管理-受注
**********************************************************************
        topfromdocument         = lt_nkk_manage_sales[ 1 ]-document
        topfromdocumentitem     = lt_nkk_manage_sales[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_nkk_manage_sales[ 1 ]-plant
        topfromdocumenttypecode = lt_nkk_manage_sales[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: NKK管理-受注 -> To: NKK管理-購買
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_sales[ 1 ]-document   todocument          = lt_nkk_manage_purchase[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_sales[ 1 ]-item       todocumentitem      = lt_nkk_manage_purchase[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_sales[ 1 ]-plant      todocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-購買 -> To: グループ工場-受注
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_purchase[ 1 ]-document   todocument          = lt_factory_sales[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_purchase[ 1 ]-item       todocumentitem      = lt_factory_sales[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant      todocumentplant     = lt_factory_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_factory_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: グループ工場-受注 -> To: グループ工場-製造指図
**********************************************************************
        (
          fromdocument          = lt_factory_sales[ 1 ]-document   todocument          = lt_factory_manufacture[ 1 ]-document
          fromdocumentitem      = lt_factory_sales[ 1 ]-item       todocumentitem      = lt_factory_manufacture[ 1 ]-item
          fromdocumentplant     = lt_factory_sales[ 1 ]-plant      todocumentplant     = lt_factory_manufacture[ 1 ]-plant
          fromdocumenttypecode  = lt_factory_sales[ 1 ]-doc_type   todocumenttypecode  = lt_factory_manufacture[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
*    set_combine_shipping( ).
  endmethod.


  method dropship_instock_paid_day3_nsa.
**********************************************************************
*   Dropship/在庫品/有償/NSA導入前/APS連携3日目
**********************************************************************
    rt_document_flow = dropship_instock_paid_day2_nsa( ).
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
    try.
      set_combine_shipping(
        im_sales  = conv #( rt_document_flow[ 3 ]-fromdocument )
        im_item   = conv #( rt_document_flow[ 3 ]-fromdocumentitem )
      ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method dropship_instock_free_day1.
    data(lt_seller_purchase)      = ro_generator->purchase_order_seller( ).
    data(lt_nkk_manage_sales)     = ro_generator->sales_document_nkk_manage( ).
    data(lt_nkk_manage_purchase)  = ro_generator->purchase_order_nkk_manage( ).
    data(lt_factory_sales)        = ro_generator->sales_document_factory( ).
    data(lt_factory_planned)      = ro_generator->planned_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: 海外販社-発注
**********************************************************************
        topfromdocument         = lt_seller_purchase[ 1 ]-document
        topfromdocumentitem     = lt_seller_purchase[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_seller_purchase[ 1 ]-plant
        topfromdocumenttypecode = lt_seller_purchase[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: 海外販社-発注 -> To: NKK管理-受注
**********************************************************************
        (
          fromdocument          = lt_seller_purchase[ 1 ]-document   todocument          = lt_nkk_manage_sales[ 1 ]-document
          fromdocumentitem      = lt_seller_purchase[ 1 ]-item       todocumentitem      = lt_nkk_manage_sales[ 1 ]-item
          fromdocumentplant     = lt_seller_purchase[ 1 ]-plant      todocumentplant     = lt_nkk_manage_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_seller_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-受注 -> To: NKK管理-発注
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_sales[ 1 ]-document   todocument          = lt_nkk_manage_purchase[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_sales[ 1 ]-item       todocumentitem      = lt_nkk_manage_purchase[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_sales[ 1 ]-plant      todocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-発注 -> To: グループ工場-受注
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_purchase[ 1 ]-document   todocument          = lt_factory_sales[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_purchase[ 1 ]-item       todocumentitem      = lt_factory_sales[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant      todocumentplant     = lt_factory_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_factory_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: グループ工場-受注 -> To: グループ工場-計画手配
**********************************************************************
        (
          fromdocument          = lt_factory_sales[ 1 ]-document   todocument          = lt_factory_planned[ 1 ]-document
          fromdocumentitem      = lt_factory_sales[ 1 ]-item       todocumentitem      = lt_factory_planned[ 1 ]-item
          fromdocumentplant     = lt_factory_sales[ 1 ]-plant      todocumentplant     = lt_factory_planned[ 1 ]-plant
          fromdocumenttypecode  = lt_factory_sales[ 1 ]-doc_type   todocumenttypecode  = lt_factory_planned[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
*    set_combine_shipping( ).
  endmethod.


  method dropship_instock_free_day2.
    data(lt_seller_purchase)      = ro_generator->purchase_order_seller( ).
    data(lt_nkk_manage_sales)     = ro_generator->sales_document_nkk_manage( ).
    data(lt_nkk_manage_purchase)  = ro_generator->purchase_order_nkk_manage( ).
    data(lt_factory_sales)        = ro_generator->sales_document_factory( ).
    data(lt_factory_manufacture)  = ro_generator->manufacturing_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: 海外販社-発注
**********************************************************************
        topfromdocument         = lt_seller_purchase[ 1 ]-document
        topfromdocumentitem     = lt_seller_purchase[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_seller_purchase[ 1 ]-plant
        topfromdocumenttypecode = lt_seller_purchase[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: 海外販社-発注 -> To: NKK管理-受注
**********************************************************************
        (
          fromdocument          = lt_seller_purchase[ 1 ]-document   todocument          = lt_nkk_manage_sales[ 1 ]-document
          fromdocumentitem      = lt_seller_purchase[ 1 ]-item       todocumentitem      = lt_nkk_manage_sales[ 1 ]-item
          fromdocumentplant     = lt_seller_purchase[ 1 ]-plant      todocumentplant     = lt_nkk_manage_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_seller_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-受注 -> To: NKK管理-発注
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_sales[ 1 ]-document   todocument          = lt_nkk_manage_purchase[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_sales[ 1 ]-item       todocumentitem      = lt_nkk_manage_purchase[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_sales[ 1 ]-plant      todocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK管理-発注 -> To: グループ工場-受注
**********************************************************************
        (
          fromdocument          = lt_nkk_manage_purchase[ 1 ]-document   todocument          = lt_factory_sales[ 1 ]-document
          fromdocumentitem      = lt_nkk_manage_purchase[ 1 ]-item       todocumentitem      = lt_factory_sales[ 1 ]-item
          fromdocumentplant     = lt_nkk_manage_purchase[ 1 ]-plant      todocumentplant     = lt_factory_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_manage_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_factory_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: グループ工場-受注 -> To: グループ工場-製造指図
**********************************************************************
        (
          fromdocument          = lt_factory_sales[ 1 ]-document   todocument          = lt_factory_manufacture[ 1 ]-document
          fromdocumentitem      = lt_factory_sales[ 1 ]-item       todocumentitem      = lt_factory_manufacture[ 1 ]-item
          fromdocumentplant     = lt_factory_sales[ 1 ]-plant      todocumentplant     = lt_factory_manufacture[ 1 ]-plant
          fromdocumenttypecode  = lt_factory_sales[ 1 ]-doc_type   todocumenttypecode  = lt_factory_manufacture[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: グループ工場-受注
**********************************************************************
    try.
      set_combine_shipping( im_sales = lt_factory_sales[ 1 ]-document im_item = lt_factory_sales[ 1 ]-item ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method counties2_instock_paid_day1.
    data(lt_nkk_seller_sales)   = ro_generator->sales_document_nkk_seller( ).
    data(lt_nkk_seller_request) = ro_generator->purchase_request_nkk_seller( ).
    data(lt_factory_planned)    = ro_generator->planned_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: NKK販売-受注
**********************************************************************
        topfromdocument         = lt_nkk_seller_sales[ 1 ]-document
        topfromdocumentitem     = lt_nkk_seller_sales[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_nkk_seller_sales[ 1 ]-plant
        topfromdocumenttypecode = lt_nkk_seller_sales[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: NKK販売-受注 -> To: NKK販売-依頼
**********************************************************************
        (
          fromdocument          = lt_nkk_seller_sales[ 1 ]-document   todocument          = lt_nkk_seller_request[ 1 ]-document
          fromdocumentitem      = lt_nkk_seller_sales[ 1 ]-item       todocumentitem      = lt_nkk_seller_request[ 1 ]-item
          fromdocumentplant     = lt_nkk_seller_sales[ 1 ]-plant      todocumentplant     = lt_nkk_seller_request[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_seller_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_seller_request[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK販売-依頼 -> To: グループ工場-計画手配
**********************************************************************
        (
          fromdocument          = lt_nkk_seller_request[ 1 ]-document   todocument          = lt_factory_planned[ 1 ]-document
          fromdocumentitem      = lt_nkk_seller_request[ 1 ]-item       todocumentitem      = lt_factory_planned[ 1 ]-item
          fromdocumentplant     = lt_nkk_seller_request[ 1 ]-plant      todocumentplant     = lt_factory_planned[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_seller_request[ 1 ]-doc_type   todocumenttypecode  = lt_factory_planned[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
*    try.
*      set_combine_shipping( im_sales = [ 1 ]-document im_item = [ 1 ]-item ).
*    catch cx_sy_itab_line_not_found ##NO_HANDLER.
*    endtry.
  endmethod.


  method counties2_instock_paid_day2.
    data(lt_nkk_seller_sales)     = ro_generator->sales_document_nkk_seller( ).
    data(lt_nkk_seller_purchase)  = ro_generator->purchase_order_nkk_seller( ).
    data(lt_factory_sales)        = ro_generator->sales_document_factory( ).
    data(lt_factory_manufacture)  = ro_generator->manufacturing_order_factory( ).
    try.
      rt_document_flow = value #( client = sy-mandt
**********************************************************************
*       Top: NKK販売-受注
**********************************************************************
        topfromdocument         = lt_nkk_seller_sales[ 1 ]-document
        topfromdocumentitem     = lt_nkk_seller_sales[ 1 ]-item
        topfromworkingdaydate   = c_no_date
        topfromdocumentplant    = lt_nkk_seller_sales[ 1 ]-plant
        topfromdocumenttypecode = lt_nkk_seller_sales[ 1 ]-doc_type
        fromworkingdaydate      = c_no_date
**********************************************************************
*       From: NKK販売-受注 -> To: NKK販売-購買
**********************************************************************
        (
          fromdocument          = lt_nkk_seller_sales[ 1 ]-document   todocument          = lt_nkk_seller_purchase[ 1 ]-document
          fromdocumentitem      = lt_nkk_seller_sales[ 1 ]-item       todocumentitem      = lt_nkk_seller_purchase[ 1 ]-item
          fromdocumentplant     = lt_nkk_seller_sales[ 1 ]-plant      todocumentplant     = lt_nkk_seller_purchase[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_seller_sales[ 1 ]-doc_type   todocumenttypecode  = lt_nkk_seller_purchase[ 1 ]-doc_type
        )
**********************************************************************
*       From: NKK販売-購買 -> To: グループ工場-受注
**********************************************************************
        (
          fromdocument          = lt_nkk_seller_purchase[ 1 ]-document   todocument          = lt_factory_sales[ 1 ]-document
          fromdocumentitem      = lt_nkk_seller_purchase[ 1 ]-item       todocumentitem      = lt_factory_sales[ 1 ]-item
          fromdocumentplant     = lt_nkk_seller_purchase[ 1 ]-plant      todocumentplant     = lt_factory_sales[ 1 ]-plant
          fromdocumenttypecode  = lt_nkk_seller_purchase[ 1 ]-doc_type   todocumenttypecode  = lt_factory_sales[ 1 ]-doc_type
        )
**********************************************************************
*       From: グループ工場-受注 -> To: グループ工場-製造指図
**********************************************************************
        (
          fromdocument          = lt_factory_sales[ 1 ]-document   todocument          = lt_factory_manufacture[ 1 ]-document
          fromdocumentitem      = lt_factory_sales[ 1 ]-item       todocumentitem      = lt_factory_manufacture[ 1 ]-item
          fromdocumentplant     = lt_factory_sales[ 1 ]-plant      todocumentplant     = lt_factory_manufacture[ 1 ]-plant
          fromdocumenttypecode  = lt_factory_sales[ 1 ]-doc_type   todocumenttypecode  = lt_factory_manufacture[ 1 ]-doc_type
        )
      )."#EC CI_NOORDER
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
**********************************************************************
*   まとめ出荷登録: *
**********************************************************************
*    try.
*      set_combine_shipping( im_sales = [ 1 ]-document im_item = [ 1 ]-item ).
*    catch cx_sy_itab_line_not_found ##NO_HANDLER.
*    endtry.
  endmethod.


  method counties2_instock_paid_day3.
**********************************************************************
*   二国間取引/在庫品/有償/APS連携2日目
**********************************************************************
    rt_document_flow = counties2_instock_paid_day2( ).
**********************************************************************
*   まとめ出荷登録: グループ工場-受注
**********************************************************************
    try.
      set_combine_shipping(
        im_sales = conv #( rt_document_flow[ 3 ]-fromdocument )
        im_item  = conv #( rt_document_flow[ 3 ]-fromdocumentitem )
      ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.

endclass.


"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-１日目 = Day1 </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_3ip_day1 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        seller_sales        type zcl_logi_document_tracking=>ty_t_document_tracking,
        seller_request      type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_request  type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_planned     type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3ip_day1 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_paid_day1( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_request = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_request = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_planned = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID( ).

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID2nd( ).

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-依頼 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_seller)      = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_nkk_manage)  = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument(  ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_seller msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_seller msg = |海外販社-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_nkk_manage msg = |NKK管理-依頼 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_factory msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    data(exp) = value I_ManufacturingOrder-ManufacturingOrder( ).

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-２日目 = Day2 </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_3ip_day2 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        seller_sales        type zcl_logi_document_tracking=>ty_t_document_tracking,
        seller_purchase     type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3ip_day2 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_paid_day2( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID( ).

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID2nd( ).

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_seller)      = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_nkk_manage)  = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 3 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_seller msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_seller msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    try.
      data(exp_seller)      = value I_ManufacturingOrder-ManufacturingOrder(  ).
      data(exp_nkk_manage)  = value I_ManufacturingOrder-ManufacturingOrder(  ).
      data(exp_factory)     = value I_ManufacturingOrder-ManufacturingOrder( t_document_flow[ 5 ]-todocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_seller msg = |海外販社-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_seller msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-３日目 = Day3 </li>
"! <li> まとめ出荷 = グループ工場-受注 </li>
"! </ul>
class ltcl_3ip_day3 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        seller_sales        type zcl_logi_document_tracking=>ty_t_document_tracking,
        seller_purchase     type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing.
*      get_root_sales_doc_item       for testing,
*      get_sales_item_in_prev_plant  for testing,
*      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3ip_day3 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_paid_day3( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( t_cs_header[ 1 ]-combineshippingid ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( t_cs_header[ 1 ]-combineshippingid2nd ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking6>).
      try.
        data(act6) = <tracking6>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act6 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-１日目 = Day1 </li>
"! <li> NSA導入前 = nsa </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_3ip_day1_nsa definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_request  type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_planned     type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3ip_day1_nsa implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_paid_day1_nsa( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_request = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_planned = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found
      ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID( ).

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID2nd( ).

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
      data(exp_nkk_manage)  = value I_SalesDocumentItem-SalesDocument(  ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_manage msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    data(exp) = value I_ManufacturingOrder-ManufacturingOrder( ).

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-2日目 = Day2 </li>
"! <li> NSA導入前 = nsa </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_3ip_day2_nsa definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3ip_day2_nsa implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_paid_day2_nsa( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found
      ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID( ).

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID2nd( ).

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_nkk_manage)  = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    try.
      data(exp_nkk_manage)  = value I_ManufacturingOrder-ManufacturingOrder( ).
      data(exp_factory)     = value I_ManufacturingOrder-ManufacturingOrder( t_document_flow[ 3 ]-todocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-3日目 = Day3 </li>
"! <li> NSA導入前 = nsa </li>
"! <li> まとめ出荷 = グループ工場-受注 </li>
"! </ul>
class ltcl_3ip_day3_nsa definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing.
*      get_root_sales_doc_item       for testing,
*      get_sales_item_in_prev_plant  for testing,
*      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3ip_day3_nsa implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_paid_day3_nsa( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found
      ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( t_cs_header[ 1 ]-combineshippingid ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID2nd( t_cs_header[ 1 ]-combineshippingid2nd ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 無償 = Free </li>
"! <li> APS連携-１日目 = Day1 </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_3if_day1 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        seller_purchase     type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_planned     type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3if_day1 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_free_day1( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_planned = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID( ).

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    data(exp) = value zi_vf903_01-CombineShippingID2nd( ).

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument(  ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_seller)      = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_nkk_manage)  = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 2 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_seller msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp_factory msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    data(exp) = value I_ManufacturingOrder-ManufacturingOrder( ).

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> Dropship = trade in 3countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 無償 = Free </li>
"! <li> APS連携-２日目 = Day2 </li>
"! <li> まとめ出荷 = グループ工場-受注 </li>
"! </ul>
class ltcl_3if_day2 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        seller_purchase     type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_manage_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_3if_day2 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->dropship_instock_free_day2( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-seller_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_manage_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( t_cs_header[ 1 ]-combineshippingid ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID2nd( t_cs_header[ 1 ]-combineshippingid2nd ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument(  ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_seller)      = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_nkk_manage)  = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 2 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_seller msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    try.
      data(exp_seller)      = value I_ManufacturingOrder-ManufacturingOrder( ).
      data(exp_nkk_manage)  = value I_ManufacturingOrder-ManufacturingOrder( ).
      data(exp_factory)     = value I_ManufacturingOrder-ManufacturingOrder( t_document_flow[ 4 ]-todocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-seller_purchase assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_seller msg = |海外販社-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_sales assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_manage msg = |NKK管理-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_manage_purchase assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_nkk_manage msg = |NKK管理-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act4 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking5>).
      try.
        data(act5) = <tracking5>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act5 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> 二国間取引 = trade in 2countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-１日目 = Day1 </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_2ip_day1 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        nkk_seller_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_seller_request  type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_planned     type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_2ip_day1 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->counties2_instock_paid_day1( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_seller_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_seller_request = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_planned = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID2nd( ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-依頼 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_nkk_seller)  = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_nkk_seller msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_seller msg = |NKK販売-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-計画手配 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    try.
      data(exp) = value I_ManufacturingOrder-ManufacturingOrder( ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_request assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-依頼 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_planned assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-計画手配 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> 二国間取引 = trade in 2countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-２日目 = Day2 </li>
"! <li> まとめ出荷 = なし </li>
"! </ul>
class ltcl_2ip_day2 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        nkk_seller_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_seller_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing,
      get_root_sales_doc_item       for testing,
      get_sales_item_in_prev_plant  for testing,
      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_2ip_day2 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->counties2_instock_paid_day2( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_seller_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_seller_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID2nd( ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      endtry.
    endloop.

  endmethod.


  method get_root_sales_doc_item.

    try.
      data(exp) = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_root_sales_doc_item( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_sales_item_in_prev_plant.

    try.
      data(exp_nkk_seller)  = value I_SalesDocumentItem-SalesDocument(  ).
      data(exp_factory)     = value I_SalesDocumentItem-SalesDocument( t_document_flow[ 1 ]-fromdocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_nkk_seller msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_seller msg = |NKK販売-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_sales_item_in_prev_plant( )-SalesDocument.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_manufacturing_in_plant.

    try.
      data(exp_nkk_seller)  = value I_ManufacturingOrder-ManufacturingOrder( ).
      data(exp_factory)     = value I_ManufacturingOrder-ManufacturingOrder( t_document_flow[ 3 ]-todocument ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp_nkk_seller msg = |NKK販売-受注 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
      catch cx_aia_static ##NO_HANDLER.
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp_nkk_seller msg = |NKK販売-購買 { sy-tabix }| ).
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_manufacturing_in_plant( )-ManufacturingOrder.
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp_factory msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.



"! <ul>
"! <li> 二国間取引 = trade in 2countries </li>
"! <li> 在庫品 = in-Stock </li>
"! <li> 有償 = Paid </li>
"! <li> APS連携-３日目 = Day3 </li>
"! <li> まとめ出荷 = グループ工場-受注 </li>
"! </ul>
class ltcl_2ip_day3 definition final for testing duration short risk level harmless.
  private section.
    class-data:
      begin of s_point,
        nkk_seller_sales    type zcl_logi_document_tracking=>ty_t_document_tracking,
        nkk_seller_purchase type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_sales       type zcl_logi_document_tracking=>ty_t_document_tracking,
        factory_manufacture type zcl_logi_document_tracking=>ty_t_document_tracking,
      end   of s_point.
    class-data:
      v_flow_line           type i value 0,
      t_document_flow       type lcl_testdata_generator=>ty_t_zp92502t,
      t_cs_header           type lcl_testdata_generator=>ty_t_zv90201t,
      t_cs_item             type lcl_testdata_generator=>ty_t_zv90202t,
      ro_test_data          type ref to lcl_testdata_generator,
      ro_environment        type ref to if_cds_test_environment.
    class-methods:
      class_setup           raising cx_aia_static,
      class_teardown.
    methods:
      get_1st_invoice               for testing,
      get_2nd_invoice               for testing.
*      get_root_sales_doc_item       for testing,
*      get_sales_item_in_prev_plant  for testing,
*      get_manufacturing_in_plant    for testing.
endclass.


class ltcl_2ip_day3 implementation.

  method class_setup.
**********************************************************************
*   テストデータ
**********************************************************************
    ro_test_data = new #( ).
    t_document_flow  = ro_test_data->counties2_instock_paid_day3( ).
    t_cs_header      = ro_test_data->get_combine_shipping_header( ).
    t_cs_item        = ro_test_data->get_combine_shipping_item( ).
**********************************************************************
*   テストダブル
**********************************************************************
    ro_environment = cl_cds_test_environment=>create_for_multiple_cds( value #(
      ( i_for_entity = 'ZI_PI925_01' i_dependency_list = value #( ( 'zp92502t' ) ) )  "伝票紐付（一覧）APS
      ( i_for_entity = 'ZI_VF903_01' i_dependency_list = value #( ( 'zv90201t' ) ) )  "まとめ出荷ヘッダ
      ( i_for_entity = 'ZI_VF903_02' i_dependency_list = value #( ( 'zv90202t' ) ) )  "まとめ出荷明細
    ) ).
    ro_environment->insert_test_data( t_document_flow ).
    ro_environment->insert_test_data( t_cs_header ).
    ro_environment->insert_test_data( t_cs_item ).
**********************************************************************
*   伝票追跡各ポイントでのインスタンス生成
**********************************************************************
    try.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_seller_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-nkk_seller_purchase = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
      endif.
      v_flow_line += 1.
      if line_exists( t_document_flow[ v_flow_line ] ).
        s_point-factory_sales = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-fromdocument
          im_base_document_item = t_document_flow[ v_flow_line ]-fromdocumentitem
        ).
        s_point-factory_manufacture = zcl_logi_document_tracking=>create(
          im_base_document      = t_document_flow[ v_flow_line ]-todocument
          im_base_document_item = t_document_flow[ v_flow_line ]-todocumentitem
        ).
      endif.
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.
  endmethod.


  method class_teardown.
    if ro_environment is bound.
      ro_environment->destroy( ).
    endif.
  endmethod.


  method get_1st_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID( t_cs_header[ 1 ]-combineshippingid ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_1st_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.


  method get_2nd_invoice.

    try.
      data(exp) = value zi_vf903_01-CombineShippingID2nd( t_cs_header[ 1 ]-combineshippingid2nd ).
    catch cx_sy_itab_line_not_found ##NO_HANDLER.
    endtry.

    loop at s_point-nkk_seller_sales assigning field-symbol(<tracking1>).
      try.
        data(act1) = <tracking1>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act1 exp = exp msg = |NKK販売-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-nkk_seller_purchase assigning field-symbol(<tracking2>).
      try.
        data(act2) = <tracking2>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act2 exp = exp msg = |NKK販売-購買 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_sales assigning field-symbol(<tracking3>).
      try.
        data(act3) = <tracking3>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-受注 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

    loop at s_point-factory_manufacture assigning field-symbol(<tracking4>).
      try.
        data(act4) = <tracking4>-ro_document_tracking->get_2nd_invoice( ).
        cl_abap_unit_assert=>assert_equals( act = act3 exp = exp msg = |グループ工場-製造指図 { sy-tabix }| ).
      catch cx_aia_static ##NO_HANDLER.
      endtry.
    endloop.

  endmethod.

endclass.
