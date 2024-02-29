Use RosterDataWarehouse;

Select Season, GlobalID, TotalRemaining, Concat(Season,GlobaLID) as UniqueID
FROM v_ClientSalesBizOps

WHERE CountryName = 'Rwanda'
and OperationalYear = 2019
and TotalRemaining >0