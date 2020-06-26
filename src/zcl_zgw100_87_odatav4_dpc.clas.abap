CLASS zcl_zgw100_87_odatav4_dpc DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_data_provider
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS /iwbep/if_v4_dp_basic~read_entity_list REDEFINITION.
    METHODS /iwbep/if_v4_dp_basic~read_entity REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS read_list_article
      IMPORTING
        io_request  TYPE REF TO /iwbep/if_v4_requ_basic_list
        io_response TYPE REF TO /iwbep/if_v4_resp_basic_list
      EXCEPTIONS
        /iwbep/cx_gateway
      .
    METHODS read_entity_article
      IMPORTING
        io_request  TYPE REF TO /iwbep/if_v4_requ_basic_read
        io_response TYPE REF TO /iwbep/if_v4_resp_basic_read
      EXCEPTIONS
        /iwbep/cx_gateway.
ENDCLASS.



CLASS zcl_zgw100_87_odatav4_dpc IMPLEMENTATION.
  METHOD read_list_article.
*    entity type specific data types
    DATA: lt_article TYPE TABLE OF z87_c_items.
*    generic data types
    DATA: ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list,
          ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

*    get the request options the application should/must handle
    io_request->get_todos(
      IMPORTING
        es_todo_list = ls_todo_list
    ).
*     Return business data if requested
    IF ls_todo_list-return-busi_data = abap_true.
      SELECT * FROM z87_c_items INTO CORRESPONDING FIELDS OF TABLE @lt_article.
      io_response->set_busi_data( it_busi_data = lt_article ).
    ENDIF.

*    Report list of request options handled by application
    io_response->set_is_done( is_todo_list = ls_done_list ).


  ENDMETHOD.

  METHOD /iwbep/if_v4_dp_basic~read_entity_list.
    DATA: lv_entity_set_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.
*    Delegate data selection
    io_request->get_entity_set(
      IMPORTING
        ev_entity_set_name = lv_entity_set_name
    ).
    CASE lv_entity_set_name.
      WHEN 'Z87_C_ITEMS'.
        read_list_article(
          EXPORTING
            io_request        = io_request
            io_response       = io_response
        ).
      WHEN OTHERS.
        super->/iwbep/if_v4_dp_basic~read_entity_list(
          EXPORTING
            io_request  = io_request
            io_response = io_response
        ).
    ENDCASE.
  ENDMETHOD.

  METHOD read_entity_article.
*    entity type specific data types
    DATA: ls_article     TYPE z87_c_items,
          ls_key_article TYPE z87_c_items.
*    generic data types
    DATA: ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list,
          ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

*    get the request options the application should/must handle
    io_request->get_todos(
      IMPORTING
        es_todo_list = ls_todo_list
    ).
*    Read the key data
    io_request->get_key_data(
      IMPORTING
        es_key_data = ls_key_article
    ).
    ls_done_list-key_data = abap_true.
*     Return business data if requested
    SELECT SINGLE * FROM z87_c_items INTO CORRESPONDING FIELDS OF @ls_article
    WHERE supplieruuid = @ls_key_article-supplieruuid.

    io_response->set_busi_data( is_busi_data = ls_article ).

*    Report list of request options handled by application
    io_response->set_is_done( is_todo_list = ls_done_list ).
  ENDMETHOD.

  METHOD /iwbep/if_v4_dp_basic~read_entity.
    DATA: lv_entity_set_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.
*    Delegate data selection
    io_request->get_entity_set(
      IMPORTING
        ev_entity_set_name = lv_entity_set_name
    ).
    CASE lv_entity_set_name.
      WHEN 'Z87_C_ITEMS'.
        read_entity_article(
          EXPORTING
            io_request        = io_request
            io_response       = io_response
        ).
      WHEN OTHERS.
        super->/iwbep/if_v4_dp_basic~read_entity(
          EXPORTING
            io_request  = io_request
            io_response = io_response
        ).
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
