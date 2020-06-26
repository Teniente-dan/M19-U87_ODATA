class ZCL_ZGW100_87_EXTEND_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
      FUNCTIONIMPORTRESULT type SEPM_REF_APPS_PO_APV_FI_RESULT .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
    begin of TS_APPROVEPURCHASEORDER,
        PO_ID type C length 10,
        NOTE type C length 255,
    end of TS_APPROVEPURCHASEORDER .
  types:
    begin of TS_REJECTPURCHASEORDER,
        PO_ID type C length 10,
        NOTE type C length 255,
    end of TS_REJECTPURCHASEORDER .
  types:
     TS_PURCHASEORDER type SEPM_REF_APPS_PO_APV_PO .
  types:
TT_PURCHASEORDER type standard table of TS_PURCHASEORDER .
  types:
     TS_PURCHASEORDERITEM type SEPM_REF_APPS_PO_APV_POITEM .
  types:
TT_PURCHASEORDERITEM type standard table of TS_PURCHASEORDERITEM .
  types:
     TS_SUPPLIER type SEPM_REF_APPS_PO_APV_SUPPLIER .
  types:
TT_SUPPLIER type standard table of TS_SUPPLIER .

  constants GC_FUNCTIONIMPORTRESULT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'FunctionImportResult' ##NO_TEXT.
  constants GC_PURCHASEORDER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'PurchaseOrder' ##NO_TEXT.
  constants GC_PURCHASEORDERITEM type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'PurchaseOrderItem' ##NO_TEXT.
  constants GC_SUPPLIER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Supplier' ##NO_TEXT.

  methods GET_EXTENDED_MODEL
  final
    exporting
      !EV_EXTENDED_SERVICE type /IWBEP/MED_GRP_TECHNICAL_NAME
      !EV_EXT_SERVICE_VERSION type /IWBEP/MED_GRP_VERSION
      !EV_EXTENDED_MODEL type /IWBEP/MED_MDL_TECHNICAL_NAME
      !EV_EXT_MODEL_VERSION type /IWBEP/MED_MDL_VERSION
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  constants GC_INCL_NAME type STRING value 'ZCL_ZGW100_87_EXTEND_MPC======CP' ##NO_TEXT.

  methods CREATE_NEW_ARTIFACTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZGW100_87_EXTEND_MPC IMPLEMENTATION.


  method CREATE_NEW_ARTIFACTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
  lo_entity_type    TYPE REF TO /iwbep/if_mgw_odata_entity_typ,                      "#EC NEEDED
  lo_complex_type   TYPE REF TO /iwbep/if_mgw_odata_cmplx_type,                      "#EC NEEDED
  lo_property       TYPE REF TO /iwbep/if_mgw_odata_property,                        "#EC NEEDED
  lo_association    TYPE REF TO /iwbep/if_mgw_odata_assoc,                           "#EC NEEDED
  lo_assoc_set      TYPE REF TO /iwbep/if_mgw_odata_assoc_set,                       "#EC NEEDED
  lo_ref_constraint TYPE REF TO /iwbep/if_mgw_odata_ref_constr,                      "#EC NEEDED
  lo_nav_property   TYPE REF TO /iwbep/if_mgw_odata_nav_prop,                        "#EC NEEDED
  lo_action         TYPE REF TO /iwbep/if_mgw_odata_action,                          "#EC NEEDED
  lo_parameter      TYPE REF TO /iwbep/if_mgw_odata_property,                        "#EC NEEDED
  lo_entity_set     TYPE REF TO /iwbep/if_mgw_odata_entity_set.                      "#EC NEEDED


lo_entity_type = model->get_entity_type( iv_entity_name = 'PurchaseOrder' ).    "#EC NOTEXT
lo_property = lo_entity_type->create_property( iv_property_name = 'ZzWgtTotal' iv_abap_fieldname = 'ZZ_WGT_TOTAL' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '002' iv_text_element_container = gc_incl_name ).       "#EC NOTEXT
lo_property->set_type_edm_decimal( ).
lo_property->set_precison( iv_precision = 3 ).
lo_property->set_maxlength( iv_max_length = 15 ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).

lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_entity_type = model->get_entity_type( iv_entity_name = 'PurchaseOrder' ).    "#EC NOTEXT
lo_property = lo_entity_type->create_property( iv_property_name = 'ZzWgtUnit' iv_abap_fieldname = 'ZZ_WGT_UNIT' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '003' iv_text_element_container = gc_incl_name ).       "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 3 ).
lo_property->set_conversion_exit( 'CUNIT' ).      "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).

lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_entity_type->bind_structure( iv_structure_name = 'SEPM_REF_APPS_PO_APV_PO' iv_bind_conversions = 'X' ). "#EC NOTEXT
  endmethod.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
  lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ, "#EC NEEDED
  lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type, "#EC NEEDED
  lo_property       type ref to /iwbep/if_mgw_odata_property, "#EC NEEDED
  lo_association    type ref to /iwbep/if_mgw_odata_assoc,  "#EC NEEDED
  lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set, "#EC NEEDED
  lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr, "#EC NEEDED
  lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop, "#EC NEEDED
  lo_action         type ref to /iwbep/if_mgw_odata_action, "#EC NEEDED
  lo_parameter      type ref to /iwbep/if_mgw_odata_property, "#EC NEEDED
  lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set, "#EC NEEDED
  lo_complex_prop   type ref to /iwbep/if_mgw_odata_cmplx_prop. "#EC NEEDED

* Extend the model
model->extend_model( iv_model_name = 'EPM_REF_APPS_PO_APV_MDL' iv_model_version = '0001' ). "#EC NOTEXT

model->set_schema_namespace( 'EPM_REF_APPS_PO_APV_SRV' ).
* New artifacts have been created in the service builder after the redefinition of service
create_new_artifacts( ).
  endmethod.


  method GET_EXTENDED_MODEL.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*



ev_extended_service  = 'EPM_REF_APPS_PO_APV_SRV'.                "#EC NOTEXT
ev_ext_service_version = '0001'.               "#EC NOTEXT
ev_extended_model    = 'EPM_REF_APPS_PO_APV_MDL'.                    "#EC NOTEXT
ev_ext_model_version = '0001'.                   "#EC NOTEXT
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  constants: lc_gen_date_time type timestamp value '20200507183345'. "#EC NOTEXT
rv_last_modified = super->get_last_modified( ).
IF rv_last_modified LT lc_gen_date_time.
  rv_last_modified = lc_gen_date_time.
ENDIF.
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
  lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,           "#EC NEEDED
  lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,           "#EC NEEDED
  lo_property       type ref to /iwbep/if_mgw_odata_property,             "#EC NEEDED
  lo_association    type ref to /iwbep/if_mgw_odata_assoc,                "#EC NEEDED
  lo_assoc_set      type ref to /iwbep/if_mgw_odata_assoc_set,            "#EC NEEDED
  lo_ref_constraint type ref to /iwbep/if_mgw_odata_ref_constr,           "#EC NEEDED
  lo_nav_property   type ref to /iwbep/if_mgw_odata_nav_prop,             "#EC NEEDED
  lo_action         type ref to /iwbep/if_mgw_odata_action,               "#EC NEEDED
  lo_parameter      type ref to /iwbep/if_mgw_odata_property,             "#EC NEEDED
  lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.           "#EC NEEDED


DATA:
     ls_text_element TYPE ts_text_element.                   "#EC NEEDED
clear ls_text_element.


clear ls_text_element.
ls_text_element-artifact_name          = 'ZzWgtTotal'.      "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'PurchaseOrder'.     "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                             "#EC NOTEXT
ls_text_element-text_symbol            = '002'.         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'ZzWgtUnit'.      "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'PurchaseOrder'.     "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                             "#EC NOTEXT
ls_text_element-text_symbol            = '003'.         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
  endmethod.
ENDCLASS.
