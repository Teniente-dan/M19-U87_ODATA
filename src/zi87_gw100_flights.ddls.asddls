@AbapCatalog.sqlViewName: 'ZI87_FLIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS FLIGHTS'
define view zI87_gw100_FLIGHTS
  as select from /DMO/I_Flight_R
  association [1] to zI87_gw100_connection as _Conn on  $projection.AirlineID    = _Conn.AirlineID
                                                    and $projection.ConnectionID = _Conn.ConnectionID
{
      ///DMO/I_Flight_R
  key AirlineID,
  key ConnectionID,
  key FlightDate,
      Price,
      CurrencyCode,
      PlaneType,
      MaximumSeats,
      OccupiedSeats,
      /* Associations */
      ///DMO/I_Flight_R
      _Airline,
      _Conn as Supplier
}
