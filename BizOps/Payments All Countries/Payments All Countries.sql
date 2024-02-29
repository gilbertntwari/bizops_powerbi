select 
	CountryName
	, SeasonName
	, RegionName
	, DistrictName
	, SectorName
	, SiteName
	, GroupName
	, FirstName
	, LastName
	, OAFID
	, AccountNumber
	, Amount
	, ReceiptID
	, CreatedDate
	, RepaymentTypeName

from v_RepaymentConfidential
	Where CountryName <> 'Kenya'