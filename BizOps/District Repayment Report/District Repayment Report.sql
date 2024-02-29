Select 
CountryName
, Season
, DistrictName
, Concat(CountryName
, Season, DistrictName) as UniqueID
, Sum(TotalCredit) as Credit
from v_ClientSalesBizOps
where OperationalYear > 2020

group by CountryName, Season, DistrictName

ORDER BY CountryName, Season, DistrictName ASC
