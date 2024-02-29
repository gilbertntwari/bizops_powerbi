Use RosterDataWarehouse;
select 
	SeasonName
	, CountryName
	, DistrictName
	, SiteName
	, GroupName
	, FirstName
	, GlobalClientID
	, LastName
	, AccountNumber
	, BundleName
	, InputName
	, InputCredit
	, InputQuantity
	, CreditCycleName
from v_ClientInputs
where DistrictName <> 'OAF Duka'
	and SiteName <> 'Duka'
	and InputQuantity > 0
	and InputCredit > 0
	and InputStatus = 'Un-delivered'
	and OperationalYear > 2018