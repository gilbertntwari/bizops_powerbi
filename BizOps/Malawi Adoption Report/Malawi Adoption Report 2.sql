Use RosterDataWarehouse;

Select 
RegionName, 
	DistrictName, 
	SiteName,
	Season,
	GroupName,
	Count(DimClientID) AS ClientsEnrolled, 
	count(Case when TotalRepaid >0 then 1 end) as Starters,
	count(Case when TotalRepaid >= 5000 then 1 end) as Qualifiers,
	Sum(TotalCredit) as TotalCredit,
	Sum(TotalCredit)/Nullif (count(DimClientID),0) as AVrTransSize
from v_ClientSalesBizOps
where CountryName = 'Malawi'
and Season ='2022, Long Rain'
Group by RegionName, DistrictName, SiteName,Season,GroupName