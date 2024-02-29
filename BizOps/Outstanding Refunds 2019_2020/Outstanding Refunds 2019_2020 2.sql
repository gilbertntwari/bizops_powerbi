select 
	SeasonName
	, DistrictName
	, SiteName
	, CONCAT(SeasonName,DistrictName, SiteName) as UniqueName
	, Sum(-Amount)
from v_RepaymentBasic
	where CountryName = 'Kenya'
	and OperationalYear in (2019, 2020)
	and RevenueCategoryName = 'Refund'
	and SeasonName <> '2019, Short Rain'
	Group by SeasonName, DistrictName, SiteName
