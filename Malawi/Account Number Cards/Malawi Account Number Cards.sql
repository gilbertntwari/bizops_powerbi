select *
from v_ClientSalesBizOps

where 

CountryName  = 'Malawi'
and DistrictName = @District
and Season = @Season
and SiteName = @Site
and GroupName = @Group