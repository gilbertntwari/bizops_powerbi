Use RosterDataWarehouse;

Select 
Distinct SectorName, 
	SiteName,
	GroupName,
	LastRepaymentDate,
	Sum(TotalCredit) as Credit, 
	Sum(TotalRepaid) as Repaid,
	PercentRepaid,
	Count(case when TotalRepaid - TotalCredit = 0  then 1 end) as Finishers_2021
	from v_ClientSalesBizOps
	where CountryName='Nigeria'
	and OperationalYear in ('2021')
	group by SectorName, SiteName,GroupName,LastRepaymentDate,PercentRepaid