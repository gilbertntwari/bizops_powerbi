Select 
RegionName, 
	DistrictName, 
	SiteName,
        GroupName,
	Count(DimClientID) AS TotalClient, 
	count(Case when PercentRepaid=1 then 1 end) as PaidClient,
	sum(TotalCredit) as TotalCredit,
	sum(TotalRepaid) as TotalRepaid,
	sum(TotalRemaining) as TotalRemaining
from v_ClientSalesBizOps
where CountryName = 'Rwanda'
and Season = '2021'
Group by RegionName, DistrictName, SiteName,GroupName