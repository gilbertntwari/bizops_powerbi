use RosterDataWarehouse;

select 
Season,
RegionName,
DistrictName,
SiteName,
GroupName,
TotalCredit,
TotalRepaid,
TotalRemaining,
PercentRepaid 
from v_ClientSalesBizOps
where CountryName='Rwanda'
and Season='2021'

