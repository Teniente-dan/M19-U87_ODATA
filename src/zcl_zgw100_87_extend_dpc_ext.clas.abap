CLASS zcl_zgw100_87_extend_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zgw100_87_extend_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS purchaseorders_get_entity REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zgw100_87_extend_dpc_ext IMPLEMENTATION.
  METHOD purchaseorders_get_entity.
    DATA: BEGIN OF ls_po_product_weight,
            purchaseorder     TYPE sepm_i_purchaseorderitem_e-purchaseorder,
            purchaseorderitem TYPE sepm_i_purchaseorderitem_e-purchaseorderitem,
            product           TYPE sepm_i_purchaseorderitem_e-product,
            quantity          TYPE sepm_i_purchaseorderitem_e-quantity,
            weight            TYPE sepm_i_product_e-weight,
            weightunit        TYPE sepm_i_product_e-weightunit,
          END OF ls_po_product_weight,
          lt_po_product_weights
            LIKE SORTED TABLE OF ls_po_product_weight
            WITH UNIQUE KEY purchaseorder purchaseorderitem,
          lv_weight_total
          TYPE sepm_ref_apps_po_apv_po-zz_wgt_total  .
    CONSTANTS: lcv_weight_unit TYPE snwd_dim_unit VALUE 'KG'.

    super->purchaseorders_get_entity(
        EXPORTING
            iv_entity_name          = iv_entity_name
            iv_entity_set_name      = iv_entity_set_name
            iv_source_name          = iv_source_name
            it_key_tab              = it_key_tab
            it_navigation_path      = it_navigation_path
            io_tech_request_context = io_tech_request_context
        IMPORTING
            er_entity               = er_entity
            es_response_context     = es_response_context ).
* Fill the fields for weight and weight unit
    SELECT poi~purchaseorder, poi~purchaseorderitem, poi~product,
           poi~quantity, weight, pd~weightunit
    INTO CORRESPONDING FIELDS OF TABLE @lt_po_product_weights
    FROM sepm_i_purchaseorderitem_e AS poi
    INNER JOIN sepm_i_product_e AS pd
    ON poi~product = pd~product
    WHERE poi~purchaseorder = @er_entity-po_id.

    CLEAR lv_weight_total.
    LOOP AT lt_po_product_weights INTO ls_po_product_weight.
      " Convert weight to one unique weight unit
      IF ls_po_product_weight-weightunit <> lcv_weight_unit.
        CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
          EXPORTING
            input                = ls_po_product_weight-weight
            unit_in              = ls_po_product_weight-weightunit
            unit_out             = lcv_weight_unit
          IMPORTING
            output               = ls_po_product_weight-weight
          EXCEPTIONS
            conversion_not_found = 1
            division_by_zero     = 2
            input_invalid        = 3
            output_invalid       = 4
            overflow             = 5
            type_invalid         = 6
            units_missing        = 7
            unit_in_not_found    = 8
            unit_out_not_found   = 9
            OTHERS               = 10.

        IF sy-subrc <> 0.
          " Message Container
          mo_context->get_message_container( )->add_message_text_only(
          EXPORTING
          iv_msg_type = /iwbep/if_message_container=>gcs_message_type-error
          iv_msg_text = 'Conversion of weight failed'(con)
          ).
          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              textid            = /iwbep/cx_mgw_busi_exception=>business_error
              message_container = mo_context->get_message_container( ).
        ENDIF.
      ENDIF.
      lv_weight_total = lv_weight_total +
                          ls_po_product_weight-weight *
                          ls_po_product_weight-quantity.
    ENDLOOP.
    er_entity-zz_wgt_total = lv_weight_total.
    er_entity-zz_wgt_unit = lcv_weight_unit.

  ENDMETHOD.

ENDCLASS.
