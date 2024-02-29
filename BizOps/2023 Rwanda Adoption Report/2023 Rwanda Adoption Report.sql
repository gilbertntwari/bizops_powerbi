Select top 10000000 Count(Distinct GlobalId) AS Farmers
from v_ClientSalesBizOps
where CountryName = 'Rwanda'
AND Season = '2023'
And TotalCredit >0