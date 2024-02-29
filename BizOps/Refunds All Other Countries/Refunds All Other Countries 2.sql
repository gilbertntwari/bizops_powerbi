select 
CountryName
	, SeasonName
	, DistrictName
	, SiteName
	, CONCAT(CountryName,SeasonName,DistrictName, SiteName) as UniqueName
	, -Amount as Refunded
from v_RepaymentBasic
	where CountryName <> 'Kenya'
	and OperationalYear in (2015, 2016, 2017, 2018, 2019, 2020)
	and RevenueCategoryName = 'Refund'
	and SeasonName Not in( '2019, Short Rain', '2020, Short Rain', '2015, Short Rain', '2018, Short Rain', '2016, Short Rain', '2017, Short Rain')
order by CountryName