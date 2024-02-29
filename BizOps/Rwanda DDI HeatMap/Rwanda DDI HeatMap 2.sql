Use RosterDataWarehouse;

Select DistrictName, SiteName, Concat(DistrictName, SiteName) as UniqueID, Count(GlobalId) as TotalClients

from v_ClientSalesBizOps

where CountryName = 'Rwanda'
and OperationalYear = 2022
and TotalCredit >0

Group By DistrictName, SiteName
Order by DistrictName, SiteName