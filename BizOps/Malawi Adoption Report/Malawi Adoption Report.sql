use RosterDataWarehouse

	SELECT 
	RegionName
	, DistrictName
	, SiteName
	, GroupName
	, SeasonName
	, LastName
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
		where CountryName = 'Malawi'
		and SeasonName='2022, Long Rain'