class ZCL_ZGW100_87_REDEFINE_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  types:
     TS_ARTICLE type Z87_AGENCY .
  types:
TT_ARTICLE type standard table of TS_ARTICLE .
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

  constants GC_ARTICLE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Article' ##NO_TEXT.

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

  constants GC_INCL_NAME type STRING value 'ZCL_ZGW100_87_REDEFINE_MPC====CP' ##NO_TEXT.

  methods CHANGE_LABELS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods CHANGE_EXTERNAL_NAMES
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
ENDCLASS.



CLASS ZCL_ZGW100_87_REDEFINE_MPC IMPLEMENTATION.


  method CHANGE_EXTERNAL_NAMES.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
  lo_entity_type        TYPE REF TO /iwbep/if_mgw_odata_entity_typ,            "#EC NEEDED
  lo_complex_type       TYPE REF TO /iwbep/if_mgw_odata_cmplx_type,            "#EC NEEDED
  lo_child_complex_type TYPE REF TO /iwbep/if_mgw_odata_cmplx_type,            "#EC NEEDED
  lo_property           TYPE REF TO /iwbep/if_mgw_odata_property,              "#EC NEEDED
  lo_association        TYPE REF TO /iwbep/if_mgw_odata_assoc,                 "#EC NEEDED
  lo_assoc_set          TYPE REF TO /iwbep/if_mgw_odata_assoc_set,             "#EC NEEDED
  lo_ref_constraint     TYPE REF TO /iwbep/if_mgw_odata_ref_constr,            "#EC NEEDED
  lo_nav_property       TYPE REF TO /iwbep/if_mgw_odata_nav_prop,              "#EC NEEDED
  lo_action             TYPE REF TO /iwbep/if_mgw_odata_action,                "#EC NEEDED
  lo_parameter          TYPE REF TO /iwbep/if_mgw_odata_property,              "#EC NEEDED
  lo_entity_set         TYPE REF TO /iwbep/if_mgw_odata_entity_set.            "#EC NEEDED


* Change the external names for the entity types
   lo_entity_type = model->get_entity_type( iv_entity_name = 'Agency' ).            "#EC NOTEXT
   lo_entity_type->set_name( 'Article' ).                       "#EC NOTEXT


* Change the external names for the Entity set
   lo_entity_set = model->get_entity_set( iv_entity_set_name = 'AgencySet' ).           "#EC NOTEXT
   lo_entity_set->set_name( 'ArticleSet' ).                                              "#EC NOTEXT


* Change the external names for the entity types' properties
   lo_entity_type = model->get_entity_type( iv_entity_name = 'Agency' ).      "#EC NOTEXT
   lo_property = lo_entity_type->get_property( iv_property_name = 'AgencyId' ).      "#EC NOTEXT
   lo_property->set_name( 'ArticleId' ).            "#EC NOTEXT
  endmethod.


  method CHANGE_LABELS.
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


* Change the labels for the entity types' properties
   lo_entity_type = model->get_entity_type( iv_entity_name = 'Agency' )."#EC NOTEXT
lo_property = lo_entity_type->get_property( iv_property_name = 'ArticleId' )."#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '001' iv_text_element_container = gc_incl_name )."#EC NOTEXT
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
model->extend_model( iv_model_name = 'ZGW100_87_SEARCHHELP_MDL' iv_model_version = '0001' ). "#EC NOTEXT

model->set_schema_namespace( 'ZGW100_87_SEARCHHELP_SRV' ).


*
* Disable all the entity types that were disabled from reference model
*
* Disable entity type 'SupText'
try.
lo_entity_type = model->get_entity_type( iv_entity_name = 'SupText' ). "#EC NOTEXT
lo_entity_type->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

IF lo_entity_type IS BOUND.
* Disable all the properties for this entity type
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'CountryId' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'BussinessPartnerID' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'LongText' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

* Disable all the navigation properties for this entity type
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'SalesOrders' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'Agencies' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'CountryName' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

endif.

* Disable entity type 'SalesOrder'
try.
lo_entity_type = model->get_entity_type( iv_entity_name = 'SalesOrder' ). "#EC NOTEXT
lo_entity_type->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

IF lo_entity_type IS BOUND.
* Disable all the properties for this entity type
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'SoId' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'Note' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'BuyerId' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'BuyerName' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'CurrencyCode' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'GrossAmount' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'NetAmount' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'TaxAmount' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'LifecycleStatus' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'BillingStatus' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'DeliveryStatus' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

* Disable all the navigation properties for this entity type
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'Items' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'Buyer' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

endif.

* Disable entity type 'SalesOrderItem'
try.
lo_entity_type = model->get_entity_type( iv_entity_name = 'SalesOrderItem' ). "#EC NOTEXT
lo_entity_type->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

IF lo_entity_type IS BOUND.
* Disable all the properties for this entity type
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'SoId' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'SoItemPos' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'ProductId' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'Note' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'CurrencyCode' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'NetAmount' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'TaxAmount' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'DeliveryDate' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'Quantity' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'QuantityUnit' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

* Disable all the navigation properties for this entity type
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'SalesOrder' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

endif.

* Disable entity type 'Country'
try.
lo_entity_type = model->get_entity_type( iv_entity_name = 'Country' ). "#EC NOTEXT
lo_entity_type->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

IF lo_entity_type IS BOUND.
* Disable all the properties for this entity type
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'Land1' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_property = lo_entity_type->get_property( iv_property_name = 'Name' ). "#EC NOTEXT
lo_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

* Disable all the navigation properties for this entity type
try.
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'BussinessPartners' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.

endif.


*Disable selected navigation properties in a entity type
try.
lo_entity_type = model->get_entity_type( iv_entity_name = 'Agency' ). "#EC NOTEXT
lo_nav_property = lo_entity_type->get_navigation_property( iv_name    = 'Country' ). "#EC NOTEXT
lo_nav_property->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.


*
*Disable all the entity sets that were disabled from reference model
*
try.
lo_entity_set = model->get_entity_set( iv_entity_set_name = 'SupTextSet' ). "#EC NOTEXT
IF lo_entity_set IS BOUND.
lo_entity_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_entity_set = model->get_entity_set( iv_entity_set_name = 'SalesOrderSet' ). "#EC NOTEXT
IF lo_entity_set IS BOUND.
lo_entity_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_entity_set = model->get_entity_set( iv_entity_set_name = 'SalesOrderItemSet' ). "#EC NOTEXT
IF lo_entity_set IS BOUND.
lo_entity_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_entity_set = model->get_entity_set( iv_entity_set_name = 'CountrySet' ). "#EC NOTEXT
IF lo_entity_set IS BOUND.
lo_entity_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.


*
*Disable all the associations, association sets that were disabled from reference model
*
try.
lo_association = model->get_association( iv_association_name = 'SupText_Agency' ). "#EC NOTEXT
lo_association->set_disabled( iv_disabled = abap_true ).
lo_ref_constraint = lo_association->get_ref_constraint( ).
lo_ref_constraint->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_association = model->get_association( iv_association_name = 'BussinessPartner_SalesOrders' ). "#EC NOTEXT
lo_association->set_disabled( iv_disabled = abap_true ).
lo_ref_constraint = lo_association->get_ref_constraint( ).
lo_ref_constraint->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_association = model->get_association( iv_association_name = 'SalesOrder_SalesOrderItem' ). "#EC NOTEXT
lo_association->set_disabled( iv_disabled = abap_true ).
lo_ref_constraint = lo_association->get_ref_constraint( ).
lo_ref_constraint->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_association = model->get_association( iv_association_name = 'Country_BussinessPartners' ). "#EC NOTEXT
lo_association->set_disabled( iv_disabled = abap_true ).
lo_ref_constraint = lo_association->get_ref_constraint( ).
lo_ref_constraint->set_disabled( iv_disabled = abap_true ).
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.


try.
lo_assoc_set  = model->get_association_set( iv_assoc_set_name = 'SupText_AgencySet' ). "#EC NOTEXT
IF lo_assoc_set IS BOUND.
lo_assoc_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_assoc_set  = model->get_association_set( iv_assoc_set_name = 'BussinessPartner_SalesOrdersSet' ). "#EC NOTEXT
IF lo_assoc_set IS BOUND.
lo_assoc_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_assoc_set  = model->get_association_set( iv_assoc_set_name = 'SalesOrder_SalesOrderItemSet' ). "#EC NOTEXT
IF lo_assoc_set IS BOUND.
lo_assoc_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
try.
lo_assoc_set  = model->get_association_set( iv_assoc_set_name = 'Country_BussinessPartnersSet' ). "#EC NOTEXT
IF lo_assoc_set IS BOUND.
lo_assoc_set->set_disabled( iv_disabled = abap_true ).
ENDIF.
CATCH /iwbep/cx_mgw_med_exception.
*  No Action was taken as the OData Element is not a part of redefined service
ENDTRY.
* External names of the artifacts have been changed in the service builder after the redefinition of service
change_external_names( ).
* Labels of the artifacts have been changed in the service builder after the redefinition of service
change_labels( ).
  endmethod.


  method GET_EXTENDED_MODEL.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*



ev_extended_service  = 'ZGW100_87_SEARCHHELP_SRV'.                "#EC NOTEXT
ev_ext_service_version = '0001'.               "#EC NOTEXT
ev_extended_model    = 'ZGW100_87_SEARCHHELP_MDL'.                    "#EC NOTEXT
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


  constants: lc_gen_date_time type timestamp value '20200507042239'. "#EC NOTEXT
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
ls_text_element-artifact_name          = 'ArticleId'.      "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Agency'.     "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                             "#EC NOTEXT
ls_text_element-text_symbol            = '001'.         "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
  endmethod.
ENDCLASS.
