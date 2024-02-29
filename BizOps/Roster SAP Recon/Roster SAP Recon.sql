Select
	CountryName
	, RevenueDate
	, sum(revenue) as Revenue
from v_revenue
group by CountryName, revenuedate