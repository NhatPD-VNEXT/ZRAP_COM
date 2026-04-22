************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2025/05/12  M.OKADA            NWFK900068  *
*   変更内容       ：新規作成                                          *
*                    ※zcl_bp_suptxtをコピー                           *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_pr_sales_validity DEFINITION
  PUBLIC
    INHERITING FROM cl_abap_parallel
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF gts_param,
        value1 TYPE string,
      END   OF gts_param.

    TYPES:
      BEGIN OF gts_return,
        Status                        TYPE string,
        Message                       TYPE string,
        ConditionRecord               TYPE string,
        SalesOrganization             TYPE string,
        Customer                      TYPE string,
        CustomerPriceGroup            TYPE string,
        Material                      TYPE string,
        DepartureCountry              TYPE string,
        DestinationCountry            TYPE string,
        CustomerTaxClassification1    TYPE string,
        ProductTaxClassification1     TYPE string,
      END   OF gts_return,
      gtt_return TYPE STANDARD TABLE OF gts_return.

    METHODS do REDEFINITION.

    CLASS-METHODS:
      conv_alpha_in
        IMPORTING
          if_input         TYPE ANY
        RETURNING
          VALUE(rf_output) TYPE String,

      get_message_error
        IMPORTING if_json_data      TYPE string
        RETURNING VALUE(ef_message) TYPE string,

      get_url RETURNING VALUE(edf_url) TYPE string,

      get_param
        IMPORTING is_parameter TYPE gts_param
        EXPORTING ef_parameter TYPE string,

      get_data
        IMPORTING is_parameter TYPE gts_param
        EXPORTING ef_status    TYPE string
                  ef_message   TYPE string
                  et_return    TYPE gtt_return
        RAISING   cx_http_dest_provider_error,

      get_results_api
        IMPORTING if_json_data      TYPE string
                  is_parameter      TYPE gts_param
        EXPORTING et_return         TYPE gtt_return
        RETURNING VALUE(ef_message) TYPE string
        .

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PR_SALES_VALIDITY IMPLEMENTATION.


  METHOD conv_alpha_in.
    DATA: ldt_datao  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-ext_format  = if_input.
    lds_data-objtype     = 'BUS1006'.
    lds_data-method      = 'SEARCH'.
    lds_data-parameter   = 'SEARCHRESULT'.

    APPEND lds_data TO ldt_datao.

    CALL FUNCTION 'BAPI_CONVERSION_EXT2INT1'
      TABLES
        data   = ldt_datao
        return = ldt_return.
    IF NOT ldt_datao IS INITIAL.
      rf_output = ldt_datao[ 1 ]-int_format.
    ENDIF.
  ENDMETHOD.


  METHOD do.
    DATA:
      ldf_message     TYPE string,
      ldf_status      TYPE string,
      lds_parameter   TYPE gts_param,
      lds_return      TYPE zcl_pr_sales_validity=>gts_return,
      ldt_return      TYPE zcl_pr_sales_validity=>gtt_return.

    CALL TRANSFORMATION id SOURCE XML p_in
         RESULT in = lds_parameter.

    "CALL API get long text material master
    TRY.
      get_data(
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
      "200 かつ レコードなし(対象項目がブランク)はAPPENDしない.
      "(データ量削減のため).
      IF ldf_status = '200'.
      ELSE.
        lds_return-status  = ldf_status.
        lds_return-message = ldf_message.
        APPEND lds_return TO ldt_return.
      ENDIF.

    ENDIF.

    CALL TRANSFORMATION id SOURCE out = ldt_return
         RESULT XML p_out.

  ENDMETHOD.


  METHOD get_data.

    DATA: ldf_get_http_client TYPE REF TO zcl_get_http_client,
          ldf_http_client     TYPE REF TO if_web_http_client.

    "get base URL
    DATA(ldf_url) = get_url( ).

    "parameter set
    get_param(
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
        "そのままセットすると、末尾に半角スペースが付与されるため
        CONDENSE ef_status NO-GAPS.

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
        get_results_api(
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


  METHOD get_param.
    "Create query API
    REPLACE:
       ALL OCCURRENCES OF '&1'
        IN ef_parameter
      WITH is_parameter-value1.
*       ALL OCCURRENCES OF '&2'
*        IN ef_parameter
*      WITH is_parameter-value2,
*       ALL OCCURRENCES OF '&3'
*        IN ef_parameter
*      WITH is_parameter-value3,
*       ALL OCCURRENCES OF '&4'
*        IN ef_parameter
*      WITH is_parameter-value4.

  ENDMETHOD.


  METHOD get_results_api.

    TYPES:
      BEGIN OF lts_data,
        ConditionRecord                TYPE string,
        ConditionValidityEndDate       TYPE string,
        ConditionValidityStartDate     TYPE string,
        ConditionApplication           TYPE string,
        ConditionType                  TYPE string,
        ConditionReleaseStatus         TYPE string,
        DepartureCountry               TYPE string,
        SalesDocument                  TYPE string,
        SalesDocumentItem              TYPE string,
        BillableControl                TYPE string,
        Industry                       TYPE string,
        CityCode                       TYPE string,
        ConditionContract              TYPE string,
        County                         TYPE string,
        EngagementProject              TYPE string,
        ConfigurationNumber            TYPE string,
        BR_NFDocumentType              TYPE string,
        BRSpcfcFreeDefinedField1       TYPE string,
        BRSpcfcFreeDefinedField2       TYPE string,
        BRSpcfcFreeDefinedField3       TYPE string,
        InternationalArticleNumber     TYPE string,
        TechnicalObjectType            TYPE string,
        Equipment                      TYPE string,
        CustomerHierarchy              TYPE string,
        IncotermsClassification        TYPE string,
        IncotermsTransferLocation      TYPE string,
        AccountTaxType                 TYPE string,
        TxRlvnceClassfctnForArgentina  TYPE string,
        BR_TaxCode                     TYPE string,
        LocalSalesTaxApplicabilityCode TYPE string,
        CustomerGroup                  TYPE string,
        CustomerPriceGroup             TYPE string,
        MaterialPricingGroup           TYPE string,
        SoldToParty                    TYPE string,
        BPForSoldToParty               TYPE string,
        Customer                       TYPE string,
        BPForCustomer                  TYPE string,
        PayerParty                     TYPE string,
        BPForPayerParty                TYPE string,
        ShipToParty                    TYPE string,
        BPForShipToParty               TYPE string,
        Supplier                       TYPE string,
        BPForSupplier                  TYPE string,
        DestinationCountry             TYPE string,
        MaterialGroup                  TYPE string,
        Material                       TYPE string,
        ReturnsRefundExtent            TYPE string,
        AdditionalMaterialGroup1       TYPE string,
        AdditionalMaterialGroup2       TYPE string,
        AdditionalMaterialGroup3       TYPE string,
        AdditionalMaterialGroup4       TYPE string,
        AdditionalMaterialGroup5       TYPE string,
        Personnel                      TYPE string,
        PriceListType                  TYPE string,
        PostalCode                     TYPE string,
        Region                         TYPE string,
        EngagementProjectServiceOrg    TYPE string,
        RequirementSegment             TYPE string,
        StockSegment                   TYPE string,
        Division                       TYPE string,
        CommodityCode                  TYPE string,
        ConsumptionTaxCtrlCode         TYPE string,
        BRSpcfcTaxBasePercentageCode   TYPE string,
        BRSpcfcTxGrpDynTaxExceptions   TYPE string,
        CustomerTaxClassification1     TYPE string,
        CustomerTaxClassification2     TYPE string,
        CustomerTaxClassification3     TYPE string,
        CustomerTaxClassification4     TYPE string,
        CustomerTaxClassification5     TYPE string,
        CustomerTaxClassification6     TYPE string,
        CustomerTaxClassification7     TYPE string,
        CustomerTaxClassification8     TYPE string,
        CustomerTaxClassification9     TYPE string,
        ProductTaxClassification1      TYPE string,
        ProductTaxClassification2      TYPE string,
        ProductTaxClassification3      TYPE string,
        ProductTaxClassification4      TYPE string,
        ProductTaxClassification5      TYPE string,
        ProductTaxClassification6      TYPE string,
        ProductTaxClassification7      TYPE string,
        ProductTaxClassification8      TYPE string,
        ProductTaxClassification9      TYPE string,
        TradingContract                TYPE string,
        TradingContractItem            TYPE string,
        TaxJurisdiction                TYPE string,
        BRSpcfcTaxDepartureRegion      TYPE string,
        BRSpcfcTaxDestinationRegion    TYPE string,
        MainItemMaterialPricingGroup   TYPE string,
        MainItemPricingRefMaterial     TYPE string,
        VariantCondition               TYPE string,
        ValueAddedServiceChargeCode    TYPE string,
        SDDocument                     TYPE string,
        ReferenceSDDocument            TYPE string,
        ReferenceSDDocumentItem        TYPE string,
        SalesOffice                    TYPE string,
        SalesGroup                     TYPE string,
        SalesOrganization              TYPE string,
        SalesOrderSalesOrganization    TYPE string,
        OrderQuantityUnit              TYPE string,
        DistributionChannel            TYPE string,
        TransactionCurrency            TYPE string,
        WBSElementInternalID           TYPE string,
        WBSElementExternalID           TYPE string,
        WorkPackage                    TYPE string,
        Plant                          TYPE string,
        PlantRegion                    TYPE string,
        WorkItem                       TYPE string,
        ConditionProcessingStatus      TYPE string,
        PricingDate                    TYPE string,
        ConditionIsExclusive           TYPE string,
        ConditionScaleBasisValue       TYPE string,
        TaxCode                        TYPE string,
        ServiceDocument                TYPE string,
        ServiceDocumentItem            TYPE string,
        TimeSheetOvertimeCategory      TYPE string,
        SalesSDDocumentCategory        TYPE string,
        ReturnReason                   TYPE string,
        ProdUnivHierarchyNode          TYPE string,
        ProductHierarchyNode           TYPE string,
        CustomerConditionGroup         TYPE string,
        ShippingType                   TYPE string,
        SubscriptionContractDuration   TYPE string,
        SubscrpnContrDurationUnit      TYPE string,
        SubscriptionContractLockReason TYPE string,
        CrsCtlgMappgPriceVersionNumber TYPE string,
        OrderType                      TYPE string,
        SalesDocumentType              TYPE string,
        SDDocumentReason               TYPE string,
        VolumeRebateGroup              TYPE string,
        ValuationType                  TYPE string,
        SalesDistrict                  TYPE string,
        Batch                          TYPE string,
        PurgDocSupplyingPlant          TYPE string,
        MatUsageIndicator              TYPE string,
        ShippingCondition              TYPE string,
        PlantCounty                    TYPE string,
        PlantCity                      TYPE string,
        MaterialExternalGroup          TYPE string,
        CustomerHierarchyRootNode      TYPE string,
        CustomerHierarchyNodeID        TYPE string,
        CustomerHierarchyNodeType      TYPE string,
        AdditionalCustomerGroup1       TYPE string,
        AdditionalCustomerGroup2       TYPE string,
        AdditionalCustomerGroup3       TYPE string,
        AdditionalCustomerGroup4       TYPE string,
        AdditionalCustomerGroup5       TYPE string,
        SDDocumentItem                 TYPE string,
        CndnBillingDocumentCategory    TYPE string,
        Country                        TYPE string,
        CustomerPurchaseOrderType      TYPE string,
        CountryOfOrigin                TYPE string,
        SalesDocumentItemCategory      TYPE string,
        BillToParty                    TYPE string,
        BusinessPartnerIndustryCode    TYPE string,
        BillingDocumentType            TYPE string,
        MatlAccountAssignmentGroup     TYPE string,
        PRAContract                    TYPE string,
        Well                           TYPE string,
        WellCompletion                 TYPE string,
        MeasurementPoint               TYPE string,
        PricingFormulaNumber           TYPE string,
        ETag                           TYPE string,
      END   OF lts_data,

      BEGIN OF lts_results,
        results TYPE TABLE OF lts_data WITH EMPTY KEY,
      END   OF lts_results,

      BEGIN OF lts_api_return,
        d       TYPE lts_results,
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

      lds_return-ConditionRecord             = is_parameter-value1.
      lds_return-SalesOrganization           = lds_results-SalesOrganization.
      "lds_return-Customer                    = lds_results-Customer.
      lds_return-CustomerPriceGroup          = lds_results-CustomerPriceGroup.
      lds_return-Material                    = lds_results-Material.
      lds_return-DepartureCountry            = lds_results-DepartureCountry.
      lds_return-DestinationCountry          = lds_results-DestinationCountry.
      lds_return-CustomerTaxClassification1  = lds_results-CustomerTaxClassification1.
      lds_return-ProductTaxClassification1   = lds_results-ProductTaxClassification1.


      lds_return-Customer = |{ lds_results-Customer ALPHA = IN WIDTH = 10 }|.


*      "ブランクの場合、レコードを作成しない(データ量を減らすため).
*      IF lds_return-LongText IS INITIAL.
*        CONTINUE.
*      ELSE.
*      ENDIF.

      APPEND lds_return TO et_return.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_url.
    TRY.
        DATA(ldf_url) = cl_abap_context_info=>get_system_url( ).
      CATCH cx_abap_context_info_error ##NO_HANDLER.
        "handle exception
    ENDTRY.

    "get base URL
    SPLIT ldf_url AT '.' INTO DATA(ldf_client) ldf_url.
    "https://my418619-api.s4hana.cloud.sap/sap/opu/odata/sap/API_SLSPRICINGCONDITIONRECORD_SRV/A_SlsPrcgConditionRecord(ConditionRecord='0000386849')/to_SlsPrcgCndnRecdValidity
    edf_url =
      |https://{ ldf_client }-api.{ ldf_url }:443/sap/opu/odata/sap/API_SLSPRICINGCONDITIONRECORD_SRV/A_SlsPrcgConditionRecord(ConditionRecord='&1')/to_SlsPrcgCndnRecdValidity|.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.
ENDCLASS.
