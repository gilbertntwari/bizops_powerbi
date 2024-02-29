Select top 100000000 DistrictName
, InputName
, Count(Distinct AccountNumber) AS Farmers
, Count(InputName) as NumberAdopted
, SUM(InputQuantity) as TotalQuantity

from v_ClientInputs
where CountryName = 'Rwanda'
AND SeasonName = '2023'
and InputQuantity >0
Group by DistrictName, InputName
order by DistrictName, InputName asc