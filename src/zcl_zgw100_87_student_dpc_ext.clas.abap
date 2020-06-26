CLASS zcl_zgw100_87_student_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zgw100_87_student_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
    METHODS /iwbep/if_mgw_appl_srv_runtime~execute_action REDEFINITION.
    METHODS /iwbep/if_mgw_appl_srv_runtime~get_expanded_entity REDEFINITION.
    METHODS /iwbep/if_mgw_appl_srv_runtime~create_deep_entity REDEFINITION.
    METHODS /iwbep/if_mgw_appl_srv_runtime~get_stream REDEFINITION.
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
    DATA: gt_agencyset  TYPE zcl_zgw100_87_student_mpc=>tt_agency,
          gt_countryset TYPE zcl_zgw100_87_student_mpc=>tt_suptext.
ENDCLASS.



CLASS zcl_zgw100_87_student_dpc_ext IMPLEMENTATION.


  METHOD agencyset_create_entity.
**TRY.
*CALL METHOD SUPER->AGENCYSET_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          = iv_entity_name
*    IV_ENTITY_SET_NAME      = iv_entity_set_name
*    IV_SOURCE_NAME          = iv_source_name
*    IT_KEY_TAB              = it_key_tab
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      = it_navigation_path
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  ENDMETHOD.


  METHOD agencyset_delete_entity.

  ENDMETHOD.


  METHOD agencyset_get_entityset.
**TRY.
*CALL METHOD SUPER->AGENCYSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =  IV_ENTITY_NAME
*    IV_ENTITY_SET_NAME       =  IV_ENTITY_SET_NAME
*    IV_SOURCE_NAME           =  IV_SOURCE_NAME
*    IT_FILTER_SELECT_OPTIONS =  IT_FILTER_SELECT_OPTIONS
*    IS_PAGING                =  IS_PAGING
*    IT_KEY_TAB               =  IT_KEY_TAB
*    IT_NAVIGATION_PATH       =  IT_NAVIGATION_PATH
*    IT_ORDER                 =  IT_ORDER
*    IV_FILTER_STRING         =  IV_FILTER_STRING
*    IV_SEARCH_STRING         =  IV_SEARCH_STRING
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

*    mo_context->get_message_container( )->add_message(
*      EXPORTING
*        iv_msg_type               = 'E'
*        iv_msg_id                 = 'T1'
*        iv_msg_number             = 01
*        iv_msg_text               = 'asdsafa'
**        iv_msg_v1                 =
**        iv_msg_v2                 =
**        iv_msg_v3                 =
**        iv_msg_v4                 =
**        iv_error_category         =
**        iv_is_leading_message     = abap_true
**        iv_entity_type            =
**        it_key_tab                =
**        iv_add_to_response_header = abap_false
**        iv_message_target         =
**        iv_is_transition_message  = abap_false
*    ).
*  RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*    EXPORTING
*      textid                 = /iwbep/cx_mgw_busi_exception=>business_error
**      previous               =
*      message_container      = mo_context->get_message_container( )
**      http_status_code       =
**      http_header_parameters =
**      sap_note_id            =
**      msg_code               =
**      exception_category     =
**      entity_type            =
**      message                =
**      message_unlimited      =
**      filter_param           =
**      operation_no           =
*  .
    DATA: wa_country TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
*         lv_source_entity TYPE /iwbep/mgw_tech_name.
    DATA(lv_source_entity) = io_tech_request_context->get_source_entity_type_name( ).

    CASE io_tech_request_context->get_source_entity_type_name( ).
      WHEN zcl_zgw100_87_student_mpc=>gc_suptext.
        io_tech_request_context->get_converted_source_keys(
          IMPORTING
            es_key_values = wa_country
        ).
        DATA cc TYPE c LENGTH 3.
        cc = wa_country-countryid .
        et_entityset = VALUE #( FOR wa IN gt_agencyset WHERE ( country_code = cc )
        ( wa ) ).
      WHEN OTHERS.
        SELECT * FROM z87_agency INTO CORRESPONDING FIELDS OF TABLE @et_entityset.
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
*    Get MIME type
    IF er_entity-web_address IS NOT INITIAL.
      cl_mime_repository_api=>if_mr_api~get_api( )->get(
        EXPORTING
          i_url                  = er_entity-web_address
        IMPORTING
          e_mime_type            = er_entity-mime_type
        EXCEPTIONS
          parameter_missing      = 1
          error_occured          = 2
          not_found              = 3
          permission_failure     = 4
          OTHERS                 = 5
      ).
    ENDIF.
  ENDMETHOD.

  METHOD suptextset_get_entityset.
*  Get paging
    DATA ls_paging TYPE /iwbep/s_mgw_paging.
    ls_paging-top = io_tech_request_context->get_top( ).
    ls_paging-skip = io_tech_request_context->get_skip( ).

*  Get filter
    DATA(lt_filter) = io_tech_request_context->get_filter( )->get_filter_select_options( ).
*    et_entityset = VALUE #(
*                                FOR wa IN gt_countryset
*                                WHERE (
*                                countryid IN VALUE #( lt_filter[ property = 'COUNTRYID' ]-select_options OPTIONAL ) )
*                                ( wa ) ).

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
*    er_entity-changedat = '20150220083833.5930000'.
  ENDMETHOD.

  METHOD suptextset_create_entity.
    DATA ls_entry_data TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = ls_entry_data
    ).
    gt_countryset = VALUE #( BASE gt_countryset ( ls_entry_data ) ).
    er_entity = ls_entry_data.
  ENDMETHOD.

  METHOD suptextset_update_entity.
    DATA ls_entry_data TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
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
    DATA ls_entry_data TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
    io_tech_request_context->get_converted_keys(
      IMPORTING
        es_key_values = ls_entry_data
    ).
  ENDMETHOD.

  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
    DATA: lv_function_name        TYPE /iwbep/mgw_tech_name,
          ls_confirm_order_params TYPE zcl_zgw100_87_student_mpc=>ts_confirmorder.
    DATA: lt_return     TYPE TABLE OF bapiret2,
          ls_so_id      TYPE bapi_epm_so_id,
          ls_headerdata TYPE bapi_epm_so_header,
          ls_entity     TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
* Get function import name
    lv_function_name = io_tech_request_context->get_function_import_name( ).
    CASE lv_function_name.
      WHEN 'ConfirmOrder'.
        " Get function import parameters
        io_tech_request_context->get_converted_parameters(
        IMPORTING
        es_parameter_values = ls_confirm_order_params ).
        ls_so_id-so_id = ls_confirm_order_params-salesorderid.
*        CALL FUNCTION 'BAPI_EPM_SO_CONFIRM'
*          EXPORTING
*            so_id  = ls_so_id
*          TABLES
*            return = lt_return.
*
*        IF lt_return IS NOT INITIAL.
*          mo_context->get_message_container( )->add_messages_from_bapi( lt_return ).
*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              textid            = /iwbep/cx_mgw_busi_exception=>business_error
*              message_container = mo_context->get_message_container( ).
*        ELSE.
*          CALL FUNCTION 'BAPI_EPM_SO_GET_DETAIL'
*            EXPORTING
*              so_id      = ls_so_id
*            IMPORTING
*              headerdata = ls_headerdata.
        MOVE-CORRESPONDING ls_headerdata TO ls_entity.
        me->copy_data_to_ref(
        EXPORTING
          is_data = ls_entity
        CHANGING
          cr_data = er_data ).
*        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entity.
    DATA(comp_name) = |AGENCIES|.
    DATA(lv_entity_name) = io_tech_request_context->get_entity_type_name( ).
    DATA(res) = io_expand->compare_to_tech_names( comp_name ).
    DATA(res1) = io_expand->gcs_compare_result-match_equals.
    TYPES: ls TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
    DATA(ls) = VALUE ls( countryid = res1  ).
    me->copy_data_to_ref(
      EXPORTING
        is_data = ls
      CHANGING
        cr_data = er_entity
    ).
    DATA(ls_expanded_clause) = comp_name.
    et_expanded_tech_clauses = VALUE #( ( ls_expanded_clause ) ).
*    super->/iwbep/if_mgw_appl_srv_runtime~get_expanded_entity(
*      EXPORTING
*        iv_entity_name           =
*        iv_entity_set_name       =
*        iv_source_name           =
*        it_key_tab               =
*        it_navigation_path       =
*        io_expand                =
*        io_tech_request_context  =
*      IMPORTING
*        er_entity                =
*        es_response_context      =
*        et_expanded_clauses      =
*        et_expanded_tech_clauses =
*    ).
  ENDMETHOD.

  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.
    TYPES: ls TYPE zcl_zgw100_87_student_mpc=>ts_suptext.
    DATA: wa TYPE ls.
    DATA(comp_name) = |AGENCIES|.
    DATA(lv_entity_name) = io_tech_request_context->get_entity_type_name( ).
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = wa
    ).
*    CATCH /iwbep/cx_mgw_tech_exception.
*    DATA(res) = io_expand->compare_to_tech_names( comp_name ).
*    DATA(res1) = io_expand->gcs_compare_result-match_equals.
*    DATA(ls) = VALUE ls( countryid = res1  ).
    me->copy_data_to_ref(
      EXPORTING
        is_data = wa
      CHANGING
        cr_data = er_deep_entity
    ).

  ENDMETHOD.

  METHOD /iwbep/if_mgw_appl_srv_runtime~get_stream.
    DATA: lv_entity_name TYPE /iwbep/mgw_tech_name,
          ls_agency      TYPE zcl_zgw100_87_student_mpc=>ts_agency,
          ls_stream      TYPE ty_s_media_resource.

    lv_entity_name = io_tech_request_context->get_entity_type_name( ).
    CASE lv_entity_name.
      WHEN zcl_zgw100_87_student_mpc=>gc_agency.
*          get agency
        me->agencyset_get_entity(
          EXPORTING
            iv_entity_name          = iv_entity_name
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            io_tech_request_context = io_tech_request_context
            it_navigation_path      = it_navigation_path
          IMPORTING
            er_entity               = ls_agency
            es_response_context     = es_response_context
        ).
*            Get media Stream
        IF ls_agency-web_address IS NOT INITIAL.
          cl_mime_repository_api=>if_mr_api~get_api( )->get(
            EXPORTING
              i_url                  = ls_agency-web_address
            IMPORTING
              e_content              = ls_stream-value
              e_mime_type            = ls_stream-mime_type
            EXCEPTIONS
              parameter_missing      = 1
              error_occured          = 2
              not_found              = 3
              permission_failure     = 4
              OTHERS                 = 5
          ).

          me->copy_data_to_ref(
            EXPORTING
              is_data = ls_stream
            CHANGING
              cr_data = er_stream
          ).

        ENDIF.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
