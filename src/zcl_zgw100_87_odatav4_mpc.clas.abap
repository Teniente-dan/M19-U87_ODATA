CLASS zcl_zgw100_87_odatav4_mpc DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_model_prov
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS /iwbep/if_v4_mp_basic~define REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS define_article
      IMPORTING
        io_model TYPE REF TO /iwbep/if_v4_med_model
      EXCEPTIONS
        /iwbep/cx_gateway.
ENDCLASS.



CLASS zcl_zgw100_87_odatav4_mpc IMPLEMENTATION.
  METHOD define_article.
    DATA: ls_referenced_cds_view  TYPE z87_c_items,
          lt_primitive_properties TYPE /iwbep/if_v4_med_element=>ty_t_med_prim_property,
          lo_primitive_property   LIKE LINE OF lt_primitive_properties,
          lo_entity_type          TYPE REF TO /iwbep/if_v4_med_entity_type,
          lo_entity_set           TYPE REF TO /iwbep/if_v4_med_entity_set,
          lo_nav_prop             TYPE REF TO /iwbep/if_v4_med_nav_prop.

*    Create entity type
    lo_entity_type = io_model->create_entity_type_by_struct(
                       iv_entity_type_name          = 'Z87_C_ITEMS'
                       is_structure                 = ls_referenced_cds_view
                       iv_gen_prim_props            = abap_true
                       iv_add_conv_to_prim_props    = abap_true
                       iv_add_f4_help_to_prim_props = abap_true
                     ).
*    Set external EDM name for entity type
    lo_entity_type->set_edm_name( iv_edm_name = 'Article' ).

*    Rename external EDM names of properties to CamelCase notation
    lo_entity_type->get_primitive_properties(
      IMPORTING
        et_property = lt_primitive_properties
    ).
    LOOP AT lt_primitive_properties INTO lo_primitive_property.
      lo_primitive_property->set_edm_name( to_mixed( val = lo_primitive_property->get_internal_name(  ) ) ).
    ENDLOOP.

*    Set key field
    lo_entity_type->get_primitive_property( 'SUPPLIERUUID' )->set_is_key(  ).
*    Set unit measures                      GROSS_AMOUNT
    lo_entity_type->get_primitive_property( 'GROSS_AMOUNT' )->set_currency_code_property( 'CURRENCY_CODE' ).
*    lo_entity_type->get_primitive_property( '' )->set_unit_code_property( '' ).
*    lo_entity_type->get_primitive_property( '' )->set_unit_code_property( '' ).
*    lo_entity_type->get_primitive_property( '' )->set_unit_code_property( '' ).

    lo_entity_type->create_entity_set( 'Z87_C_ITEMS' )->set_edm_name( 'ArticleSet' ).

  ENDMETHOD.

  METHOD /iwbep/if_v4_mp_basic~define.
    me->define_article( io_model ).
  ENDMETHOD.

ENDCLASS.
