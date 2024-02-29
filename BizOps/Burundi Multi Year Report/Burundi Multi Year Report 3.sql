Use RosterDataWarehouse;

Select Season
, GlobalID
, TotalRemaining
, Concat(Season,GlobaLID) as UniqueID

FROM v_ClientSalesBizOps

WHERE CountryName = 'Burundi'
and OperationalYear = 2018
and TotalRemaining >0