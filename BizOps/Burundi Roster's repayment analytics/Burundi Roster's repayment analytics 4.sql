Select TOP(1000000000) Season, 
DistrictName, 
SiteName, 
Count(GlobalId) as TotalClients, 
Sum(TotalCredit) as TotalCredit, 
Sum(TotalRepaid) as TotalRepaid,sum(totalrepaid_includingoverpayments) as [Repaid Including Overpayment], 
Sum(Case when isGroupLeader = 1 then 1 else 0 end) as GLs

from v_ClientSalesBizOps

where CountryName = 'Burundi'
and Season <> 'SEASON_DO_NOT_USE_FOMM_TRIAL'and
Season = '2023A'
Group by Season, DistrictName, SiteName
order by Season asc