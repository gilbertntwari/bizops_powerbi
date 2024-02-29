Use RosterDataWarehouse;

Select 
	DistrictName
	, SiteName
	, Concat(DistrictName, SiteName) as UniqueID
	, Sum(Case When TotalCredit < 3000 then 1 else 0 end) as LowCreditClients

from v_ClientSalesBizOps

	where CountryName = 'Rwanda'
	and OperationalYear = 2022
	and TotalCredit > 0
	and TotalCredit <= 3000

Group By DistrictName, SiteName