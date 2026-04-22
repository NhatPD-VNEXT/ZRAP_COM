CLASS zcl_com_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: gtf_amountout TYPE p LENGTH 16 DECIMALS 4.
    TYPES: gtf_datetext TYPE c LENGTH 10.

    CLASS-METHODS conv_cunit_in
      IMPORTING
        if_input         TYPE i_purchaseorderitemapi01-baseunit
      RETURNING
        VALUE(rf_output) TYPE i_purchaseorderitemapi01-baseunit.

    CLASS-METHODS conv_cunit_out
      IMPORTING
        if_input         TYPE i_purchaseorderitemapi01-baseunit
      RETURNING
        VALUE(rf_output) TYPE i_purchaseorderitemapi01-baseunit.

    CLASS-METHODS conv_matn1_in
      IMPORTING
        if_input         TYPE i_purchaseorderitemapi01-material
      RETURNING
        VALUE(rf_output) TYPE i_purchaseorderitemapi01-material.

    CLASS-METHODS conv_matn1_out
      IMPORTING
        if_input         TYPE i_purchaseorderitemapi01-material
      RETURNING
        VALUE(rf_output) TYPE i_purchaseorderitemapi01-material.

    CLASS-METHODS amount_in
      IMPORTING
        if_amountout       TYPE any
        if_currency        TYPE i_companycode-currency
      RETURNING
        VALUE(rv_amountin) TYPE i_purchaseorderitemapi01-netpriceamount.

    CLASS-METHODS amount_out
      IMPORTING
        if_amountin         TYPE any
        if_currency         TYPE i_companycode-currency
      RETURNING
        VALUE(rf_amountout) TYPE gtf_amountout.

    CLASS-METHODS get_key_from_text
      IMPORTING
        if_text TYPE any
      CHANGING
        cf_key  TYPE any.

    CLASS-METHODS conv_auart_in
      IMPORTING
        if_input         TYPE i_salesorder-salesordertype
      RETURNING
        VALUE(rf_output) TYPE i_salesorder-salesordertype.

    CLASS-METHODS conv_auart_out
      IMPORTING
        if_input         TYPE i_salesorder-salesordertype
      RETURNING
        VALUE(rf_output) TYPE i_salesorder-salesordertype.

    CLASS-METHODS conv_date_in
      IMPORTING
        VALUE(if_datein)  TYPE gtf_datetext
      RETURNING
        VALUE(rf_dateout) TYPE d.

     CLASS-METHODS conv_pstyp_in
      IMPORTING
        if_input         TYPE i_purchaserequisitionitemapi01-PurchasingDocumentItemCategory
      RETURNING
        VALUE(rf_output) TYPE PSTYP.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_COM_CONV IMPLEMENTATION.


  METHOD amount_in.
    DATA: ldf_amount TYPE i_purchaseorderitemapi01-netpriceamount,
          ldf_multi  TYPE p LENGTH 10 DECIMALS 0.

    SELECT SINGLE FROM i_currency WITH PRIVILEGED ACCESS
      FIELDS currency,
             decimals
      WHERE currency = @if_currency
      INTO @DATA(lds_curr).

    ldf_multi = 10 ** lds_curr-decimals.
    ldf_amount = if_amountout.
    ldf_amount = ldf_amount * ldf_multi / 100.

    rv_amountin = ldf_amount.
  ENDMETHOD.


  METHOD amount_out.
    DATA: ldf_amount TYPE gtf_amountout,
          ldf_multi  TYPE p LENGTH 10 DECIMALS 0.

    SELECT SINGLE FROM i_currency WITH PRIVILEGED ACCESS
      FIELDS currency,
             decimals
      WHERE currency = @if_currency
      INTO @DATA(lds_curr).

    ldf_multi = 10 ** lds_curr-decimals.
    ldf_amount = if_amountin.
    ldf_amount = ldf_amount * 100 / ldf_multi.

    rf_amountout = ldf_amount.
  ENDMETHOD.


  METHOD conv_auart_in.
    DATA: ldt_datao  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-ext_format  = if_input.
    lds_data-objtype     = 'VBAK'.
    lds_data-method      = 'COPY'.
    lds_data-parameter   = 'DOCUMENTTYPE'.

    APPEND lds_data TO ldt_datao.

    CALL FUNCTION 'BAPI_CONVERSION_EXT2INT1'
      TABLES
        data   = ldt_datao
        return = ldt_return.
    IF NOT ldt_datao IS INITIAL.
      rf_output = ldt_datao[ 1 ]-int_format.
    ENDIF.
  ENDMETHOD.


  METHOD conv_auart_out.
    DATA: ldt_datai  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-int_format  = if_input.
    lds_data-objtype     = 'VBAK'.
    lds_data-method      = 'COPY'.
    lds_data-parameter   = 'DOCUMENTTYPE'.

    APPEND lds_data TO ldt_datai.

    CALL FUNCTION 'BAPI_CONVERSION_INT2EXT1'
      TABLES
        data   = ldt_datai
        return = ldt_return.
    IF NOT ldt_datai IS INITIAL.
      rf_output = ldt_datai[ 1 ]-ext_format.
    ENDIF.
  ENDMETHOD.


  METHOD conv_cunit_in.
    DATA: ldt_datao  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-ext_format  = if_input.
    lds_data-objtype     = 'BUS1001'.
    lds_data-method      = 'AVAILABILITY'.
    lds_data-parameter   = 'UNIT'.

    APPEND lds_data TO ldt_datao.

    CALL FUNCTION 'BAPI_CONVERSION_EXT2INT1'
      TABLES
        data   = ldt_datao
        return = ldt_return.
    IF NOT ldt_datao IS INITIAL.
      rf_output = ldt_datao[ 1 ]-int_format.
    ENDIF.
  ENDMETHOD.


  METHOD conv_cunit_out.
    DATA: ldt_datai  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-int_format  = if_input.
    lds_data-objtype     = 'BUS1001'.
    lds_data-method      = 'AVAILABILITY'.
    lds_data-parameter   = 'UNIT'.

    APPEND lds_data TO ldt_datai.

    CALL FUNCTION 'BAPI_CONVERSION_INT2EXT1'
      TABLES
        data   = ldt_datai
        return = ldt_return.
    IF NOT ldt_datai IS INITIAL.
      rf_output = ldt_datai[ 1 ]-ext_format.
    ENDIF.
  ENDMETHOD.


  METHOD conv_date_in.
    DATA(ldf_len) = strlen( if_datein ).
    DATA: ldf_datetext TYPE gtf_datetext.

    IF ldf_len = 6.   " YYMMDD
      rf_dateout = |20{ if_datein }|.
    ELSEIF ldf_len = 8. " YY/MM/DD, YY-MM-DD, YYYYMMDD
      FIND '/' IN if_datein.
      IF sy-subrc = 0.  " YY/MM/DD
        ldf_datetext = if_datein.
        REPLACE ALL OCCURRENCES OF '/' IN ldf_datetext WITH ''.
        rf_dateout = |20{ ldf_datetext }|.
      ELSE.
        FIND '-' IN if_datein.
        IF sy-subrc = 0.  " YY-MM-DD
          ldf_datetext = if_datein.
          REPLACE ALL OCCURRENCES OF '-' IN ldf_datetext WITH ''.
          rf_dateout = |20{ ldf_datetext }|.
        ELSE.   " YYYYMMDD
          rf_dateout = if_datein.
        ENDIF.
      ENDIF.

    ELSEIF ldf_len = 10.
      ldf_datetext = if_datein.
      REPLACE ALL OCCURRENCES OF '-' IN ldf_datetext WITH ''.
      REPLACE ALL OCCURRENCES OF '/' IN ldf_datetext WITH ''.
      rf_dateout = ldf_datetext.
    ENDIF.

  ENDMETHOD.


  METHOD conv_matn1_in.
    DATA: ldt_datao  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-ext_format  = if_input.
    lds_data-objtype     = 'BUS2032'.
    lds_data-method      = 'GETLIST'.
    lds_data-parameter   = 'MATERIALLONG'.

    APPEND lds_data TO ldt_datao.

    CALL FUNCTION 'BAPI_CONVERSION_EXT2INT1'
      TABLES
        data   = ldt_datao
        return = ldt_return.
    IF NOT ldt_datao IS INITIAL.
      rf_output = ldt_datao[ 1 ]-int_format.
    ENDIF.
  ENDMETHOD.


  METHOD conv_matn1_out.
    DATA: ldt_datai  TYPE TABLE OF bapiconvrs VALUE IS INITIAL,
          lds_data   TYPE bapiconvrs VALUE IS INITIAL,
          ldt_return TYPE TABLE OF  bapiret2.

    CLEAR lds_data.
    lds_data-int_format  = if_input.
    lds_data-objtype     = 'BUS2032'.
    lds_data-method      = 'GETLIST'.
    lds_data-parameter   = 'MATERIALLONG'.

    APPEND lds_data TO ldt_datai.

    CALL FUNCTION 'BAPI_CONVERSION_INT2EXT1'
      TABLES
        data   = ldt_datai
        return = ldt_return.
    IF NOT ldt_datai IS INITIAL.
      rf_output = ldt_datai[ 1 ]-ext_format.
    ENDIF.
  ENDMETHOD.


   METHOD conv_pstyp_in.
    DATA: ldf_pstyp TYPE pstyp,
          ldf_multi  TYPE p LENGTH 10 DECIMALS 0.

      SELECT SINGLE FROM  I_PurgDocumentItemCategoryText WITH PRIVILEGED ACCESS
      FIELDS PurchasingDocumentItemCategory
      WHERE  PurgDocExternalItemCategory = @if_input
      INTO @DATA(lds_curr).
      if sy-subrc eq 0.
        rf_output = lds_curr.
      endif.


  ENDMETHOD.


  METHOD get_key_from_text.
    DATA: ldf_text TYPE c LENGTH 255.

    ldf_text = if_text.

    CONDENSE ldf_text.

    IF ldf_text IS INITIAL.
      CLEAR cf_key.
    ELSE.
      DATA(ldf_endpos) = strlen( ldf_text ) - 1.
      IF ldf_text+ldf_endpos(1) = ')'.
        DATA(ldf_begin) = ldf_endpos.

        DO ldf_endpos TIMES.
          ldf_begin = ldf_begin - 1.
          IF ldf_text+ldf_begin(1) = '('.
            EXIT.
          ENDIF.
        ENDDO.

        ldf_begin = ldf_begin + 1.
        DATA(ldf_len) = ldf_endpos - ldf_begin.

        IF ldf_len > 0.
          cf_key = ldf_text+ldf_begin(ldf_len).
        ELSE.
          CLEAR cf_key.
        ENDIF.

      ELSE.
        cf_key = ldf_text.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
