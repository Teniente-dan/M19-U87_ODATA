@AbapCatalog.sqlViewName: 'Z87CSUPPLIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'oData from cds'

@OData.publish: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view Z87_C_Supplier
  as select from SEPM_I_BusinessPartner

  association [0..*] to Z87_C_Items as _Articles on SEPM_I_BusinessPartner.BusinessPartnerUUID = _Articles.SupplierUUID
{
      //SEPM_I_BusinessPartner
  key BusinessPartnerUUID,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      BusinessPartner,
      BusinessPartnerRole,
      Currency,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      CompanyName,
      LegalForm,
      EmailAddress,
      FaxNumber,
      PhoneNumber,
      URL,
      /* Associations */
      //SEPM_I_BusinessPartner
      _Articles
}
