************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2025/03/24  M.OKADA            NWFK900068  *
*   変更内容       ：新規作成                                          *
*                    ※zcl_prodrouting_custflをコピー                  *
*                      zcl_mi906_03で実装した並列処理に変更            *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.01  2025/07/04  M.OKADA            NWFK900068  *
*   変更内容       ：Ver0003のAPI仕様に変更                            *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_prodrouting_custfl_par DEFINITION
  PUBLIC
    INHERITING FROM cl_abap_parallel
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF lts_parameter,
        value1 TYPE string,
        value2 TYPE string,
        value3 TYPE string,
        value4 TYPE string,
      END   OF lts_parameter.

    TYPES:
      BEGIN OF gts_return,
        Status                        TYPE string,
        Message                       TYPE string,
        BillOfOperationsGroup         TYPE c LENGTH 8,
        BillOfOperationsVariant       TYPE c LENGTH 2,
        BillOfOperationsSequence      TYPE c LENGTH 6,
        BOOSqncOpAssgmtIntVersionCntr TYPE n LENGTH 8,
        BOOOperationInternalID        TYPE n LENGTH 8,
        BOOOpInternalVersionCounter   TYPE n LENGTH 8,
        YY1_PP_BOOS_OPR_CDS01_PPO     TYPE c LENGTH 30,
      END   OF gts_return,
      gtt_return TYPE STANDARD TABLE OF gts_return.

    METHODS do REDEFINITION.

    CLASS-METHODS:
      get_url RETURNING VALUE(edf_url) TYPE string,

      get_parameter
        IMPORTING is_parameter TYPE lts_parameter
        EXPORTING ef_parameter TYPE string,

      get_prodrouting_boop_custfl
        IMPORTING is_parameter TYPE lts_parameter
        EXPORTING ef_status    TYPE string
                  ef_message   TYPE string
                  et_return    TYPE gtt_return
        RAISING   cx_http_dest_provider_error,

      get_message_error
        IMPORTING if_json_data      TYPE string
        RETURNING VALUE(ef_message) TYPE string,

      get_results_api_get
        IMPORTING if_json_data      TYPE string
                  is_parameter      TYPE lts_parameter
        EXPORTING et_return         TYPE gtt_return
        RETURNING VALUE(ef_message) TYPE string
        .

*-< DEL V1.00 (S) >-*
    "不要なためコメントアウト.
*    METHODS get_prodrouting_boop_custfl_r
*      IMPORTING
*        is_parameter TYPE lts_parameter
*      EXPORTING
*        et_return    TYPE gtt_return
*        .
*-< DEL V1.00 (E) >-*

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PRODROUTING_CUSTFL_PAR IMPLEMENTATION.


  METHOD do.
    DATA:
      ldf_message     TYPE string,
      ldf_status      TYPE string,
      lds_parameter   TYPE lts_parameter,
      lds_return      TYPE zcl_prodrouting_custfl_par=>gts_return,
      ldt_return      TYPE zcl_prodrouting_custfl_par=>gtt_return.

*-< UPD V1.00 (S) >-*
*    IMPORT param_input = lds_parameter
*      FROM DATA BUFFER p_in.
    CALL TRANSFORMATION id SOURCE XML p_in
         RESULT in = lds_parameter.
*-< UPD V1.00 (E) >-*

    "CALL API get long text material master
    TRY.
      get_prodrouting_boop_custfl(
        EXPORTING
          is_parameter = lds_parameter
        IMPORTING
          ef_status    = ldf_status
          ef_message   = ldf_message
          et_return    = ldt_return
      ).
    CATCH cx_http_dest_provider_error ##NO_HANDLER.
      "handle exception
    ENDTRY.

    READ TABLE ldt_return ASSIGNING FIELD-SYMBOL(<l_return>)
      INDEX 1.
    IF sy-subrc = 0.
      <l_return>-status  = ldf_status.
      <l_return>-message = ldf_message.
    ELSE.
      lds_return-status  = ldf_status.
      lds_return-message = ldf_message.
      APPEND lds_return TO ldt_return.
    ENDIF.

*-< UPD V1.00 (S) >-*
*    EXPORT param_output = ldt_return
*      TO DATA BUFFER p_out.
    CALL TRANSFORMATION id SOURCE out = ldt_return
         RESULT XML p_out.
*-< UPD V1.00 (E) >-*

  ENDMETHOD.


  METHOD get_message_error.
    TYPES:
      BEGIN OF lts_message,
        lang  TYPE string,
        value TYPE string,
      END   OF lts_message,

      BEGIN OF lts_error,
        code    TYPE string,
        message TYPE lts_message,
      END   OF lts_error,

      BEGIN OF lts_api_return,
        error TYPE lts_error,
      END   OF lts_api_return.

    DATA: lds_api_return TYPE lts_api_return.

    "Convert JSON to ABAP DATA
    xco_cp_json=>data->from_string( if_json_data )->apply( VALUE #(
             ( xco_cp_json=>transformation->boolean_to_abap_bool )
           ) )->write_to( REF #( lds_api_return ) ).

    ef_message = lds_api_return-error-message-value.
  ENDMETHOD.


  METHOD get_parameter.
    "Create query API
    REPLACE:
       ALL OCCURRENCES OF '&1'
        IN ef_parameter
      WITH is_parameter-value1,
       ALL OCCURRENCES OF '&2'
        IN ef_parameter
      WITH is_parameter-value2,
       ALL OCCURRENCES OF '&3'
        IN ef_parameter
      WITH is_parameter-value3,
       ALL OCCURRENCES OF '&4'
        IN ef_parameter
      WITH is_parameter-value4.

  ENDMETHOD.


  METHOD get_prodrouting_boop_custfl.

    DATA: ldf_get_http_client TYPE REF TO zcl_get_http_client,
          ldf_http_client     TYPE REF TO if_web_http_client.

    "get base URL
    DATA(ldf_url) = get_url( ).

    "parameter set
    get_parameter(
      EXPORTING
        is_parameter = is_parameter
      IMPORTING
        ef_parameter = ldf_url
    ).

    "Execute call API
    CREATE OBJECT ldf_get_http_client.

    TRY.
        "Set base URL
        ldf_http_client = ldf_get_http_client->get_http_client( base_url = ldf_url ).

        DATA(ldf_response) = ldf_http_client->execute( i_method = if_web_http_client=>get ).

        "Get API response status
        DATA(ldf_status) = ldf_response->get_status( ).
        "Get API response text
        DATA(ldf_json) = ldf_response->get_text( ).

        ef_status = ldf_status-code.

        "If API response error -> Setting message error and return
        IF ldf_status-code <> 200.
          "Using method get_message_error to convert JSON to ABAP DATA
          get_message_error(
            EXPORTING
              if_json_data = ldf_json
            RECEIVING
              ef_message   = ef_message
          ).
          RETURN.
        ENDIF.

        "If API response OK
        get_results_api_get(
          EXPORTING
            if_json_data = ldf_json
            is_parameter = is_parameter
          IMPORTING
            et_return    = et_return
          RECEIVING
            ef_message   = ef_message
        ).

      CATCH cx_web_http_client_error ##NO_HANDLER.
        "handle exception
    ENDTRY.
  ENDMETHOD.


  METHOD get_results_api_get.

    TYPES:
      BEGIN OF lts_data,
        ProductionRoutingGroup         TYPE string,
        ProductionRouting              TYPE string,
        ProductionRoutingSequence      TYPE string,
        ProductionRoutingOpIntID       TYPE string,
        ProductionRoutingOpIntVersion  TYPE string,
        Operation                      TYPE string,
        CreationDate                   TYPE string,
        CreatedByUser                  TYPE string,
        LastChangeDate                 TYPE string,
        LastChangedByUser              TYPE string,
        ChangeNumber                   TYPE string,
        ValidityStartDate              TYPE string,
        ValidityEndDate                TYPE string,
        IsDeleted                      TYPE abap_boolean,
        IsImplicitlyDeleted            TYPE abap_boolean,
        OperationText                  TYPE string,
        LongTextLanguageCode           TYPE string,
        Plant                          TYPE string,
        OperationControlProfile        TYPE string,
        OperationStandardTextCode      TYPE string,
        WorkCenterTypeCode             TYPE string,
        WorkCenterInternalID           TYPE string,
        CapacityCategoryCode           TYPE string,
        CostElement                    TYPE string,
        OperationCostingRelevancyType  TYPE string,
        NumberOfTimeTickets            TYPE string,
        NumberOfConfirmationSlips      TYPE string,
        EmployeeSuitability            TYPE string,
        BillOfOperationsRefType        TYPE string,
        BillOfOperationsRefGroup       TYPE string,
        BillOfOperationsRefVariant     TYPE string,
        LineSegmentTakt                TYPE string,
        OperationStdWorkQtyGrpgCat     TYPE string,
        OrderHasNoSubOperations        TYPE abap_boolean,
        OperationSetupType             TYPE string,
        OperationSetupGroupCategory    TYPE string,
        OperationSetupGroup            TYPE string,
        BOOOperationIsPhase            TYPE abap_boolean,
        BOOPhaseSuperiorOpInternalID   TYPE string,
        ControlRecipeDestination       TYPE string,
        OpIsExtlyProcdWithSubcontrg    TYPE abap_boolean,
        PurchasingInfoRecord           TYPE string,
        PurchasingOrganization         TYPE string,
        PurchaseContract               TYPE string,
        PurchaseContractItem           TYPE string,
        PurchasingInfoRecdAddlGrpgName TYPE string,
        MaterialGroup                  TYPE string,
        PurchasingGroup                TYPE string,
        Supplier                       TYPE string,
        PlannedDeliveryDuration        TYPE string,
        NumberOfOperationPriceUnits    TYPE string,
        OpExternalProcessingCurrency   TYPE string,
        OpExternalProcessingPrice      TYPE p LENGTH 13 DECIMALS 3,
        InspectionLotType              TYPE string,
        InspResultRecordingView        TYPE string,
        InspSbstCompletionConfirmation TYPE string,
        InspSbstHasNoTimeOrQuantity    TYPE abap_boolean,
        OperationReferenceQuantity     TYPE string,
        OperationUnit                  TYPE string,
        OperationScrapPercent          TYPE p LENGTH 13 DECIMALS 3,
        OpQtyToBaseQtyNmrtr            TYPE string,
        OpQtyToBaseQtyDnmntr           TYPE string,
        StandardWorkQuantity1          TYPE p LENGTH 13 DECIMALS 3,
        StandardWorkQuantityUnit1      TYPE string,
        CostCtrActivityType1           TYPE string,
        PerfEfficiencyRatioCode1       TYPE string,
        StandardWorkQuantity2          TYPE p LENGTH 13 DECIMALS 3,
        StandardWorkQuantityUnit2      TYPE string,
        CostCtrActivityType2           TYPE string,
        PerfEfficiencyRatioCode2       TYPE string,
        StandardWorkQuantity3          TYPE p LENGTH 13 DECIMALS 3,
        StandardWorkQuantityUnit3      TYPE string,
        CostCtrActivityType3           TYPE string,
        PerfEfficiencyRatioCode3       TYPE string,
        StandardWorkQuantity4          TYPE p LENGTH 13 DECIMALS 3,
        StandardWorkQuantityUnit4      TYPE string,
        CostCtrActivityType4           TYPE string,
        PerfEfficiencyRatioCode4       TYPE string,
        StandardWorkQuantity5          TYPE p LENGTH 13 DECIMALS 3,
        StandardWorkQuantityUnit5      TYPE string,
        CostCtrActivityType5           TYPE string,
        PerfEfficiencyRatioCode5       TYPE string,
        StandardWorkQuantity6          TYPE p LENGTH 13 DECIMALS 3,
        StandardWorkQuantityUnit6      TYPE string,
        CostCtrActivityType6           TYPE string,
        PerfEfficiencyRatioCode6       TYPE string,
        BusinessProcess                TYPE string,
        LeadTimeReductionStrategy      TYPE string,
        TeardownAndWaitIsParallel      TYPE abap_boolean,
        BillOfOperationsBreakDuration  TYPE p LENGTH 13 DECIMALS 3,
        BreakDurationUnit              TYPE string,
        MaximumWaitDuration            TYPE p LENGTH 13 DECIMALS 3,
        MaximumWaitDurationUnit        TYPE string,
        MinimumWaitDuration            TYPE p LENGTH 13 DECIMALS 3,
        MinimumWaitDurationUnit        TYPE string,
        StandardQueueDuration          TYPE p LENGTH 13 DECIMALS 3,
        StandardQueueDurationUnit      TYPE string,
        MinimumQueueDuration           TYPE p LENGTH 13 DECIMALS 3,
        MinimumQueueDurationUnit       TYPE string,
        StandardMoveDuration           TYPE p LENGTH 13 DECIMALS 3,
        StandardMoveDurationUnit       TYPE string,
        MinimumMoveDuration            TYPE p LENGTH 13 DECIMALS 3,
        MinimumMoveDurationUnit        TYPE string,
        OperationSplitIsRequired       TYPE abap_boolean,
        MaximumNumberOfSplits          TYPE string,
        MinProcessingDurationPerSplit  TYPE p LENGTH 13 DECIMALS 3,
        MinProcessingDurnPerSplitUnit  TYPE string,
        OperationOverlappingIsRequired TYPE abap_boolean,
        OperationOverlappingIsPossible TYPE abap_boolean,
        OperationsIsAlwaysOverlapping  TYPE abap_boolean,
        OperationHasNoOverlapping      TYPE abap_boolean,
        OverlapMinimumDuration         TYPE p LENGTH 13 DECIMALS 3,
        OverlapMinimumDurationUnit     TYPE string,
        OverlapMinimumTransferQty      TYPE string,
        OverlapMinimumTransferQtyUnit  TYPE string,
        FactoryCalendar                TYPE string,
        ChangedDateTime                TYPE string,
        PlainLongText                  TYPE string,
*-< ADD V1.01 (S) >-*
        WorkCenter                     TYPE string,
*-< ADD V1.01 (E) >-*
        YY1_PP_BOOS_OPR_CDS01_PPO      TYPE string,
      END   OF lts_data,

      BEGIN OF lts_results,
        results TYPE TABLE OF lts_data WITH EMPTY KEY,
      END   OF lts_results,

      BEGIN OF lts_api_return,
        d TYPE lts_results,
      END   OF lts_api_return.

    DATA:
      lds_return     TYPE gts_return,
      lds_api_return TYPE lts_api_return.

    "Convert JSON to ABAP DATA
    xco_cp_json=>data->from_string( if_json_data )->apply( VALUE #(
      ( xco_cp_json=>transformation->boolean_to_abap_bool )
    ) )->write_to( REF #( lds_api_return ) ).

    LOOP AT lds_api_return-d-results INTO DATA(lds_results).
      CLEAR: lds_return.
      lds_return-BillOfOperationsGroup         = is_parameter-value1.
      lds_return-BillOfOperationsVariant       = is_parameter-value2.
      lds_return-BillOfOperationsSequence      = is_parameter-value3.
      lds_return-BOOSqncOpAssgmtIntVersionCntr = is_parameter-value4.
      lds_return-BOOOperationInternalID        = lds_results-ProductionRoutingOpIntID.
      lds_return-BOOOpInternalVersionCounter   = lds_results-ProductionRoutingOpIntVersion.
      lds_return-YY1_PP_BOOS_OPR_CDS01_PPO     = lds_results-YY1_PP_BOOS_OPR_CDS01_PPO.

*-< ADD V1.00 (S) >-*
      "カスタム項目がブランクの場合、レコードを作成しない.
      "(データ量を減らすため).
      IF lds_return-YY1_PP_BOOS_OPR_CDS01_PPO IS INITIAL.
        CONTINUE.
      ELSE.
      ENDIF.
*-< ADD V1.00 (E) >-*

      APPEND lds_return TO et_return.
    ENDLOOP.

*    SORT et_return STABLE
*      BY BillOfOperationsGroup       ASCENDING
*         BillOfOperationsVariant     ASCENDING
*         BillOfOperationsSequence    ASCENDING
*         BOOOperationInternalID      ASCENDING
*         BOOOpInternalVersionCounter ASCENDING.
  ENDMETHOD.


  METHOD get_url.
    TRY.
        DATA(ldf_url) = cl_abap_context_info=>get_system_url( ).
      CATCH cx_abap_context_info_error ##NO_HANDLER.
        "handle exception
    ENDTRY.

    "get base URL
    SPLIT ldf_url AT '.' INTO DATA(ldf_client) ldf_url.
   "https://my405871-api.s4hana.cloud.sap/sap/opu/odata/sap/API_PRODUCTION_ROUTING;v=0002/ProductionRoutingSequence(ProductionRoutingGroup='50000153',ProductionRouting='1',ProductionRoutingSequence='0',ProductionRoutingSqncIntVers='1')/to_Operation
    edf_url =
*-< UPD V1.01 (S) >-*
"|https://{ ldf_client }-api.{ ldf_url }:443/sap/opu/odata/sap/API_PRODUCTION_ROUTING;v=0002/ProductionRoutingSequence(ProductionRoutingGroup='&1',ProductionRouting='&2',ProductionRoutingSequence='&3',ProductionRoutingSqncIntVers='&4')/to_Operation|.
      "0002→0003、に変更.
      |https://{ ldf_client }-api.{ ldf_url }:443/sap/opu/odata/sap/API_PRODUCTION_ROUTING;v=0003/ProductionRoutingSequence(ProductionRoutingGroup='&1',ProductionRouting='&2',ProductionRoutingSequence='&3',ProductionRoutingSqncIntVers='&4')/to_Operation|.
*-< UPD V1.01 (E) >-*
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.
ENDCLASS.
