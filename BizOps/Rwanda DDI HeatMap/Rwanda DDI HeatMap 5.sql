Use RosterDataWarehouse;

Select
	DistrictName
	, SiteName
	, Concat(DistrictName, SiteName) as UniqueID
	, Sum(Case when Amount > 0 then 1 else 0 end) as Adjustments

from v_RepaymentBasic

where CountryName = 'Rwanda'
	and OperationalYear = 2022
	and RepaymentTypeName <> 'MobileMoney'


Group By DistrictName, SiteName
Order by DistrictName, SiteName
