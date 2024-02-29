Select top 10000000 
	SiteName
	,GroupName
	, DimGroupID
	,count (GlobalID) as Clients
	, Sum(Case when LastRepaymentDate < '2022-06-30' then 1 else 0 end) as Stagnated
from v_ClientSalesBizOps 
	where CountryName = 'Nigeria' and Season = '2022, Long Rain'
	Group by SiteName, GroupName, DimGroupID
	Order by SiteName ASC