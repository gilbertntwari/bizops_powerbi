select *

from v_ClientSalesBizOps

where CountryName = 'Tanzania'
and Season = @Season
and DistrictName = @District