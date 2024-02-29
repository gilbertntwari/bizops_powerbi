Use RosterDataWarehouse;
Select 
RegionName, 
	DistrictName, 
	SiteName,
	Season,
	NewMember,
	Count(DimClientID) AS ClientsEnrolled, 
	Count(DimGroupID) as #Group,
	count(Case when TotalRepaid >10000 then 1 end) as Starters,
	count(Case when TotalRepaid >= 50000 then 1 end) as Qualifiers,
	Sum(TotalCredit) as TotalCredit,
	Sum(TotalCredit)/ Nullif (count(DimClientID),0) as AvrgTRXSizex

from v_ClientSalesBizOps
where CountryName = 'Tanzania'
and Season in('2022, Msimu Masika')
Group by RegionName, DistrictName, SiteName,Season,NewMember
