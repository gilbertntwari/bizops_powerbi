Use RosterDataWarehouse;

select 
	SeasonName
	, DistrictName
	, SiteName
	, CONCAT(SeasonName,DistrictName, SiteName) as UniqueName
	, Case When TotalRepaid_IncludingOverpayments-CreditLocal >0 then TotalRepaid_IncludingOverpayments-CreditLocal else 0 end as Overpayments
from v_ClientSales

	where CountryName = 'Kenya'
	and OperationalYear in (2019, 2020)
	and SeasonName <> '2019, Short Rain'
	and TotalRepaid_IncludingOverpayments-CreditLocal > 0
