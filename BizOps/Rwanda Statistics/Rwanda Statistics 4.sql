select 
 DimDistrictID, DistrictName, GlobalClientID, min(CreditCycleName) as FirstSeason
from 
	v_ClientBundles 
where 
	DimCountryID = 2  and BundleStatus = 'Delivered'  and DroppedClient = 0 and GlobalClientID is not null
Group By
	DimDistrictID, DistrictName, GlobalClientID
order by
	GlobalClientID
