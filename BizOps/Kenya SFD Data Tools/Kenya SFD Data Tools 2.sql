Use RosterDataWarehouse;
-- Sub Querry for Grouping Regions
WITH RegionSubQuery As
(Select
 DistrictName,
 Case
      When DistrictName in ('Masaba', 'Nyamira', 'Sotik') then 'Bensoms'
      When DistrictName in ('Kimilili', 'Matete', 'Saboti', 'Webuye') then 'Elgon'
      When DistrictName in ('Busia', 'Nambale', 'Teso') then 'BorderLand'
	  When DistrictName in ('Hamisi','Kakamega (South)','Vihiga') then 'Haviks'
	  When DistrictName in ('Alego','Gem','Serabo') then 'Yala'
	  When DistrictName in ('Butere','Kakamega B (North)','Mumias') then'Sugar Zone'
	  When DistrictName in ('Imenti','Kenol','Manyatta','Sagana') then'Mount Kenya'
	  When DistrictName in ('Ol Kalou','Njoro') then 'Nakuru'
	  When DistrictName in ('Awendo','Rongo','Ndhiwa','Migori') then 'Lake'
	  When DistrictName in ('Borabu','Gucha','Kisii','Suneka') then 'Kisii'
	  When DistrictName in ('Green Shamba','Nyando','Kabondo','Rachuonyo') then 'Karanya'
	  When DistrictName in ('Belgut','Kapsabet','Kipkelion','Tinderet') then 'KENA'
	  When DistrictName in ('Baharini','Kabiyet','Keiyo') then 'Eldoret'
	  When DistrictName in ('Cherangany','Lugari','Ndalu') then 'Scheme'
	  When DistrictName in ('Bungoma','Chwele','Sirisia') then 'Busitech'
end as Region,
-- Here we are Summing TotalCredit then the other line is for Counting Total Sites
Sum(TotalCredit) As TotalCredit,
sum(TotalRepaid) As TotalRepaid,
COUNT(Distinct DimSiteID) As TotalSites
From v_ClientSalesBizOps
where CountryName = 'Kenya'
and Season = '2021, Long Rain'
and DistrictName not in ('KENYA STAFF', 'OAF Duka')
and PercentRepaid >='0.1'
Group By DistrictName)
-- We now Select the Regions from the Sub Query
Select
Region,

-- To get the Region's Average Credit we now sum the Total Credit Devide by the Sum of Total Sites
 Sum(TotalCredit) as TTCredit,    
Sum(TotalCredit) / sum(TotalSites) as RegionAvgCredit,
	sum(TotalRepaid)/ sum(TotalSites) as RegionAvgRepaid,
	((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100) as PecntRepaid,

-- Here is the Tier Determination, use this for all the 16 Regions, I have added for only one Region
    Case when ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100) >=95    and ((sum(TotalRepaid) /sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100)<= 95.99 then 1
         when ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100) > 95.99 and ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100)<= 96.99 then 1.5
	     when ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100) > 96.99 and ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100)<= 97.99 then 1.75
	     when ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) / sum(TotalSites))*100) > 97.99 and ((sum(TotalRepaid) / sum(TotalSites)) / (Sum(TotalCredit) /sum(TotalSites))*100)<= 98.99 then 2
	 else 0 end as Points																																																																																														
	  
-- We now group by the Region from the sub query
from RegionSubQuery Group By Region