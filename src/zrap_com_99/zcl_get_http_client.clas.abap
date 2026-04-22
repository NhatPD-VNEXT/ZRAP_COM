************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/11/29  Y.SATOH            NWFK900068  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.01  2025/01/09  M.OKADA            NWFK900068  *
*   変更内容       ：ATCチェック対応                                   *
*                    ・##NO_TEXTのプラグマを追加                       *
*                    ・ID/パスワードをZY043T管理に変更                 *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_get_http_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_http_client
      IMPORTING base_url           TYPE string
      RETURNING VALUE(http_client) TYPE REF TO if_web_http_client
      RAISING
                cx_web_http_client_error
                cx_http_dest_provider_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GET_HTTP_CLIENT IMPLEMENTATION.


  METHOD get_http_client.

*-< ADD V1.01 (S) >-*
    DATA:
      ldf_username TYPE string,
      ldf_password TYPE string.
    CLEAR:
      ldf_username,
      ldf_password.
*-< ADD V1.01 (E) >-*

    http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination =  cl_http_destination_provider=>create_by_url( i_url = base_url ) ).
    http_client->get_http_request( )->set_header_field(
      EXPORTING
*-< UPD V1.01 (S) >-*
*        i_name  = 'Accept'
*        i_value = 'application/json'
        i_name  = 'Accept'            ##NO_TEXT
        i_value = 'application/json'  ##NO_TEXT
*-< UPD V1.01 (E) >-*
    ).
*    CATCH cx_web_message_error..

*-< ADD V1.01 (S) >-*
    "パラメータテーブル取得.
    SELECT  SINGLE
      client,
      div,
      zztype,
      zzseqno,
      zztypename,
      zzvalue01,
      zzvalue02,
      zzvalue03,
      zzvalue04,
      zzvalue05,
      zzvalue06,
      zzvalue07,
      zzvalue08,
      last_changed_at,
      local_last_changed_at
      FROM  zy043t
      WITH PRIVILEGED ACCESS
      WHERE div     = 'ZCL_GET_HTTP_CLIENT'
        AND zztype  = 'A'
        AND zzseqno = '0001'
      INTO @DATA(lds_zy043t).

    IF  sy-subrc = 0.
      IF lds_zy043t-zzvalue01 IS NOT INITIAL.
        ldf_username = lds_zy043t-zzvalue01.
      ELSE.
      ENDIF.

      IF lds_zy043t-zzvalue02 IS NOT INITIAL.
        "1項目30桁のため、2項目で管理
        CONCATENATE lds_zy043t-zzvalue02
                    lds_zy043t-zzvalue03
               INTO ldf_password.
      ELSE.
      ENDIF.
    ELSE.
    ENDIF.
*-< ADD V1.01 (E) >-*

    http_client->get_http_request( )->set_authorization_basic(
*-< UPD V1.01 (S) >-*
*      i_username = 'APIUSER'
*      i_password = 'bpgAbeeuZRhjVaWsDnJs>6ElXoEWvSghPSmBVURk'
      i_username = ldf_username
      i_password = ldf_password
*-< UPD V1.01 (E) >-*
    ).

  ENDMETHOD.
ENDCLASS.
