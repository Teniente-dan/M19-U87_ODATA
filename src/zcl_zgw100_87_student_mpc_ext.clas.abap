CLASS zcl_zgw100_87_student_mpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zgw100_87_student_mpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS define REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zgw100_87_student_mpc_ext IMPLEMENTATION.
  METHOD define.
    DATA: lo_entity_type TYPE REF TO /iwbep/if_mgw_odata_entity_typ,
          lo_property    TYPE REF TO /iwbep/if_mgw_odata_property.

    super->define( ).

*Set media content source and type
    lo_entity_type = model->get_entity_type( iv_entity_name = zcl_zgw100_87_student_mpc=>gc_agency ).
    lo_property = lo_entity_type->get_property( iv_property_name = 'WebAddress' ).
    lo_property->set_as_content_source( ).
    lo_property = lo_entity_type->get_property( iv_property_name = 'Mimetype' ).
    lo_property->set_as_content_type( ).

  ENDMETHOD.

ENDCLASS.
