select *

from v_ClientSalesBizOps

where 
CountryName  = 'Malawi'
and DistrictName = @District
and Season = @Season
and PercentRepaid BETWEEN @LowPercent and @HighPercent
order by Sitename ASC