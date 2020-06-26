CLASS zcl_zgw100_87_borrrfc_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zgw100_87_borrrfc_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
  PROTECTED SECTION.
    METHODS suptextset_get_entityset REDEFINITION.
    METHODS suptextset_get_entity REDEFINITION.
    METHODS suptextset_create_entity REDEFINITION.
    METHODS suptextset_update_entity REDEFINITION.
    METHODS suptextset_delete_entity REDEFINITION.

    METHODS agencyset_get_entity REDEFINITION.
    METHODS agencyset_create_entity
        REDEFINITION .
    METHODS agencyset_delete_entity
        REDEFINITION .
    METHODS agencyset_get_entityset
        REDEFINITION .
  PRIVATE SECTION.
    DATA: gt_agencyset  TYPE zcl_zgw100_87_borrrfc_mpc=>tt_agency,
          gt_countryset TYPE zcl_zgw100_87_borrrfc_mpc=>tt_suptext.
ENDCLASS.



CLASS zcl_zgw100_87_borrrfc_dpc_ext IMPLEMENTATION.
  METHOD agencyset_create_entity.

  ENDMETHOD.


  METHOD agencyset_delete_entity.

  ENDMETHOD.


  METHOD agencyset_get_entityset.
    DATA: wa_country TYPE zcl_zgw100_87_borrrfc_mpc=>ts_suptext.
    DATA(lv_source_entity) = io_tech_request_context->get_source_entity_type_name( ).

    CASE io_tech_request_context->get_source_entity_type_name( ).
      WHEN zcl_zgw100_87_borrrfc_mpc=>gc_suptext.
        io_tech_request_context->get_converted_source_keys(
          IMPORTING
            es_key_values = wa_country
        ).
        DATA cc TYPE c LENGTH 3.
        cc = wa_country-countryid .
        et_entityset = VALUE #( FOR wa IN gt_agencyset WHERE ( country_code = cc )
        ( wa ) ).
      WHEN OTHERS.
        SELECT * FROM z87_agency INTO TABLE @et_entityset.
        IF et_entityset IS INITIAL.
          et_entityset = gt_agencyset.
        ENDIF.
    ENDCASE.

  ENDMETHOD.
  METHOD agencyset_get_entity.
    io_tech_request_context->get_converted_keys(
      IMPORTING
        es_key_values = er_entity
    ).
    er_entity = VALUE #( gt_agencyset[ agency_id = er_entity-agency_id ] OPTIONAL ).
  ENDMETHOD.

  METHOD suptextset_get_entityset.
*  Get paging
    DATA ls_paging TYPE /iwbep/s_mgw_paging.
    ls_paging-top = io_tech_request_context->get_top( ).
    ls_paging-skip = io_tech_request_context->get_skip( ).

*  Get filter
    DATA(lt_filter) = io_tech_request_context->get_filter( )->get_filter_select_options( ).
    LOOP AT gt_countryset ASSIGNING FIELD-SYMBOL(<wa>) WHERE (
                                countryid IN VALUE #( lt_filter[ property = 'COUNTRYID' ]-select_options OPTIONAL ) ).
      et_entityset = VALUE #( BASE et_entityset ( <wa> ) ).
      IF lines( et_entityset ) EQ ls_paging-top.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF ls_paging-skip IS NOT INITIAL.
      DELETE et_entityset TO ls_paging-skip.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( ).
    gt_agencyset = VALUE #(
   ( agency_id = 123456 name = 'safsdfgaf' country_code = '001' )
   ( agency_id = 123457 name = 'safsdfgxx' country_code = '002' )
   ( agency_id = 123458 name = 'safsdfgaf' country_code = '001' )
   ).
    gt_countryset = VALUE #(
     ( countryid = '001' longtext = 'pais1' )
     ( countryid = '002' longtext = 'pais2' )
     ( countryid = '003' longtext = 'pais3' )
     ).

  ENDMETHOD.

  METHOD suptextset_get_entity.
    io_tech_request_context->get_converted_keys(
      IMPORTING
        es_key_values = er_entity
    ).
    er_entity = VALUE #( gt_countryset[ countryid = er_entity-countryid ] OPTIONAL ).
  ENDMETHOD.

  METHOD suptextset_create_entity.
    DATA ls_entry_data TYPE zcl_zgw100_87_borrrfc_mpc=>ts_suptext.
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = ls_entry_data
    ).
    gt_countryset = VALUE #( BASE gt_countryset ( ls_entry_data ) ).
    er_entity = ls_entry_data.
  ENDMETHOD.

  METHOD suptextset_update_entity.
    DATA ls_entry_data TYPE zcl_zgw100_87_borrrfc_mpc=>ts_suptext.
    io_tech_request_context->get_converted_keys(
      IMPORTING
        es_key_values = ls_entry_data
    ).
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = ls_entry_data
    ).
    TRY.
        gt_countryset[ countryid = ls_entry_data-countryid ] = ls_entry_data.
      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.

  METHOD suptextset_delete_entity.
    DATA ls_entry_data TYPE zcl_zgw100_87_borrrfc_mpc=>ts_suptext.
    io_tech_request_context->get_converted_keys(
      IMPORTING
        es_key_values = ls_entry_data
    ).
  ENDMETHOD.

ENDCLASS.
