************************************************************************
*  [変更履歴]                                                          *
*   バージョン情報 ：V1.00  2024/12/02  NTZ Wind            NWFK900068 *
*   変更内容       ：新規作成                                          *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.01  2025/03/05  NTZ Wind            NWFK900068 *
*   変更内容       ：CSV インポートにパラメータ Codepage を追加する    *
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.02  2025/04/21  NTZ Wind            NWFK900068 *
*   変更内容       ：get_from_xlsx_multisheet メソッドを追加してください。*
*----------------------------------------------------------------------*
*   バージョン情報 ：V1.03  2025/05/25  NTZ Wind            NWFK900068 *
*   変更内容       ：スペースが消える問題を修正                        *
*----------------------------------------------------------------------*
*   バージョン情報 ：V9.99  YYYY/MM/DD  変更者             移送番号    *
*   変更内容       ：                                                  *
************************************************************************
************************************************************************
* [Change History]                                                     *
* Version Information: V1.00  2024/12/02  NTZ Wind          NWFK900068 *
* Change Details: Newly created                                        *
*----------------------------------------------------------------------*
* Version Information: V1.01  2025/03/05  NTZ Wind          NWFK900068 *
* Change Details: Add parameter Codepage to Import CSV                 *
*----------------------------------------------------------------------*
* Version Information: V1.02  2025/04/21  NTZ Wind          NWFK900068 *
* Change Details: Add method get_from_xlsx_multisheet                  *
*----------------------------------------------------------------------*
* Version Information: V1.03  2025/05/25  NTZ Wind          NWFK900068 *
* Change Details: Fixed Issue space disappear                  *
*----------------------------------------------------------------------*
* Version Information: V9.99 YYYY/MM/DD <Modifier>         <Tr.Number> *
* Change Details:                                                      *
************************************************************************

CLASS zcl_com_file_upload DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: gtf_mimetype TYPE c LENGTH 128,
           gtf_filename TYPE c LENGTH 128.

    CLASS-DATA: gf_csv_delimiter  TYPE c VALUE ',',
                gf_numb_delimiter TYPE c VALUE ',',
                gf_date_delimiter TYPE c VALUE '/'.

    CLASS-METHODS get_from_csv_data
      IMPORTING
        REFERENCE(if_data) TYPE xstring
        !if_start_row      TYPE i DEFAULT 2
*-< ADD V1.01 (S) >-*
        !if_codepage       TYPE REF TO if_xco_char_code_page DEFAULT xco_cp_character=>code_page->utf_8
*-< ADD V1.01 (E) >-*

      CHANGING
        ct_rows            TYPE STANDARD TABLE.

    CLASS-METHODS get_from_xlsx_data
      IMPORTING
        REFERENCE(if_data) TYPE xstring
        !if_start_row      TYPE i DEFAULT 2
      CHANGING
        ct_rows            TYPE STANDARD TABLE.

    CLASS-METHODS get_from_upload_data
      IMPORTING
        if_mimetype        TYPE gtf_mimetype
        !if_filename       TYPE gtf_filename DEFAULT ''
        REFERENCE(if_data) TYPE xstring
        !iv_start_row      TYPE i DEFAULT 2
*-< ADD V1.01 (S) >-*
        !if_codepage       TYPE REF TO if_xco_char_code_page DEFAULT xco_cp_character=>code_page->utf_8
*-< ADD V1.01 (E) >-*
      CHANGING
        ct_rows            TYPE STANDARD TABLE.

*-< ADD V1.02 (S) >-*
    TYPES: BEGIN OF gts_excelsheet,
             start_row TYPE i,
             rows      TYPE REF TO data,
           END OF gts_excelsheet.

    TYPES: gtt_excelsheet  TYPE STANDARD TABLE OF gts_excelsheet WITH DEFAULT KEY.

    CLASS-METHODS get_from_xlsx_multisheet
      IMPORTING
        REFERENCE(if_data) TYPE xstring
      CHANGING
        ct_data            TYPE gtt_excelsheet.
*-< ADD V1.02 (E) >-*

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-METHODS split_csv_line
      IMPORTING if_line           TYPE string
      RETURNING VALUE(rt_records) TYPE string_table.

    CLASS-METHODS to_date_value
      IMPORTING
                if_string      TYPE string
      RETURNING VALUE(ef_date) TYPE d.
    CLASS-METHODS boolean_not
      IMPORTING
                if_bool        TYPE abap_boolean
      RETURNING VALUE(rf_bool) TYPE abap_boolean.

ENDCLASS.



CLASS ZCL_COM_FILE_UPLOAD IMPLEMENTATION.


  METHOD boolean_not.
    IF if_bool = abap_true.
      rf_bool = abap_false.
    ELSE.
      rf_bool = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD get_from_csv_data.
    DATA: lo_strucdescr TYPE REF TO cl_abap_structdescr,
          lo_tabledescr TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS: <l_value> TYPE any.
    CLEAR ct_rows.

    lo_tabledescr ?= cl_abap_tabledescr=>describe_by_data( ct_rows ).
    lo_strucdescr ?= lo_tabledescr->get_table_line_type(  ).

    DATA(ldt_struccomp) = lo_strucdescr->get_components( ).
    DATA(ldf_struclen) = lines( ldt_struccomp ).

*-< UPD V1.01 (S) >-*
*    SPLIT xco_cp=>xstring( if_data )->as_string( xco_cp_character=>code_page->utf_8  )->value
*      AT cl_abap_char_utilities=>cr_lf
*      INTO TABLE DATA(ldt_csv_rows).

    SPLIT xco_cp=>xstring( if_data )->as_string( if_codepage )->value
      AT cl_abap_char_utilities=>cr_lf+1(1)
      INTO TABLE DATA(ldt_csv_rows).
*-< UPD V1.01 (E) >-*

    LOOP AT ldt_csv_rows ASSIGNING FIELD-SYMBOL(<l_csv_line>) FROM if_start_row.
      IF NOT <l_csv_line> IS INITIAL.
*-< UPD V1.01 (S) >-*
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf+0(1) IN <l_csv_line> WITH ''.
*-< UPD V1.01 (E) >-*

        DATA(ldt_linedata) = split_csv_line( <l_csv_line> ).
        APPEND INITIAL LINE TO ct_rows ASSIGNING FIELD-SYMBOL(<l_row>).

        LOOP AT ldt_linedata ASSIGNING FIELD-SYMBOL(<l_linedata>).
          TRY.
              DATA(ldf_cno) = sy-tabix.
              IF ldf_cno <= ldf_struclen.
                ASSIGN COMPONENT ldf_cno OF STRUCTURE <l_row> TO <l_value>.

                READ TABLE ldt_struccomp INDEX ldf_cno ASSIGNING FIELD-SYMBOL(<l_comp>).
                IF <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_date.
                  <l_value> = to_date_value( <l_linedata> ).
                ELSEIF <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_int        OR <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_int1     OR <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_int2       OR
                       <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_int8       OR <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_intf     OR
                       <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_float      OR <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_decfloat OR <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_decfloat16 OR
                       <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_decfloat34 OR <l_comp>-type->type_kind = cl_abap_typedescr=>typekind_packed.
                  REPLACE ALL OCCURRENCES OF gf_numb_delimiter IN <l_linedata> WITH ''.
                  CONDENSE <l_linedata> NO-GAPS.
                  IF NOT <l_linedata> IS INITIAL.
                    <l_value> = <l_linedata>.
                  ENDIF.
                ELSE.
                  <l_value> = <l_linedata>.
                ENDIF.
              ENDIF.
            CATCH cx_root INTO DATA(lx_root).
              DATA(lv_merror) = lx_root->get_text(  ).
          ENDTRY.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_from_upload_data.
    DATA: ldf_xlsx TYPE abap_boolean VALUE abap_false,
          ldf_csv  TYPE abap_boolean VALUE abap_false.

    IF if_mimetype = 'application/vnd.openxmlformats' OR
       if_mimetype = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'.
      ldf_xlsx = abap_true.
    ELSEIF if_mimetype = 'text/csv' OR if_mimetype = 'text/plain'.
      ldf_csv = abap_true.
    ELSEIF if_mimetype = 'application/octet-stream' AND NOT if_filename IS INITIAL.
      SPLIT if_filename AT '.' INTO TABLE DATA(ldt_filename_part).
      DATA(ldf_file_extension) = to_lower( ldt_filename_part[ lines( ldt_filename_part ) ] ).
      IF ldf_file_extension = 'xlsx'.
        ldf_xlsx = abap_true.
      ELSEIF ldf_file_extension = 'csv' OR ldf_file_extension = 'txt'.
        ldf_csv = abap_true.
      ENDIF.
    ENDIF.
    IF NOT if_data IS INITIAL.
      IF ldf_xlsx = abap_true.
        TRY.

            get_from_xlsx_data(
              EXPORTING
                if_data  = if_data
                if_start_row = iv_start_row
              CHANGING
                ct_rows = ct_rows
            ).

          CATCH cx_root INTO DATA(lo_root).
            DATA(lv_error1)   = lo_root->get_text( ).
            DATA(lv_elrror1)  = lo_root->get_longtext( ).
        ENDTRY.
      ELSEIF ldf_csv = abap_true.
        TRY.
            get_from_csv_data(
              EXPORTING
                if_data  = if_data
                if_start_row = iv_start_row
*-< ADD V1.01 (S) >-*
                if_codepage      = if_codepage
*-< ADD V1.01 (E) >-*
              CHANGING
                ct_rows = ct_rows
            ).
          CATCH cx_root INTO DATA(lo_root2).
            DATA(lv_error2)   = lo_root2->get_text( ).
            DATA(lv_elrror2)  = lo_root2->get_longtext( ).
        ENDTRY.
      ELSE.

      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_from_xlsx_data.
    DATA: lo_strucdescr TYPE REF TO cl_abap_structdescr,
          lo_tabledescr TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS: <l_value> TYPE any.
    CLEAR ct_rows.

    lo_tabledescr ?= cl_abap_tabledescr=>describe_by_data( ct_rows ).
    lo_strucdescr ?= lo_tabledescr->get_table_line_type(  ).

    DATA(ldt_struccomp) = lo_strucdescr->get_components( ).
    DATA(ldf_struclen) = lines( ldt_struccomp ).

    DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( if_data ).
    DATA(lo_read_access_xlsx) = lo_xlsx->read_access( ).
    DATA(lo_first_worksheet_xlsx) = lo_read_access_xlsx->get_workbook(  )->worksheet->at_position( 1 ).

    DATA(lo_selection_pattern_xlsx) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
      )->from_column( xco_cp_xlsx=>coordinate->for_numeric_value( 1 )
      )->to_column( xco_cp_xlsx=>coordinate->for_numeric_value( ldf_struclen )
      )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( if_start_row )
      )->get_pattern( ).

    lo_first_worksheet_xlsx->select( lo_selection_pattern_xlsx
      )->row_stream(
      )->operation->write_to( REF #( ct_rows )
      )->if_xco_xlsx_ra_operation~execute( ).
  ENDMETHOD.


  METHOD get_from_xlsx_multisheet.
*-< ADD V1.02 (S) >-*
    DATA: lo_strucdescr TYPE REF TO cl_abap_structdescr,
          lo_tabledescr TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS: <lf_value> TYPE any,
                   <lf_table> TYPE STANDARD TABLE.

    DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( if_data ).
    DATA(lo_read_access_xlsx) = lo_xlsx->read_access( ).
    DATA: lo_worksheet_xlsx TYPE REF TO if_xco_xlsx_ra_worksheet.


    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<lf_sdata>).
      DATA(lf_sheetno) = sy-tabix.

      ASSIGN <lf_sdata>-rows->* TO <lf_table>.
      CLEAR: <lf_table>.

      lo_tabledescr ?= cl_abap_tabledescr=>describe_by_data( <lf_table> ).
      lo_strucdescr ?= lo_tabledescr->get_table_line_type(  ).

      DATA(ldt_struccomp) = lo_strucdescr->get_components( ).
      DATA(ldf_struclen) = lines( ldt_struccomp ).

      lo_worksheet_xlsx = lo_read_access_xlsx->get_workbook(  )->worksheet->at_position( lf_sheetno ).

      DATA(lo_selection_pattern_xlsx) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(
        )->from_column( xco_cp_xlsx=>coordinate->for_numeric_value( 1 )
        )->to_column( xco_cp_xlsx=>coordinate->for_numeric_value( ldf_struclen )
        )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( <lf_sdata>-start_row )
        )->get_pattern( ).

      lo_worksheet_xlsx->select( lo_selection_pattern_xlsx
        )->row_stream(
        )->operation->write_to( REF #( <lf_table> )
        )->if_xco_xlsx_ra_operation~execute( ).

      FREE: lo_tabledescr,
            lo_strucdescr,
            lo_worksheet_xlsx.
      CLEAR: ldt_struccomp.
    ENDLOOP.
*-< ADD V1.02 (E) >-*
  ENDMETHOD.


  METHOD split_csv_line.
    CLEAR rt_records.

    DATA: ldf_line      TYPE string,
          ldf_temp      TYPE string,
          ldf_char      TYPE c LENGTH 1,

          ldf_in_quotes TYPE abap_bool.

*-< ADD V1.03 (S) >-*
    DATA: ldf_pchar      TYPE c LENGTH 1 VALUE IS INITIAL.
*-< ADD V1.03 (E) >-*

    CLEAR: ldf_temp, ldf_in_quotes.


    ldf_line = if_line.

    REPLACE ALL OCCURRENCES OF '""' IN ldf_line WITH |\\'\\'|.
    DO 3 TIMES.
      REPLACE ALL OCCURRENCES OF |{ gf_csv_delimiter }\\'\\'{ gf_csv_delimiter }| IN ldf_line WITH |{ gf_csv_delimiter }""{ gf_csv_delimiter }|.
    ENDDO.

    DATA(ldf_len1) = strlen(  ldf_line ).
    DATA(ldf_pos)  = ldf_len1 - 5.
    IF ldf_line+ldf_pos(5) = |{ gf_csv_delimiter }\\'\\'|.
      DATA(ldf_len2) = ldf_len1 - 5.
      ldf_line = ldf_line+0(ldf_len2) && gf_csv_delimiter && '""'.
    ENDIF.

    DATA(ldf_totchar) = strlen( ldf_line ).
*-< ADD V1.03 (S) >-*
    ldf_pchar = '*'.   " Dummy Character
*-< ADD V1.03 (E) >-*
    DO ldf_totchar TIMES.
      DATA(lv_idx) = sy-index - 1.

      ldf_char = ldf_line+lv_idx(1).

      IF ldf_char = '"'.
        ldf_in_quotes = boolean_not( ldf_in_quotes ).
      ELSEIF ldf_char = gf_csv_delimiter AND ldf_in_quotes = abap_false.
        REPLACE ALL OCCURRENCES OF |\\'\\'| IN ldf_temp WITH '"'.
        APPEND ldf_temp TO rt_records.
        CLEAR ldf_temp.
      ELSE.
*-< DEL V1.03 (S) >-*
*        CONCATENATE ldf_temp ldf_char INTO ldf_temp.
*-< DEL V1.03 (E) >-*

*-< ADD V1.03 (S) >-*
        IF ldf_pchar = space.
          CONCATENATE ldf_temp ldf_char INTO ldf_temp SEPARATED BY space.
        ELSE.
          CONCATENATE ldf_temp ldf_char INTO ldf_temp.
        ENDIF.
*-< ADD V1.03 (E) >-*
      ENDIF.

*-< ADD V1.03 (S) >-*
      ldf_pchar = ldf_char.
*-< ADD V1.03 (E) >-*
    ENDDO.

    IF ldf_temp IS NOT INITIAL.
      APPEND ldf_temp TO rt_records.
    ENDIF.

  ENDMETHOD.


  METHOD to_date_value.
    CLEAR ef_date.

    DATA: ldf_textdate TYPE c LENGTH 15.

    ldf_textdate = if_string.
    REPLACE ALL OCCURRENCES OF gf_date_delimiter IN ldf_textdate WITH ''.
    CONDENSE ldf_textdate NO-GAPS.
    ef_date = ldf_textdate.
  ENDMETHOD.
ENDCLASS.
