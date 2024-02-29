Use RosterDataWarehouse;
Select 
CountryName, 
	Season, 
	DistrictName, 
	SiteName, 
	GroupName, 
	DimGroupID,
	FirstName, 
	LastName, 
	CONCAT(FirstName, LastName) as ClientName,
	CONCAT(Season, DistrictName, SiteName) as UniqueID,
	OAFID,
	TotalCredit,
	CASE WHEN TotalCredit = 0 then 1 else 0 end as ZeroCredit,
	CASE WHEN TotalCredit <= 2500 then 1 else 0 end as MembershipFee,
	CASE WHEN TotalCredit > 110000 and NewMember = 1 then 1 else 0 end as NewClientsExceeding,
	CASE WHEN TotalCredit > 110000 and NewMember = 0 then 1 else 0 end as RetClientsExceeding,
	CASE WHEN TotalCredit <= 5000 then 1 else 0 end as MinCredit

from v_ClientSalesBizOps

Where CountryName = 'Malawi'
and OperationalYear >= 2023
and DistrictName Not In ('Staff Input Access', 'Cooperatives ')

