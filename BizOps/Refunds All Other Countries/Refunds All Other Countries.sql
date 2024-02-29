Use RosterDataWarehouse;

select 
	CountryName
	, SeasonName
	, DistrictName
	, SiteName
	, GroupName
	, FirstName
	, LastName
	, AccountNumber
	, LastRepaymentDate
	, GlobalClientID
	,Case When TotalRepaid_IncludingOverpayments-CreditLocal >0 then TotalRepaid_IncludingOverpayments-CreditLocal else 0 end as Overpayments
from v_ClientSales

	where OperationalYear > 2018
	and TotalRepaid_IncludingOverpayments-CreditLocal > 0