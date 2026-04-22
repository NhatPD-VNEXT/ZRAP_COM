class ltcl_unit_test definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      language_is_e   for testing,
      iso_code_is_en  for testing.
endclass.


class ltcl_unit_test implementation.

  method language_is_e.
    cl_abap_unit_assert=>assert_equals(
      act = new zcl_default_language( )->get_language( )
      exp = 'E'
      msg = |パラメータ設定テーブル デフォルト言語 Div = F4_HELP|
    ).
  endmethod.

  method iso_code_is_en.
    cl_abap_unit_assert=>assert_equals(
      act = new zcl_default_language( )->get_language_iso( )
      exp = 'EN'
      msg = |パラメータ設定テーブル デフォルト言語 Div = F4_HELP|
    ).
  endmethod.

endclass.
