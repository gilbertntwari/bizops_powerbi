Select 
Distinct DistrictName,
	COUNT(Distinct DimSiteID) AS Sites, 
	Sum(TotalCredit) as Credit, 
	Sum(TotalCredit) / COUNT(Distinct DimSiteID) as AverageCredit,
	sum(TotalRepaid) / COUNT(Distinct DimSiteID) as AverageRepaid,
   ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100) as PecntRepaid,


Case when ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100) >=95    and ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100)<= 95.99 then 1
     when ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100) > 95.99 and ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100)<= 96.99 then 1.5
	 when ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100) > 96.99 and ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100)<= 97.99 then 1.75
	 when ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100) > 97.99 and ((sum(TotalRepaid) / COUNT(Distinct DimSiteID)) / (Sum(TotalCredit) / COUNT(Distinct DimSiteID))*100)<= 98.99 then 2
	 else 0 end as Points

From v_ClientSalesBizOps
where CountryName = 'Kenya'
and Season = '2021, Long Rain'
and DistrictName not in ('KENYA STAFF', 'OAF Duka')
 Group By DistrictName 
