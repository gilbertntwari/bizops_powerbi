Use RosterDataWarehouse;

Select 
	DistrictName
	, SiteName
	, Concat(DistrictName, SiteName) as UniqueID
	, Sum(Case When TotalRepaid = 0 then 1 else 0 end) as ZeroRepaid

from v_ClientSalesBizOps

where CountryName = 'Rwanda'
	and OperationalYear = 2022
	and TotalCredit > 0
	and TotalRepaid = 0

Group By DistrictName, SiteName