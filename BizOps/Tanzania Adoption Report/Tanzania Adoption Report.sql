use RosterDataWarehouse;

SELECT 
	RegionName
	, DistrictName
	, SiteName
	, SiteName
	, GroupName
	,SeasonName
	,LastName
	, FirstName
	, BundleName
	, InputNames
	, BundleQuantity
	, BundleUnit
	, BundleCredit
	, AccountNumber
	, InputCredit
	, InputCreditAdjusted
	, BundleStatus
	, BundleUnit

FROM v_ClientBundles
where CountryName = 'Tanzania'
and SeasonName='2022, Msimu Masika'