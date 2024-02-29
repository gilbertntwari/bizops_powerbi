select 
        RegionName,
        DistrictName,
        SectorName,
        SiteName,
        GlobalClientID
from 
	v_clientsales 
where 
	 OperationalYear in (2020) and DimCountryID = 1 and DroppedClient = 0
Group By
	GlobalClientID, RegionName, DistrictName, SectorName, SiteName
