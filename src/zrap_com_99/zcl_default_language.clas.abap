class zcl_default_language definition public final create public.
  public section.
    methods:
      "! デフォルト言語取得<br>
      "! パラメータ設定テーブル未設定：ログイン言語
      constructor,
      "! 言語キー取得
      get_language        returning value(rv_language) type I_Language-Language,
      "! ISO言語キー取得
      get_language_iso    returning value(rv_language) type I_Language-LanguageISOCode.
  protected section.
  private section.
    data:
      s_default_language  type I_Language.
ENDCLASS.



CLASS ZCL_DEFAULT_LANGUAGE IMPLEMENTATION.


  method constructor.
    select single Div,Zztype,Zzseqno,Zztypename,cast( Zzvalue01 as lang ) as default_language
      from zi_yf001_01 with privileged access
      where Div = 'F4_HELP' and Zztype = 'A' and Zzseqno = '0001'
      into @data(ls_parameter).

    if ls_parameter-default_language is initial.
      ls_parameter-default_language = sy-langu.
    endif.

    select single * from I_Language with privileged access
      where Language = @ls_parameter-default_language
      into @s_default_language.
  endmethod.


  method get_language.
    rv_language = s_default_language-Language.
  endmethod.


  method get_language_iso.
    rv_language = s_default_language-LanguageISOCode.
  endmethod.
ENDCLASS.
