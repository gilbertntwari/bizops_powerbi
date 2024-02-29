select *
from v_ClientSalesBizOps

where 

CountryName  = 'Malawi'
and DistrictName = @District
and Season = @Season