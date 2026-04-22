class zcl_calculating_mfg_operations definition public final create private.
  public section.
    types:
      ty_date_range type range of d
      .
    class-methods:
      "! 作業区能力算出ファクトリーメソッド bｙ 製造指図
      "! @parameter im_mfg_order | 製造指図
      "! @parameter ro_runtime   | インスタンス
      create_by_manufacturing_order
        importing im_mfg_order      type I_ManufacturingOrder-ManufacturingOrder
        returning value(ro_runtime) type ref to zcl_calculating_mfg_operations
        raising zcx_no_data
        ,
      "! 作業区能力算出ファクトリーメソッド from 製造バージョン
      "! @parameter im_product            | 品目
      "! @parameter im_plant              | プラント
      "! @parameter im_version            | 製造バージョン
      "! @parameter ro_runtime            | インスタンス
      create_by_production_version
        importing
          im_product   type I_ProductionVersion-Material
          im_plant     type I_ProductionVersion-Plant
          im_version   type I_ProductionVersion-ProductionVersion
        returning value(ro_runtime) type ref to zcl_calculating_mfg_operations
        raising zcx_no_data
        .
    methods:
      "! 作業区能力集計
      "! @parameter rv_capacity_days | 全作業区能力[days]
      aggregate_standard_capacitiy
        returning value(rv_capacity_days) type int_numberofdays
        .
  protected section.
  private section.
    types:
      begin of ty_s_target_operation,
        sequence                      type I_MfgBOOOperationChangeState-BillOfOperationsSequence,
        operation                     type I_MfgBOOOperationChangeState-Operation_2,
        control_profile               type I_MfgBOOOperationChangeState-OperationControlProfile,
        workcenter_internal_id        type I_MfgBOOOperationChangeState-WorkCenterInternalID,
        workcenter_type_code          type I_MfgBOOOperationChangeState-WorkCenterTypeCode,
        standard_work_quantity2       type I_MfgBOOOperationChangeState-StandardWorkQuantity2,
        standard_work_quantity2_unit  type I_MfgBOOOperationChangeState-StandardWorkQuantityUnit2,
      end   of ty_s_target_operation.
    data:
      s_operations                    type I_MfgBillOfOperations,
      s_operation_sequence            type I_MfgBillOfOperationsSequence,
      t_operations_operation          type standard table of I_MfgBillOfOperationsOperation with default key,
      t_operation_change_state        type standard table of I_MfgBOOOperationChangeState with default key,
      t_work_center                   type standard table of I_WorkCenter with default key,
      t_capacity                      type standard table of I_Capacity with default key,
      t_mfg_operation                 type standard table of I_MfgOrderOperationWithStatus with default key.
    data:
      t_target_profile                type range of I_WorkCenter-OperationControlProfile,
      t_target_operation              type standard table of ty_s_target_operation with key sequence operation.
    methods:
      "! コンストラクタ
      "! @parameter is_prd_version        | true = 製造バージョンから作業区能力を算出する場合
      "! @parameter im_operation_type     | （製造バージョンに紐付く）タスクタイプ
      "! @parameter im_operation_group    | （製造バージョンに紐付く）タスクグループ
      "! @parameter im_operation_variant  | （製造バージョンに紐付く）タスクバリアント
      "! @parameter is_mfg_order          | true = 製造指図から作業区能力を算出する場合
      "! @parameter im_mfg_order          | 製造指図
      constructor importing
        is_prd_version                type abap_boolean default abap_false
        im_operation_type             type I_MfgBillOfOperations-BillOfOperationsType       optional
        im_operation_group            type I_MfgBillOfOperations-BillOfOperationsGroup      optional
        im_operation_variant          type I_MfgBillOfOperations-BillOfOperationsVariant    optional
        is_mfg_order                  type abap_boolean default abap_false
        im_mfg_order                  type I_ManufacturingOrderOperation-ManufacturingOrder optional
        ,
      "! 単位
      get_unit_of_measure
        importing im_unit             type I_UnitOfMeasure-UnitOfMeasure
        returning value(rs_unit)      type I_UnitOfMeasure
        ,
      "! 対象作業選択｜製造指図
      set_target_operations_by_mfg    importing
        im_mfg_order                  type I_ManufacturingOrderOperation-ManufacturingOrder
        ,
      "! 対象作業選択｜製造バージョン
      set_target_operations_by_ver    importing
        im_operation_type             type I_MfgBillOfOperations-BillOfOperationsType
        im_operation_group            type I_MfgBillOfOperations-BillOfOperationsGroup
        im_operation_variant          type I_MfgBillOfOperations-BillOfOperationsVariant
        .
ENDCLASS.



CLASS ZCL_CALCULATING_MFG_OPERATIONS IMPLEMENTATION.


  method create_by_manufacturing_order.
    select count(*) from I_ManufacturingOrder with privileged access
      where ManufacturingOrder = @im_mfg_order.
    if sy-subrc = 0.
      ro_runtime = new #(
        is_mfg_order = abap_true
        im_mfg_order = im_mfg_order
      ).
    else.
**********************************************************************
*     製造指図 &1 がありません
**********************************************************************
      raise exception type zcx_no_data
        exporting textid = value #( msgid = 'GPDMIGO' msgno = 002 attr1 = |{ im_mfg_order alpha = out }| ).
    endif.
  endmethod.


  method aggregate_standard_capacitiy.
    data(lv_all_capacity_days) = conv decfloat34( 0 ).
    loop at t_target_operation assigning field-symbol(<operation>).
      read table t_work_center into data(ls_work_center) with key WorkCenterInternalID = <operation>-workcenter_internal_id WorkCenterTypeCode = <operation>-workcenter_type_code.
      read table t_capacity    into data(ls_capacity)    with key CapacityInternalID   = ls_work_center-CapacityInternalID.
************************************************************************************************
*     単位変換条件｜[標準作業数量単位2] = [能力数量単位] であること
************************************************************************************************
      check <operation>-standard_work_quantity2_unit = ls_capacity-CapacityQuantityUnit.
      try.
************************************************************************************************
*       作業区能力[sec] = ( 終了時刻 - 開始時刻 - 休憩時間 ) * 個別能力 * 能力利用度[%]
************************************************************************************************
        data(lv_percent_int)  = conv i( ls_capacity-CapacityPlanUtilizationPercent ).
        data(lv_capacity_sec) = round(
          val   = ( ls_capacity-CapacityEndTimeID - ls_capacity-CapacityStartTimeID - ls_capacity-CapacityBreakDuration ) * ls_capacity-CapacityNumberOfCapacities * ( lv_percent_int / 100 )
          dec   = 3
          mode  = cl_abap_math=>round_down
        ).
************************************************************************************************
*       作業区能力[hour] = 作業区能力[sec] / ( SI単位への変換分子 / SI単位への変換分母 )[sec/hour]
************************************************************************************************
        data(ls_capacity_unit) = get_unit_of_measure( ls_capacity-CapacityQuantityUnit ).
        data(lv_capacity_hour) = round(
          val   = lv_capacity_sec / ( ls_capacity_unit-SIUnitCnvrsnRateNumerator / ls_capacity_unit-SIUnitCnvrsnRateDenominator )
          dec   = 3
          mode  = cl_abap_math=>round_down
        ).
************************************************************************************************
*       作業区能力[days] = 作業区能力[hour] / 標準作業数量2[hour/days]
************************************************************************************************
        data(lv_capacity_days) = round(
          val   = lv_capacity_hour / <operation>-standard_work_quantity2
          dec   = 3
          mode  = cl_abap_math=>round_down
        ).
        lv_all_capacity_days += lv_capacity_days.

      catch cx_sy_arithmetic_error into data(lx_arithmetic_error).
        data(lv_error_log)    = lx_arithmetic_error->get_text( ).
        lv_all_capacity_days  = 0.exit.
      endtry.
    endloop.
************************************************************************************************
*   全作業区能力[days] = 作業区能力1[days] + 作業区能力2[days] + ... 小数点以下切上
************************************************************************************************
    rv_capacity_days = round( val = lv_all_capacity_days dec = 0 mode = cl_abap_math=>round_up ).
  endmethod.


  method create_by_production_version.
    select single Material,Plant,ProductionVersion,BillOfOperationsType,BillOfOperationsGroup,BillOfOperationsVariant
      from I_ProductionVersion with privileged access
      where Material           = @im_product
        and Plant              = @im_plant
        and ProductionVersion  = @im_version
      into @data(ls_production_version).
    if sy-subrc = 0.
      ro_runtime = new #(
        is_prd_version         = abap_true
        im_operation_type      = ls_production_version-BillOfOperationsType
        im_operation_group     = ls_production_version-BillOfOperationsGroup
        im_operation_variant   = ls_production_version-BillOfOperationsVariant
      ).
    else.
**********************************************************************
*     製造バージョン & (品目 & プラント &) がありません
**********************************************************************
      raise exception type zcx_no_data
        exporting textid = value #( msgid = 'CK' msgno = 692 attr1 = |{ im_version }| attr2 = |{ im_product alpha = out }| attr3 = |{ im_plant }| ).
    endif.
  endmethod.


  method constructor.
**********************************************************************
*   製造工程表の作業変更ステータス｜作業選択 for 製造バージョン
**********************************************************************
    if is_prd_version = abap_true.
      set_target_operations_by_ver(
        im_operation_type     = im_operation_type
        im_operation_group    = im_operation_group
        im_operation_variant  = im_operation_variant
      ).
    endif.
**********************************************************************
*   製造工程表の作業変更ステータス｜作業選択 for 製造指図
**********************************************************************
    if is_mfg_order   = abap_true.
      set_target_operations_by_mfg( im_mfg_order ).
    endif.
**********************************************************************
*   作業区
**********************************************************************
    select * from I_WorkCenter with privileged access for all entries in @t_target_operation  "#EC CI_FAE_LINES_ENSURED #EC CI_FAE_NO_LINES_OK
      where WorkCenterInternalID      = @t_target_operation-workcenter_internal_id
        and WorkCenterTypeCode        = @t_target_operation-workcenter_type_code
      order by primary key into table @t_work_center.
**********************************************************************
*   能力ヘッダ｜標準利用可能能力
**********************************************************************
    select * from I_Capacity with privileged access for all entries in @t_work_center   "#EC CI_NO_TRANSFORM #EC CI_FAE_LINES_ENSURED #EC CI_FAE_NO_LINES_OK
      where CapacityInternalID        = @t_work_center-CapacityInternalID
      order by primary key into table @t_capacity.
  endmethod.


  method get_unit_of_measure.
    select single UnitOfMeasure,SIUnitCnvrsnRateNumerator,SIUnitCnvrsnRateDenominator
      from I_UnitOfMeasure with privileged access where UnitOfMeasure = @im_unit
      into corresponding fields of @rs_unit.
  endmethod.


  method set_target_operations_by_mfg.
**********************************************************************
*   製造指図作業
**********************************************************************
    select * from I_MfgOrderOperationWithStatus with privileged access
      where ManufacturingOrder          = @im_mfg_order
        and ManufacturingOrderSequence  = '000000'
        and OperationIsDeleted          = @abap_false
      order by ManufacturingOrderOperation_2 ascending
       into table @t_mfg_operation.
**********************************************************************
*   対象作業選別｜対象管理キー[Z301（工程外注）]以降の全作業
**********************************************************************
    data(is_valid_after_this) = abap_false.
    loop at t_mfg_operation assigning field-symbol(<mfg_operation>).
      if <mfg_operation>-OperationControlProfile = 'Z301' and is_valid_after_this = abap_false.
        is_valid_after_this = abap_true.
        continue.
      endif.
      if is_valid_after_this = abap_true.
        append value #(
          sequence                      = <mfg_operation>-ManufacturingOrderSequence
          operation                     = <mfg_operation>-ManufacturingOrderOperation_2
          control_profile               = <mfg_operation>-OperationControlProfile
          workcenter_internal_id        = <mfg_operation>-WorkCenterInternalID
          workcenter_type_code          = <mfg_operation>-WorkCenterTypeCode_2
          standard_work_quantity2       = <mfg_operation>-WorkCenterStandardWorkQty2
          standard_work_quantity2_unit  = <mfg_operation>-WorkCenterStandardWorkQtyUnit2
        ) to t_target_operation.
      endif.
    endloop.
  endmethod.


  method set_target_operations_by_ver.
**********************************************************************
*   製造工程表
**********************************************************************
    select single * from I_MfgBillOfOperations with privileged access
      where BillOfOperationsType      = @im_operation_type
        and BillOfOperationsGroup     = @im_operation_group
        and BillOfOperationsVariant   = @im_operation_variant
       into @s_operations.
**********************************************************************
*   製造工程表順序
**********************************************************************
    select single * from I_MfgBillOfOperationsSequence with privileged access
      where BillOfOperationsType      = @s_operations-BillOfOperationsType
        and BillOfOperationsGroup     = @s_operations-BillOfOperationsGroup
        and BillOfOperationsVariant   = @s_operations-BillOfOperationsVariant
        and BillOfOperationsSequence  = '000000'   "マスタ定義書 > 作業手順 > 入力要件 より
       into @s_operation_sequence.
**********************************************************************
*   製造工程表の作業
**********************************************************************
    select * from I_MfgBillOfOperationsOperation with privileged access
      where BillOfOperationsType      = @s_operation_sequence-BillOfOperationsType
        and BillOfOperationsGroup     = @s_operation_sequence-BillOfOperationsGroup
        and BillOfOperationsVariant   = @s_operation_sequence-BillOfOperationsVariant
        and BillOfOperationsSequence  = @s_operation_sequence-BillOfOperationsSequence
      order by primary key into table @t_operations_operation.
**********************************************************************
*   製造工程表の作業変更ステータス｜標準作業数量2
**********************************************************************
    select
      BillOfOperationsType,BillOfOperationsGroup,BillOfOperationsVariant,BillOfOperationsSequence,BOOOperationInternalID,BOOSqncOpAssgmtIntVersionCntr,BOOOpInternalVersionCounter,
      Operation_2,OperationControlProfile,WorkCenterInternalID,WorkCenterTypeCode,StandardWorkQuantity2,StandardWorkQuantityUnit2
      from I_MfgBOOOperationChangeState with privileged access for all entries in @t_operations_operation   "#EC CI_NO_TRANSFORM  #EC CI_FAE_LINES_ENSURED #EC CI_FAE_NO_LINES_OK
      where BillOfOperationsType      = @t_operations_operation-BillOfOperationsType
        and BillOfOperationsGroup     = @t_operations_operation-BillOfOperationsGroup
        and BillOfOperationsVariant   = @t_operations_operation-BillOfOperationsVariant
        and BillOfOperationsSequence  = @t_operations_operation-BillOfOperationsSequence
        and BOOOperationInternalID    = @t_operations_operation-BOOOperationInternalID
        and IsDeleted                 = @abap_false
      order by primary key into corresponding fields of table @t_operation_change_state.
    sort t_operation_change_state by Operation_2 ascending.   "活動番号｜昇順
**********************************************************************
*   対象作業選別｜対象管理キーを設定した作業のみ
**********************************************************************
    t_target_profile = value #( sign = 'I' option = 'EQ'
      ( low = 'Z201' )    "日程計画、原価計算【出庫工程】
      ( low = 'Z202' )    "日程計画、原価計算
      ( low = 'Z203' )    "日程計画、原価計算、自動入庫
      ( low = 'Z301' )    "工程外注
    ).
    loop at t_operation_change_state assigning field-symbol(<operation>).
      if <operation>-OperationControlProfile in t_target_profile.
        append value #(
          sequence                      = <operation>-BillOfOperationsSequence
          operation                     = <operation>-Operation_2
          control_profile               = <operation>-OperationControlProfile
          workcenter_internal_id        = <operation>-WorkCenterInternalID
          workcenter_type_code          = <operation>-WorkCenterTypeCode
          standard_work_quantity2       = <operation>-StandardWorkQuantity2
          standard_work_quantity2_unit  = <operation>-StandardWorkQuantityUnit2
        ) to t_target_operation.
      endif.
    endloop.
  endmethod.
ENDCLASS.
