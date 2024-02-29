Use RosterDataWarehouse;

select 
	CountryName
	, SeasonName
	, DistrictName
	, SiteName
	, CONCAT(CountryName,SeasonName,DistrictName, SiteName) as UniqueName
	, Case When TotalRepaid_IncludingOverpayments-CreditLocal >0 then TotalRepaid_IncludingOverpayments-CreditLocal else 0 end as Overpayments
from v_ClientSales

where CountryName <> 'Kenya'
	and OperationalYear in (2015, 2016, 2017, 2018, 2019, 2020)
	and SeasonName Not in( '2019, Short Rain', '2020, Short Rain', '2015, Short Rain', '2018, Short Rain', '2016, Short Rain', '2017, Short Rain')
	and TotalRepaid_IncludingOverpayments-CreditLocal > 0
order by CountryName

