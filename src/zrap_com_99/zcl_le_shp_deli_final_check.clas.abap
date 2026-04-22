*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2025/06/03  M.OKADA            NWFK900068  *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
CLASS zcl_le_shp_deli_final_check DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_le_shp_delivery_fin_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LE_SHP_DELI_FINAL_CHECK IMPLEMENTATION.


  METHOD if_le_shp_delivery_fin_check~delivery_final_check.

    DATA:
      ldf_in        TYPE xstring,
      ldt_in        TYPE cl_abap_parallel=>t_in_tab,
      ldt_out       TYPE zcl_zv900t_update=>gtt_return,
      lds_parameter TYPE zcl_zv900t_update=>gts_parameter.
    CLEAR:
      ldf_in,
      ldt_in,
      ldt_out,
      lds_parameter.

    "25/6/23 IF全体をコメントアウト
*    "TEST用のため特定ユーザのみ処理.
*    IF sy-uname = 'CB9980000007'
*    "25/6/3 IPSユーザのみ対象.
*    OR sy-uname = 'CB9980000000'
*    OR sy-uname = 'CB9980000094'
*    OR sy-uname = 'CB9980000001'
*    OR sy-uname = 'CB9980000002'
*    OR sy-uname = 'CB9980000003'
*    OR sy-uname = 'CB9980000004'
*    OR sy-uname = 'CB9980000005'
*    OR sy-uname = 'CB9980000006'
*    OR sy-uname = 'CB9980000008'
*    OR sy-uname = 'CB9980000009'
*    OR sy-uname = 'CB9980000010'
*    OR sy-uname = 'CB9980000011'
*    OR sy-uname = 'CB9980000012'
*    OR sy-uname = 'CB9980000013'
*    OR sy-uname = 'CB9980000014'
*    OR sy-uname = 'CB9980000015'
*    OR sy-uname = 'CB9980000017'
*    OR sy-uname = 'CB9980000018'
*    OR sy-uname = 'CB9980000019'
*    OR sy-uname = 'CB9980000020'
*    OR sy-uname = 'CB9980000021'
*    OR sy-uname = 'CB9980000022'
*    OR sy-uname = 'CB9980000023'
*    OR sy-uname = 'CB9980000024'
*    OR sy-uname = 'CB9980000025'
*    OR sy-uname = 'CB9980000026'
*    OR sy-uname = 'CB9980000055'
*    OR sy-uname = 'CB9980000056'
*    OR sy-uname = 'CB9980000070'
*    OR sy-uname = 'CB9980000081'
*    OR sy-uname = 'CB9980000054'
*       .
*    ELSE.
*      RETURN.
*    ENDIF.

    "変更時のみ処理.
    "※登録時は未採番のため対象外.
    IF DOCUMENTPROCESSINGMODE = 'CHANGE'.
    ELSE.
      RETURN.
    ENDIF.

    "出荷伝票  変更日時管理テーブル 処理実行.
    DATA(lo_zcl_zv900t_update) = NEW zcl_zv900t_update(
      p_num_tasks = 1
      ).

    lds_parameter-deliverydocument = DELIVERY_DOCUMENT_IN-deliverydocument.
    lds_parameter-CreationDate     = DELIVERY_DOCUMENT_IN-CreationDate.
    lds_parameter-CreationTime     = DELIVERY_DOCUMENT_IN-CreationTime.
    lds_parameter-CreatedByUser    = DELIVERY_DOCUMENT_IN-CreatedByUser.

    "削除判定
    "※メニューの削除のみ、使用する前提のロジック
    IF DELIVERY_DOCUMENT_ITEMS_IN[] IS INITIAL.
      lds_parameter-del_flg = 'X'.
    ELSE.
    ENDIF.

    CALL TRANSFORMATION id SOURCE in = lds_parameter
         RESULT XML ldf_in.
    INSERT ldf_in INTO TABLE ldt_in.

    lo_zcl_zv900t_update->run(
      EXPORTING
        p_in_tab  = ldt_in
      IMPORTING
        p_out_tab = DATA(ldt_out_tab)
    ).

  ENDMETHOD.
ENDCLASS.
