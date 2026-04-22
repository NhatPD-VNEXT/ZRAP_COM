class zcl_rap_query_for_h4help definition public final create public.
  public section.
    class-methods:
      "! OData GET implementation
      select importing
        im_source_entity  type tabname
        im_target_entity  type tabname
        im_request        type ref to if_rap_query_request
        im_response       type ref to if_rap_query_response
        raising cx_rap_query_provider.
  protected section.
  private section.
    class-data:
      r_source_table      type ref to data,
      r_target_table      type ref to data,
      begin of s_sql,
        from              type tabname,
        where             type string,
        orderby           type string,
        rows              type int8,
        offset            type int8,
      end   of s_sql.
    class-methods:
      "! ソート条件テキスト変換
      get_as_sort_string importing
        im_sort_elements  type if_rap_query_request=>tt_sort_elements
        im_default_key    type abap_keyname
        returning value(rv_string) type string
        .
ENDCLASS.



CLASS ZCL_RAP_QUERY_FOR_H4HELP IMPLEMENTATION.


  method get_as_sort_string.
    loop at im_sort_elements assigning field-symbol(<element>).
      rv_string = switch #( <element>-descending
        when abap_true
          then |{ rv_string } { <element>-element_name } DESCENDING |
          else |{ rv_string } { <element>-element_name } ASCENDING |
      ).
    endloop.
    rv_string = cond #( when rv_string is initial then | { im_default_key } ASCENDING | else rv_string ).
  endmethod.


  method select.
**********************************************************************
*   動的変数定義｜ソース
**********************************************************************
    data(ldr_source_descr)  = cast cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( im_source_entity ) ).
    data(ldr_source_table)  = cast cl_abap_tabledescr( cl_abap_tabledescr=>create( p_line_type = ldr_source_descr ) ).
    create data r_source_table type handle ldr_source_table.
    assign r_source_table->* to field-symbol(<source_table>).
**********************************************************************
*   動的変数定義｜ターゲット
**********************************************************************
    data(ldr_target_descr)  = cast cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( im_target_entity ) ).
    data(ldr_target_table)  = cast cl_abap_tabledescr( cl_abap_tabledescr=>create( p_line_type = ldr_target_descr ) ).
    create data r_target_table type handle ldr_target_table.
    assign r_target_table->* to field-symbol(<target_table>).
    data(ldt_target_key)    = ldr_target_table->key[ 1 ]-name.
**********************************************************************
*   リクエスト変換
**********************************************************************
    try.
      s_sql = value #(
        from    = cl_abap_dyn_prg=>check_table_or_view_name_str( val = im_source_entity packages = 'ZCUSTOM_DEVELOPMENT' incl_sub_packages = abap_true )
        where   = im_request->get_filter( )->get_as_sql_string( )
        orderby = get_as_sort_string( im_sort_elements = im_request->get_sort_elements( ) im_default_key = ldt_target_key )
        rows    = cond #( let ldf_size = im_request->get_paging( )->get_page_size( ) in when ldf_size < 0 then 1 else ldf_size )
        offset  = im_request->get_paging( )->get_offset( )
      ).
    catch cx_abap_not_a_table cx_abap_not_in_package into data(lcx_error).
      raise exception type lcx_rap_query_provider exporting textid = value #( msgid = 'SY' msgno = 002 attr1 = lcx_error->get_text( ) ).
    endtry.
**********************************************************************
*   ソース取得
**********************************************************************
    select * from (s_sql-from) where (s_sql-where) order by (s_sql-orderby) into table @<source_table> up to @s_sql-rows rows offset @s_sql-offset options privileged access.
**********************************************************************
*   ターゲットマッピング
**********************************************************************
    move-corresponding <source_table> to <target_table>.
    im_response->set_total_number_of_records( lines( <target_table> ) ).
    im_response->set_data( <target_table> ).
  endmethod.
ENDCLASS.
