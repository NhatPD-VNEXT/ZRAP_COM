************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2025/06/03  M.OKADA            NWFK900068  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_zv900t_update DEFINITION
  PUBLIC
    INHERITING FROM cl_abap_parallel
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES:
      BEGIN OF gts_parameter,
        DeliveryDocument      TYPE I_DeliveryDocument-DeliveryDocument,
        del_flg               TYPE zv900t-del_flg,
        CreationDate          TYPE I_DeliveryDocument-CreationDate,
        CreationTime          TYPE I_DeliveryDocument-CreationTime,
        CreatedByUser         TYPE I_DeliveryDocument-CreatedByUser,
        LastChangeDate        TYPE I_DeliveryDocument-LastChangeDate,
        LastChangedByUse      TYPE I_DeliveryDocument-LastChangedByUser,
      END   OF gts_parameter,

      BEGIN OF gts_return,
        Status                TYPE string,
        Message               TYPE string,
        DeliveryDocument      TYPE I_DeliveryDocument-DeliveryDocument,
      END   OF gts_return,

      gtt_return    TYPE STANDARD TABLE OF gts_return.

    METHODS do REDEFINITION.

    METHODS udpate_zv900t
      IMPORTING
        is_parameter TYPE gts_parameter
      EXPORTING
        et_return    TYPE gtt_return
        .

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZV900T_UPDATE IMPLEMENTATION.


  METHOD do.
    DATA:
      ldf_message     TYPE string,
      ldf_status      TYPE string,
      lds_parameter   TYPE gts_parameter,
      lds_return      TYPE zcl_zv900t_update=>gts_return,
      ldt_return      TYPE zcl_zv900t_update=>gtt_return.

    CALL TRANSFORMATION id SOURCE XML p_in
         RESULT in = lds_parameter.

    GET TIME STAMP FIELD DATA(ldf_timestamp).

    "出荷伝票  変更日時管理テーブル 存在チェック.
    SELECT  SINGLE *
      FROM  zv900t
      WHERE DeliveryDocument = @lds_parameter-DeliveryDocument
      INTO  @DATA(lds_zv900t)
      .
    IF sy-subrc = 0.
      "あり→更新.
      lds_zv900t-del_flg               = lds_parameter-del_flg.
      lds_zv900t-last_changed_at       = ldf_timestamp.
      lds_zv900t-local_last_changed_at = ldf_timestamp.
    ELSE.
      "あり→登録.
      lds_zv900t-deliverydocument      = lds_parameter-DeliveryDocument.
      CONCATENATE lds_parameter-creationdate
                  lds_parameter-creationtime
             INTO DATA(ldf_creationdatetime).
      lds_zv900t-created_at            = ldf_creationdatetime.
      lds_zv900t-created_by            = lds_parameter-createdbyuser.
      lds_zv900t-del_flg               = lds_parameter-del_flg.
      lds_zv900t-last_changed_at       = ldf_timestamp.
      lds_zv900t-local_last_changed_at = ldf_timestamp.
      lds_zv900t-last_updated_by       = sy-uname.
    ENDIF.

    MODIFY zv900t FROM @lds_zv900t.
    IF sy-subrc = 0.
      lds_return-status           = 'OK'.
      lds_return-deliverydocument = lds_parameter-DeliveryDocument.
    ELSE.
      lds_return-status           = 'NG'.
      lds_return-deliverydocument = lds_parameter-DeliveryDocument.
    ENDIF.
    APPEND lds_return TO ldt_return.

    CALL TRANSFORMATION id SOURCE out = ldt_return
         RESULT XML p_out.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.


  METHOD udpate_zv900t.

    DATA:
      lt_xinput  TYPE cl_abap_parallel=>t_in_tab,
      lt_xoutput TYPE cl_abap_parallel=>t_out_tab,
      lv_xinput  TYPE LINE OF cl_abap_parallel=>t_in_tab,
      lw_xoutput TYPE LINE OF cl_abap_parallel=>t_out_tab,
      lds_str    TYPE gts_parameter.
    CLEAR:
      lv_xinput,
      lw_xoutput,
      lt_xinput,
      lt_xoutput.

    "lds_str-value1 = if_parameter.
    EXPORT param_input = is_parameter
      TO DATA BUFFER lv_xinput.
    APPEND lv_xinput TO lt_xinput.

    "p_in_tabがブランクだと動作しないため、値の設定が必要.
    run(
      EXPORTING
        p_in_tab  = lt_xinput
      IMPORTING
        p_out_tab = lt_xoutput
    ).

    IF NOT lt_xoutput IS INITIAL.
      lw_xoutput = lt_xoutput[ 1 ].
      DATA ldt_return TYPE gtt_return.
      IMPORT param_output = ldt_return
        FROM DATA BUFFER lw_xoutput-result.

      et_return = ldt_return.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
