select Distinct RegionName,DistrictName,SectorName as PodName,SiteName
,concat (DistrictName,Sitename) as UniqueId,
 sum (CreditLocal) as SiteCredit
from v_clientsales
where CountryName='Kenya'and  SeasonName = '2022, Long Rain' and DistrictName <> 'OAF duka' and DistrictName<> 'KENYA STAFF'

GROUP BY RegionName,DistrictName,SectorName,SiteName