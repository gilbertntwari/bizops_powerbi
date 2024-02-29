Use RosterDataWarehouse;

Select 
CountryName
, OperationalYear
, BundleName
, Count(BundleQuantity) as Quantity
from v_ClientBundles
where OperationalYear in (2016, 2017, 2018, 2019, 2020)
and BundleName like '%Cookstove%'

Group by CountryName, OperationalYear, BundleName

order by CountryName, OperationalYear asc