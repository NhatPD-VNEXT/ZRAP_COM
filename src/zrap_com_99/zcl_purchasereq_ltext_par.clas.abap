************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2026/01/07  M.SHIOMI           NWFK900068  *
*   変更内容       ：新規作成                                          *
*                    ※zcl_purchasereq_ltextをコピー                   *
*                      zcl_mi906_03で実装した並列処理に変更            *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_purchasereq_ltext_par DEFINITION
  PUBLIC
    INHERITING FROM cl_abap_parallel
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF lts_str,
        VALUE1 TYPE string,
        VALUE2 TYPE string,
      END   OF lts_str.

    TYPES:
      BEGIN OF gts_return,
        Status              TYPE string,
        Message             TYPE string,
*-< ADD V1.00 (S) >-*
        PurchaseRequisition TYPE string,
*-< ADD V1.00 (E) >-*
        Language            TYPE string,
        Longtext            TYPE string,
      END   OF gts_return,
      gtt_return TYPE STANDARD TABLE OF gts_return.

    METHODS do REDEFINITION.

    CLASS-METHODS:
      get_url RETURNING VALUE(edf_url) TYPE string,

      get_parameter
        IMPORTING if_parameter TYPE banfn
                  if_language  TYPE c
        EXPORTING ef_parameter TYPE string,

      get_purchasereq_longtext
        IMPORTING if_parameter TYPE banfn
                  if_language  TYPE c
                               OPTIONAL
        EXPORTING ef_status    TYPE string
                  ef_message   TYPE string
                  et_return    TYPE gtt_return
        RAISING   cx_http_dest_provider_error,

      get_message_error
        IMPORTING if_json_data      TYPE string
        RETURNING VALUE(ef_message) TYPE string,

      get_results_api_get
        IMPORTING if_json_data      TYPE string
*-< ADD V1.00 (S) >-*
                  if_parameter      TYPE banfn
*-< ADD V1.00 (E) >-*
        EXPORTING et_return         TYPE gtt_return
        RETURNING VALUE(ef_message) TYPE string
        .

*-< DEL V1.00 (S) >-*
    "不要なためコメントアウト.
*    METHODS get_purchasereq_longtext_run
*      IMPORTING
*        if_parameter TYPE string
*      EXPORTING
*        et_return    TYPE gtt_return
*        .
*-< DEL V1.00 (E) >-*

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PURCHASEREQ_LTEXT_PAR IMPLEMENTATION.


  METHOD do.
    DATA:
      ldf_message     TYPE string,
      ldf_purchasereq TYPE banfn,
      ldf_status      TYPE string,
      lds_str         TYPE lts_str,
      lds_return      TYPE zcl_purchasereq_ltext_par=>gts_return,
      ldt_return      TYPE zcl_purchasereq_ltext_par=>gtt_return.

*-< UPD V1.00 (S) >-*
*    IMPORT param_input = lds_str
*      FROM DATA BUFFER p_in.
    CALL TRANSFORMATION id SOURCE XML p_in
         RESULT in = lds_str.
*-< UPD V1.00 (E) >-*

    "Parameter Set.
    ldf_purchasereq  = lds_str-value1.

    "CALL API get long text material master
    TRY.
      get_purchasereq_longtext(
        EXPORTING
          if_parameter = ldf_purchasereq
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
    TYPES: BEGIN OF lts_ErrorResolution,
             Analysis          TYPE string,
             Note              TYPE string,
           END   OF lts_ErrorResolution.

    TYPES: BEGIN OF lts_Application,
             ComponentId       TYPE string,
             ServiceRepository TYPE string,
             ServiceId         TYPE string,
             ServiceVersion    TYPE string,
           END   OF lts_Application.

    TYPES: BEGIN OF lts_ErrorDetails,
             Application       TYPE lts_Application,
             TransactionId     TYPE string,
             Timestamp         TYPE string,
             ErrorResolution   TYPE lts_ErrorResolution,
           END   OF lts_ErrorDetails.

    TYPES: BEGIN OF lts_innererror,
             ErrorDetails      TYPE lts_ErrorDetails,
           END   OF lts_innererror.

    TYPES: BEGIN OF lts_error,
             code              TYPE string,
             message           TYPE string,
             ExceptionCategory TYPE string,
             innererror        TYPE lts_innererror,
           END OF lts_error.

    TYPES: BEGIN OF lts_api_return,
             error TYPE lts_error,
           END OF lts_api_return.

    DATA: lds_api_return TYPE lts_api_return.

    "Convert JSON to ABAP DATA
    xco_cp_json=>data->from_string( if_json_data )->apply( VALUE #(
             ( xco_cp_json=>transformation->boolean_to_abap_bool )
           ) )->write_to( REF #( lds_api_return ) ).

    ef_message = lds_api_return-error-message.
  ENDMETHOD.


  METHOD get_parameter.
    "Create query API
    "ef_parameter = |$filter=Product eq '{ if_parameter }' |.
    ef_parameter = |$filter=PurchaseRequisition eq '{ if_parameter }' | ##NO_TEXT.
  ENDMETHOD.


  METHOD get_purchasereq_longtext.

    DATA: ldf_get_http_client TYPE REF TO zcl_get_http_client,
          ldf_http_client     TYPE REF TO if_web_http_client.

    "Query API
    get_parameter(
      EXPORTING
        if_parameter = if_parameter
        if_language  = if_language
      IMPORTING
        ef_parameter = DATA(ldf_parameter)
    ).

    "get base URL
    DATA(ldf_url) = get_url( ).

    "Execute call API
    CREATE OBJECT ldf_get_http_client.

    TRY.
        "Set base URL
        ldf_http_client = ldf_get_http_client->get_http_client( base_url = ldf_url ).
        "Set query API
        ldf_http_client->get_http_request(  )->set_query( query = ldf_parameter ).

        DATA(ldf_response) = ldf_http_client->execute( i_method = if_web_http_client=>get ).

        "Get API response status
        DATA(ldf_status) = ldf_response->get_status( ).
        "Get API response text
        DATA(ldf_json) = ldf_response->get_text( ).

        "@odata始まりの項目名を置換(xco_cp_jsonのエラー回避の方法が不明なため).
        REPLACE:
          ALL OCCURRENCES OF '@odata.'
          IN   ldf_json
          WITH '',
          ALL OCCURRENCES OF '@SAP__common.'
          IN   ldf_json
          WITH ''.
        IF sy-subrc = 0.
        ELSE.
        ENDIF.

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
*-< ADD V1.00 (S) >-*
            if_parameter = if_parameter
*-< ADD V1.00 (E) >-*
          IMPORTING
            et_return    = et_return
          RECEIVING
            ef_message   = ef_message
        ).

      CATCH cx_web_http_client_error ##NO_HANDLER.
        "handle exception
    ENDTRY.
  ENDMETHOD.


  METHOD get_url.
    TRY.
        DATA(ldf_url) = cl_abap_context_info=>get_system_url( ).
      CATCH cx_abap_context_info_error ##NO_HANDLER.
        "handle exception
    ENDTRY.

    "get base URL
    SPLIT ldf_url AT '.' INTO DATA(ldf_client) ldf_url.
    "edf_url = |https://{ ldf_client }-api.{ ldf_url }:443/sap/opu/odata/sap/API_PRODUCT_SRV/A_ProductBasicText|.
    edf_url = |https://{ ldf_client }-api.{ ldf_url }:443/sap/opu/odata4/sap/api_purchaserequisition_2/srvd_a2x/sap/purchaserequisition/0001/PurchaseReqn|.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.


  METHOD get_results_api_get.

    TYPES:BEGIN OF lts_data,
            etag                     TYPE string,
            PurchaseRequisition      TYPE string,
            PurchaseRequisitionType  TYPE string,
            PurReqnDescription       TYPE string,
            purreqnheadernote        TYPE string,
            SourceDetermination      TYPE abap_boolean,
            PurReqnDoOnlyValidation  TYPE abap_boolean,
            SAP__Messages            TYPE string,
          END OF lts_data.

    TYPES:
      BEGIN OF lts_api_return,
        context      TYPE String,
        metadataEtag TYPE String,
        value        TYPE TABLE OF lts_data WITH EMPTY KEY,
      END   OF lts_api_return.

    DATA:
      lds_return     TYPE gts_return,
      lds_api_return TYPE lts_api_return.

    "Convert JSON to ABAP DATA
    xco_cp_json=>data->from_string( if_json_data )->apply( VALUE #(
      ( xco_cp_json=>transformation->boolean_to_abap_bool )
    ) )->write_to( REF #( lds_api_return ) ).

    LOOP AT lds_api_return-value INTO DATA(lds_value).
      CLEAR: lds_return.
*-< ADD V1.00 (S) >-*
      lds_return-PurchaseRequisition = if_parameter.
*-< ADD V1.00 (E) >-*
      lds_return-longtext            = lds_value-PurReqnHeaderNote.
      APPEND lds_return TO et_return.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
