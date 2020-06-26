@AbapCatalog.sqlViewName: 'Z87CITEMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'cds to serve oData detail on C_Supplier'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view Z87_C_Items
  as select from snwd_po
{
       //snwd_po
  key  partner_guid as SupplierUUID,
  key  po_id,
       node_key     as PurchaseOrderUUID,
       created_by,
       created_at,
       changed_by,
       changed_at,
       note_guid,

       currency_code,
       gross_amount,
       net_amount,
       tax_amount,
       lifecycle_status,
       approval_status,
       confirm_status,
       ordering_status,
       invoicing_status,
       overall_status
}
