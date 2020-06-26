class ZCL_ZGW100_87_REFERENC_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
   TS_XDMOXI_AIRPORTTYPE type /DMO/I_AIRPORT .
  types:
   TT_XDMOXI_AIRPORTTYPE type standard table of TS_XDMOXI_AIRPORTTYPE .
  types:
    begin of TS_ZI87_GW100_CONNECTIONTYPE.
      include type ZI87_GW100_CONNECTION.
  types:
      T_AIRLINEID type /DMO/I_CARRIER-NAME,
    end of TS_ZI87_GW100_CONNECTIONTYPE .
  types:
   TT_ZI87_GW100_CONNECTIONTYPE type standard table of TS_ZI87_GW100_CONNECTIONTYPE .
  types:
    begin of TS_ZI87_GW100_FLIGHTSTYPE.
      include type ZI87_GW100_FLIGHTS.
  types:
      T_AIRLINEID type /DMO/I_CARRIER-NAME,
    end of TS_ZI87_GW100_FLIGHTSTYPE .
  types:
   TT_ZI87_GW100_FLIGHTSTYPE type standard table of TS_ZI87_GW100_FLIGHTSTYPE .

  constants GC_XDMOXI_AIRPORTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xDMOxI_AirportType' ##NO_TEXT.
  constants GC_ZI87_GW100_CONNECTIONTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'zI87_gw100_connectionType' ##NO_TEXT.
  constants GC_ZI87_GW100_FLIGHTSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'zI87_gw100_FLIGHTSType' ##NO_TEXT.

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS ZCL_ZGW100_87_REFERENC_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'ZGW100_87_REFERENCES_SRV' ).

define_rds_4( ).
get_last_modified_rds_4( ).
  endmethod.


  method DEFINE_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
    TRY.
        if_sadl_gw_model_exposure_data~get_model_exposure( )->expose( model )->expose_vocabulary( vocab_anno_model ).
      CATCH cx_sadl_exposure_error INTO DATA(lx_sadl_exposure_error).
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_med_exception
          EXPORTING
            previous = lx_sadl_exposure_error.
    ENDTRY.
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20200512182632'.                  "#EC NOTEXT
 DATA: lv_rds_last_modified TYPE timestamp .
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
 lv_rds_last_modified =  GET_LAST_MODIFIED_RDS_4( ).
 IF rv_last_modified LT lv_rds_last_modified.
 rv_last_modified  = lv_rds_last_modified .
 ENDIF .
  endmethod.


  method GET_LAST_MODIFIED_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
*    @@TYPE_SWITCH:
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20200512172632'.
    TRY.
        rv_last_modified_rds = CAST cl_sadl_gw_model_exposure( if_sadl_gw_model_exposure_data~get_model_exposure( ) )->get_last_modified( ).
      CATCH cx_root ##CATCH_ALL.
        rv_last_modified_rds = co_gen_date_time.
    ENDTRY.
    IF rv_last_modified_rds < co_gen_date_time.
      rv_last_modified_rds = co_gen_date_time.
    ENDIF.
  endmethod.


  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20200512172632'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="/DMO/I_AIRPORT" binding="/DMO/I_AIRPORT" />|  &
               | <sadl:dataSource type="CDS" name="ZI87_GW100_CONNECTION" binding="ZI87_GW100_CONNECTION" />|  &
               | <sadl:dataSource type="CDS" name="ZI87_GW100_FLIGHTS" binding="ZI87_GW100_FLIGHTS" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xDMOxI_Airport" dataSource="/DMO/I_AIRPORT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="zI87_gw100_connection" dataSource="ZI87_GW100_CONNECTION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TOARTICLES" binding="ARTICLES" target="zI87_gw100_FLIGHTS" cardinality="oneToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="zI87_gw100_FLIGHTS" dataSource="ZI87_GW100_FLIGHTS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( 'ZGW100_87_REFERENCES' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.
ENDCLASS.
