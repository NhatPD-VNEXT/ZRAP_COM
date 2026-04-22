************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2025/05/07  M.OKADA            NWFK900068  *
*   変更内容       ：新規作成                                          *
*                    ※zcl_prodrouting_custfl_parをコピー              *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_bp_suptxt DEFINITION
  PUBLIC
    INHERITING FROM cl_abap_parallel
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF gts_param_suptxt,
        value1 TYPE string,
      END   OF gts_param_suptxt.

    TYPES:
      BEGIN OF gts_return_suptxt,
        Status                        TYPE string,
        Message                       TYPE string,
        Supplier                      TYPE string,
        Language                      TYPE string,
        LongTextID                    TYPE string,
        LongText                      TYPE string,
      END   OF gts_return_suptxt,
      gtt_return_suptxt TYPE STANDARD TABLE OF gts_return_suptxt.

    METHODS do REDEFINITION.

    CLASS-METHODS:
      get_message_error
        IMPORTING if_json_data      TYPE string
        RETURNING VALUE(ef_message) TYPE string,


      "一般データ
      get_url_suptxt RETURNING VALUE(edf_url) TYPE string,

      get_param_suptxt
        IMPORTING is_parameter TYPE gts_param_suptxt
        EXPORTING ef_parameter TYPE string,

      get_data_suptxt
        IMPORTING is_parameter TYPE gts_param_suptxt
        EXPORTING ef_status    TYPE string
                  ef_message   TYPE string
                  et_return    TYPE gtt_return_suptxt
        RAISING   cx_http_dest_provider_error,

      get_results_api_suptxt
        IMPORTING if_json_data      TYPE string
                  is_parameter      TYPE gts_param_suptxt
        EXPORTING et_return         TYPE gtt_return_suptxt
        RETURNING VALUE(ef_message) TYPE string
        .

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BP_SUPTXT IMPLEMENTATION.


  METHOD do.
    DATA:
      ldf_message     TYPE string,
      ldf_status      TYPE string,
      lds_parameter   TYPE gts_param_suptxt,
      lds_return      TYPE zcl_bp_suptxt=>gts_return_suptxt,
      ldt_return      TYPE zcl_bp_suptxt=>gtt_return_suptxt.

    CALL TRANSFORMATION id SOURCE XML p_in
         RESULT in = lds_parameter.

    "CALL API get long text material master
    TRY.
      get_data_suptxt(
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


  METHOD get_data_suptxt.

    DATA: ldf_get_http_client TYPE REF TO zcl_get_http_client,
          ldf_http_client     TYPE REF TO if_web_http_client.

    "get base URL
    DATA(ldf_url) = get_url_suptxt( ).

    "parameter set
    get_param_suptxt(
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
        get_results_api_suptxt(
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


  METHOD get_param_suptxt.
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


  METHOD get_results_api_suptxt.

    TYPES:
      BEGIN OF lts_data,
        Supplier    TYPE string,
        Language    TYPE string,
        LongTextID  TYPE string,
        LongText    TYPE string,
      END   OF lts_data,

      BEGIN OF lts_results,
        results TYPE TABLE OF lts_data WITH EMPTY KEY,
      END   OF lts_results,

      BEGIN OF lts_api_return,
        d       TYPE lts_results,
      END   OF lts_api_return.

    DATA:
      lds_return     TYPE gts_return_suptxt,
      lds_api_return TYPE lts_api_return.

    "Convert JSON to ABAP DATA
    xco_cp_json=>data->from_string( if_json_data )->apply( VALUE #(
      ( xco_cp_json=>transformation->boolean_to_abap_bool )
    ) )->write_to( REF #( lds_api_return ) ).

    LOOP AT lds_api_return-d-results INTO DATA(lds_results).
      CLEAR: lds_return.
      lds_return-Supplier     = is_parameter-value1.
      lds_return-Language     = lds_results-Language.
      lds_return-LongTextID   = lds_results-LongTextID.
      lds_return-LongText     = lds_results-LongText.

      "ブランクの場合、レコードを作成しない(データ量を減らすため).
      IF lds_return-LongText IS INITIAL.
        CONTINUE.
      ELSE.
      ENDIF.

      APPEND lds_return TO et_return.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_url_suptxt.
    TRY.
        DATA(ldf_url) = cl_abap_context_info=>get_system_url( ).
      CATCH cx_abap_context_info_error ##NO_HANDLER.
        "handle exception
    ENDTRY.

    "get base URL
    SPLIT ldf_url AT '.' INTO DATA(ldf_client) ldf_url.
    "https://my418619-api.s4hana.cloud.sap/sap/opu/odata/sap/API_BUSINESS_PARTNER/A_Supplier('12345TEST')/to_SupplierText
    edf_url =
      |https://{ ldf_client }-api.{ ldf_url }:443/sap/opu/odata/sap/API_BUSINESS_PARTNER/A_Supplier('&1')/to_SupplierText|.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.
ENDCLASS.
