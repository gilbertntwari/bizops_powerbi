Select
GlobalId, 
MAX(FirstName) 'First Name',
MAX(LastName) 'Last Name',
Sum(TotalCredit) as TotalCredit, 
Sum(TotalRepaid) as TotalRepaid, 
Sum(Case when isGroupLeader = 1 then 1 else 0 end) as GLs,
ISNULL(Sum(TotalRepaid)/NULLIF(Sum(TotalCredit),0),0)*100 as percentageRepaid

from v_ClientSalesBizOps

where CountryName = 'Burundi'
and Season <> 'SEASON_DO_NOT_USE_FOMM_TRIAL'and
Season = '2023A'
Group by GlobalId