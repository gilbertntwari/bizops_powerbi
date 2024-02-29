select
	CountryName
	, SeasonName
	, DistrictName
	, SiteName
	, CONCAT(CountryName,SeasonName,DistrictName, SiteName) as UniqueName
	, -Amount as Refunded
from v_RepaymentBasic
where CountryName = 'Kenya'
and OperationalYear in (2019, 2020, 2021)
and RevenueCategoryName = 'Refund'
and SeasonName Not in( '2019, Short Rain', '2020, Short Rain')
