select
 c.OperationalYear, CreditCycleName, DimDistrictID, LocationName as DistrictName, max(SiteName) as SiteName, Max(e.RegionName) As RegionName,
 Count(distinct DimClientId) as ClientCount, Sum(InputCredit) As TotalCredit, 
 DATEFROMPARTS(c.OperationalYear, 1, 1) As OperationalYearDate,
 DENSE_RANK() OVER ( ORDER BY CreditCycleName) As SeasonNumber
into 
  #tempClientDeliveries
from 
	ClientOrdersDetail a inner join OAF_SHARED_DIMENSIONS.dbo.DimInputs b on a.DimInputID = b.InputId
	Inner join OAF_SHARED_DIMENSIONS.dbo.DimSeasons c on a.DimSeasonID = c.SeasonID and a.DimCountryID = c.CountryId
	inner join OAF_SHARED_DIMENSIONS.dbo.DimCreditCycles d on a.DimCreditCycleId = d.CreditCycleID
	inner join OAF_SHARED_DIMENSIONS.dbo.DimLocations e on a.DimDistrictID = e.LocationID
	inner join OAF_SHARED_DIMENSIONS.dbo.DimSite f on a.DimSiteID = f.SiteID
where 
	DimCountryID = 2 and c.OperationalYear > 2017 and BundleStatus = 'Delivered'  
Group By
	c.OperationalYear, CreditCycleName, DimDistrictID, LocationName


select * from #tempClientDeliveries order by SeasonNumber