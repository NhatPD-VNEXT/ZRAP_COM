*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lcl_eve_outbounddelivery DEFINITION INHERITING FROM cl_abap_behavior_event_handler.

  PRIVATE SECTION.

    METHODS consume_Created FOR ENTITY EVENT Created_instances FOR OutboundDelivery~Created.

    METHODS consume_Changed FOR ENTITY EVENT Changed_instances FOR OutboundDelivery~Changed.

ENDCLASS.

CLASS lcl_eve_outbounddelivery IMPLEMENTATION.

  METHOD consume_Created.
    DATA:
      lds_ZV901T TYPE ZV901T,
      ldt_ZV901T TYPE
        STANDARD TABLE OF    ZV901T.
    CLEAR:
      lds_ZV901T,
      ldt_ZV901T.

    "25/9/2 IF全体をコメントアウト
*    "TEST用のため特定ユーザ(IPS)のみ処理.
*    IF sy-uname = 'CB9980000007'
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
*      .
*    ELSE.
*      RETURN.
*    ENDIF.

    "enter save phase
    cl_abap_tx=>save( ).

    CHECK created_instances IS NOT INITIAL.

    SELECT
      DeliveryDocument              ,
      DeliveryDocumentItem          ,
      ReferenceSDDocument           ,
      ReferenceSDDocumentItem       ,
      ReferenceSDDocumentCategory   ,
      CreationDate                  ,
      CreationTime                  ,
      CreatedByUser                 ,
      LastChangeDate
      FROM  I_DeliveryDocumentItem
      WITH PRIVILEGED ACCESS
      FOR ALL ENTRIES IN @created_instances
      WHERE DeliveryDocument = @created_instances-OutboundDelivery
      INTO  TABLE @DATA(ldt_DeliveryDocumentItem)
      .
    IF sy-subrc = 0.
      SORT ldt_DeliveryDocumentItem STABLE
        BY DeliveryDocument          ASCENDING
           DeliveryDocumentItem      ASCENDING
           .
    ELSE.
      RETURN.
    ENDIF.

    GET TIME STAMP FIELD DATA(ldf_timestamp).


    LOOP AT ldt_DeliveryDocumentItem INTO DATA(lds_DeliveryDocumentItem).
      CLEAR: lds_ZV901T.

      IF lds_DeliveryDocumentItem-DeliveryDocument        IS INITIAL
      OR lds_DeliveryDocumentItem-DeliveryDocumentItem    IS INITIAL
      OR lds_DeliveryDocumentItem-ReferenceSDDocument     IS INITIAL
      OR lds_DeliveryDocumentItem-ReferenceSDDocumentItem IS INITIAL
         .
        CONTINUE.
      ELSE.
      ENDIF.

      CONVERT
        DATE lds_DeliveryDocumentItem-CreationDate
        TIME lds_DeliveryDocumentItem-CreationTime
        INTO TIME STAMP DATA(ldf_CreationDateTime)
        TIME ZONE 'UTC'.

      lds_ZV901T-deliverydocument      = lds_DeliveryDocumentItem-DeliveryDocument.
      lds_ZV901T-deliverydocumentitem  = lds_DeliveryDocumentItem-DeliveryDocumentItem.
      lds_ZV901T-salesdocument         = lds_DeliveryDocumentItem-ReferenceSDDocument.
      lds_ZV901T-salesdocumentitem     = lds_DeliveryDocumentItem-ReferenceSDDocumentItem .
      lds_ZV901T-created_at            = ldf_CreationDateTime.
      lds_ZV901T-created_by            = lds_DeliveryDocumentItem-CreatedByUser.
      lds_ZV901T-last_changed_at       = ldf_timestamp.
      lds_ZV901T-last_updated_by       = sy-uname.
      lds_ZV901T-local_last_changed_at = ldf_timestamp.

      APPEND lds_ZV901T TO ldt_ZV901T.
    ENDLOOP.

    IF ldt_ZV901T IS NOT INITIAL.
      MODIFY ZV901T FROM TABLE @ldt_ZV901T.
    ELSE.
    ENDIF.

  ENDMETHOD.

  METHOD consume_changed.
    DATA:
      lds_ZV901T TYPE ZV901T,
      ldt_ZV901T TYPE
        STANDARD TABLE OF    ZV901T.
    CLEAR:
      lds_ZV901T,
      ldt_ZV901T.

    "25/9/2 IF全体をコメントアウト
*    "TEST用のため特定ユーザ(IPS)のみ処理.
*    IF sy-uname = 'CB9980000007'
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
*      .
*    ELSE.
*      RETURN.
*    ENDIF.

    "enter save phase
    cl_abap_tx=>save( ).

    CHECK Changed_instances IS NOT INITIAL.

    SELECT
      DeliveryDocument              ,
      DeliveryDocumentItem          ,
      ReferenceSDDocument           ,
      ReferenceSDDocumentItem       ,
      ReferenceSDDocumentCategory   ,
      CreationDate                  ,
      CreationTime                  ,
      CreatedByUser                 ,
      LastChangeDate
      FROM  I_DeliveryDocumentItem
      WITH PRIVILEGED ACCESS
      FOR ALL ENTRIES IN @Changed_instances
      WHERE DeliveryDocument = @Changed_instances-OutboundDelivery
      INTO  TABLE @DATA(ldt_DeliveryDocumentItem)
      .
    IF sy-subrc = 0.
      SORT ldt_DeliveryDocumentItem STABLE
        BY DeliveryDocument          ASCENDING
           DeliveryDocumentItem      ASCENDING
           .
    ELSE.
      RETURN.
    ENDIF.

    GET TIME STAMP FIELD DATA(ldf_timestamp).


    LOOP AT ldt_DeliveryDocumentItem INTO DATA(lds_DeliveryDocumentItem).
      CLEAR: lds_ZV901T.

      IF lds_DeliveryDocumentItem-DeliveryDocument        IS INITIAL
      OR lds_DeliveryDocumentItem-DeliveryDocumentItem    IS INITIAL
      OR lds_DeliveryDocumentItem-ReferenceSDDocument     IS INITIAL
      OR lds_DeliveryDocumentItem-ReferenceSDDocumentItem IS INITIAL
         .
        CONTINUE.
      ELSE.
      ENDIF.

      CONVERT
        DATE lds_DeliveryDocumentItem-CreationDate
        TIME lds_DeliveryDocumentItem-CreationTime
        INTO TIME STAMP DATA(ldf_CreationDateTime)
        TIME ZONE 'UTC'.

      lds_ZV901T-deliverydocument      = lds_DeliveryDocumentItem-DeliveryDocument.
      lds_ZV901T-deliverydocumentitem  = lds_DeliveryDocumentItem-DeliveryDocumentItem.
      lds_ZV901T-salesdocument         = lds_DeliveryDocumentItem-ReferenceSDDocument.
      lds_ZV901T-salesdocumentitem     = lds_DeliveryDocumentItem-ReferenceSDDocumentItem .
      lds_ZV901T-created_at            = ldf_CreationDateTime.
      lds_ZV901T-created_by            = lds_DeliveryDocumentItem-CreatedByUser.
      lds_ZV901T-last_changed_at       = ldf_timestamp.
      lds_ZV901T-last_updated_by       = sy-uname.
      lds_ZV901T-local_last_changed_at = ldf_timestamp.

      APPEND lds_ZV901T TO ldt_ZV901T.
    ENDLOOP.

    IF ldt_ZV901T IS NOT INITIAL.
      MODIFY ZV901T FROM TABLE @ldt_ZV901T.
    ELSE.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
