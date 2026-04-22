************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/02/03  NTZ WIND            NWFK900043 *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
************************************************************************
* [Change History]                                                     *
* Version Information: V1.00 2024/02/03  NTZ WIND           NWFK900043 *
* Change Details: Newly created                                        *
*----------------------------------------------------------------------*
* Version Information: V9.99 YYYY/MM/DD <Modifier>         <Tr.Number> *
* Change Details:                                                      *
************************************************************************

CLASS zcl_com_context_info DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: gtt_message TYPE TABLE OF bapiret2.

    CLASS-METHODS get_user_and_timestamp
      EXPORTING
        ef_userid          TYPE i_user-userid
        ef_timestamp       TYPE timestampl
        ef_timestamp_local TYPE timestampl
        ef_date            TYPE d
        ef_time            TYPE t
        ef_date_local      TYPE d
        ef_time_local      TYPE t .

    CLASS-METHODS get_local_date_time
      IMPORTING
        !VALUE(if_timestamp) TYPE timestampl
      EXPORTING
        ef_date              TYPE d
        ef_time              TYPE t.

    CLASS-METHODS validate_product_and_plant
      IMPORTING
        if_product TYPE matnr
        if_plant   TYPE werks_d
      EXPORTING
        et_message TYPE gtt_message.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_COM_CONTEXT_INFO IMPLEMENTATION.


  METHOD get_local_date_time.
    IF if_timestamp IS INITIAL.

      GET TIME STAMP FIELD if_timestamp.
    ENDIF.

    TRY.
        CONVERT TIME STAMP if_timestamp TIME ZONE cl_abap_context_info=>get_user_time_zone( )
          INTO DATE ef_date TIME ef_time .
      CATCH cx_abap_context_info_error.
        CONVERT TIME STAMP if_timestamp TIME ZONE 'UTC'
          INTO DATE ef_date TIME ef_time .
    ENDTRY.

  ENDMETHOD.


  METHOD get_user_and_timestamp.
    ef_date = cl_abap_context_info=>get_system_date( ).
    ef_time = cl_abap_context_info=>get_system_time( ).
    ef_userid = cl_abap_context_info=>get_user_technical_name( ).
*    Get Timestamp UTC
    CONVERT DATE ef_date TIME ef_time
      INTO TIME STAMP ef_timestamp TIME ZONE 'UTC'.

    TRY.
*    Get Local Date and Local Time By Timestamp UTC
    convert TIME STAMP ef_timestamp TIME ZONE cl_abap_context_info=>get_user_time_zone( )
      INTO DATE ef_date_local
           TIME ef_time_local.

      CATCH cx_abap_context_info_error.
        ef_date_local = ef_date .
        ef_time_local = ef_time.
    ENDTRY.
    TRY.
        CONVERT DATE ef_date_local TIME ef_time_local
          INTO TIME STAMP ef_timestamp_local TIME ZONE 'UTC'.
      CATCH cx_abap_context_info_error.
        ef_timestamp_local = ef_timestamp .
    ENDTRY.

  ENDMETHOD.


  METHOD validate_product_and_plant.

  ENDMETHOD.
ENDCLASS.
