select 
	CountryId, CountryName, Currency, year(ratedate) as OpYear, avg(rate) as rate
from ExchangeRates fx
join oaf_shared_dimensions.dbo.dimcountry c on c.countrycode = fx.countrycode
where currency = 'USD' and year(ratedate) = year(getdate()) and CountryId <> 9
group by CountryId, CountryName, Currency, year(ratedate)

union all

-- Myanmar Rate Stuck in 2018
select 
	CountryId, CountryName, Currency, year(ratedate) as OpYear, avg(rate) as rate
from ExchangeRates fx
join oaf_shared_dimensions.dbo.dimcountry c on c.countrycode = fx.countrycode
where currency = 'USD' and year(ratedate) = 2018 and CountryId = 9
group by CountryId, CountryName, Currency, year(ratedate)
