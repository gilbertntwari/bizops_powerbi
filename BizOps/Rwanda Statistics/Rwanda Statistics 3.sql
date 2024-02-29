select 
	OperationalYear, DimDistrictID, DistrictName, DimSiteID, SiteName, DimGroupId,
	DATEFROMPARTS(OperationalYear, 1, 1) As OperationalYearDate, Count(Distinct GlobalClientID) As ClientCount
from
   v_clientSales
where
	DimCountryID = 2 and OperationalYear > 2017 and DroppedClient = 0 and CreditLocal > 0
Group By
  OperationalYear,  DimDistrictID, DistrictName, DimSiteID, SiteName, DimGroupId