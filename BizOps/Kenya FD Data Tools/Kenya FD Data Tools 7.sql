select Distinct CountryName,RegionName,DistrictName,SectorName as PodName,SiteName,
concat (DistrictName,Sitename) as UniqueId,
sum (CreditLocal) as SiteCredit


from v_clientsales
where CountryName='Kenya' and OperationalYear=2021 and DistrictName <> 'OAF duka' and DistrictName<> 'KENYA STAFF'

GROUP BY CountryName,RegionName,DistrictName,SectorName,SiteName