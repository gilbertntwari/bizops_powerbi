Use RosterDataWarehouse

Select 
Distinct SectorName, 
	SiteName, GroupName, 
	Count(DimClientID) AS	Clients, 
	Sum(TotalCredit) as Credit, 
	Sum(TotalRepaid) as Repaid,
	Sum(TotalRepaid)/ Sum(TotalCredit) as PercentRepaid,
	Case when Sum(TotalRepaid) - Sum(TotalCredit) = 0 then 1 else 0 end as GroupsCompleted,
	Count(case when TotalRepaid - TotalCredit = 0  then 1 end) as Finishers
from v_ClientSalesBizOps
where CountryName = 'Nigeria'
and Season = '2021, Long Rain'
AND TotalCredit > 0

Group By SectorName, SiteName, GroupName