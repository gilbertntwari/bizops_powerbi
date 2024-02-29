select distinct CountryName, Season as SeasonName from v_ClientSalesBizOps where OperationalYear >= 2021  
and CountryName in (@Country)
order by SeasonName ASC