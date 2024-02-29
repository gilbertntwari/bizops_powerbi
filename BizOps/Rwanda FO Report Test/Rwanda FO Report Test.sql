Select DistrictName, 
SiteName, 
	[FO Name],
	Count(AccountNumber) as YearlyClients, 
	Sum(TotalCredit) as Credit, 
	Count(Distinct DimGroupID) AS Groups,
	Sum(TotalRepaid) / Sum(TotalCredit) as [% Repaid],
	Sum(Case when TotalRemaining >=30000 then 1 else 0 end) as Below,
        Sum(Case when PercentRepaid >=.77 then 1 else 0 end) as HP

from v_ClientSalesBizOps
where CountryName = 'Rwanda'
and Season = '2022'
and TotalCredit >0

Group by DistrictName, SiteName, [FO Name]
Order by DistrictName, SiteName, [FO Name]
