Use RosterDataWarehouse

Select 
Distinct SectorName, 
	SiteName,
	GroupName,
	LastRepaymentDate,
	Sum(TotalCredit) as Credit, 
	Sum(TotalRepaid) as Repaid,
	Sum(TotalRepaid)/Sum(TotalCredit) as PercentRepaid,
	Count(case when TotalRepaid - TotalCredit = 0  then 1 end) as Finishers_2020
	from v_ClientSalesBizOps
	where CountryName='Nigeria'
	and OperationalYear in ('2020')
	group by SectorName, SiteName,GroupName,LastRepaymentDate