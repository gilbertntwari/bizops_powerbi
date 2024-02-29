Use RosterDataWarehouse;
select Season
, CountryName
, DistrictName
, RegionName
, SectorName
, SiteName
, CONCAT(Season
, CountryName
, DistrictName
, RegionName
, SectorName
, SiteName) as UniqueID
, Count(DimClientID) AS clients
from v_ClientSalesBizOps
where OperationalYear = 2021
and Season not in ('2021, Short Rain', 'SEASON_DO_NOT_USE_FOMM_TRIAL')

Group by Season, CountryName, DistrictName, RegionName, SectorName, SiteName

order by CountryName