@AbapCatalog.sqlViewName: 'ZI87_CONNECTION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'cds connection'
define view zI87_gw100_connection
  as select from /DMO/I_Connection_R
  association [1..*] to zI87_gw100_FLIGHTS as _Flight on  $projection.AirlineID    = _Flight.AirlineID
                                                      and $projection.ConnectionID = _Flight.ConnectionID
{
      ///DMO/I_Connection_R
      //      @ObjectModel.text.association: ''
  key AirlineID,
  key ConnectionID,
      DepartureAirport as depair,
      DestinationAirport,
      DepartureTime,
      ArrivalTime,
      Distance,
      @EndUserText.label: 'Departure Airport Code'
      @Consumption.valueHelpDefinition: [{  entity: {   name: '/DMO/I_Airport',
                            element:    'AirportID' } }]
      //      @Search.defaultSearchElement: true
      //      @Search.fuzzinessThreshold: 0.7
      DistanceUnit,
      /* Associations */
      ///DMO/I_Connection_R
      _Airline,
      _Flight          as Articles
}
