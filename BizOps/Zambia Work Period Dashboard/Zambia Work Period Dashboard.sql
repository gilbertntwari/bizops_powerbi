use rosterdatawarehouse;

--First Query
with groupInfo as(
select 
	[FO Name], DistrictName, SectorName,DimSiteID, SiteName, GroupName, 
	SUM(TotalRepaid) As TotalRepaid,
	SUM(TotalCredit) As TotalCredit,
	Count(DIMClientID) as SCI,
	CASE WHEN SUM(TotalRepaid) / SUM(TotalCredit) = 1 THEN 1 Else 0  end AS GP
from
	v_ClientSalesBizOps
where
	CountryName = 'Zambia'
	AND Season = '2021, Long Rain'
	--and DistrictName = @District
	and TotalCredit > 0
	and TotalRepaid > 0
group by
	[FO Name], DistrictName, SectorName, DimSiteID, SiteName, GroupName  )
-- Second Inner Query
select 
	[FO Name], DistrictName, SectorName, SiteName, 
	SUM(TotalCredit) As TotalCredit,sum(TotalRepaid) As TotalRepaid,
    sum(GP) As CompletedGroupsCount,
	Count(GP) AS TGP,
	Sum(SCI) AS Clients,
	CASE WHEN DimSiteID in (11231, 2009, 2006, 2007, 2005, 2008) then 'Edmore Sibanda'
WHEN DimSiteID in (1999, 1995, 1998, 1997, 19996) then 'Ireen Mukuswani'
WHEN DimSiteID in (2014, 2010, 2011, 2012, 2013, 11232) then 'Marley Ngala'
WHEN DimSiteID in (2002, 2000, 2001, 2003, 2004) then 'Timothy Sibanda'
WHEN DimSiteID in (551, 550, 548, 549, 558) then 'Divine Malambo'
WHEN DimSiteID in (535, 552, 532) then 'Hunter Nchimunya'
WHEN DimSiteID in (542, 541, 540, 543) then 'Jabulani Sibanda'
WHEN DimSiteID in (574, 573, 571) then 'Obert Maumba'
WHEN DimSiteID in (562, 560, 559, 561, 557) then 'Patrick Kalenda'
WHEN DimSiteID in (527, 525, 526) then 'Divine Malambo'
WHEN DimSiteID in (551, 550, 548, 549, 558) then 'Divine Malambo'
WHEN DimSiteID in (1091, 1088, 1090, 1087, 1092) then 'Borniface Cheelo'
WHEN DimSiteID in (1085, 1084, 1083, 1086) then 'Christine Kalinda'
WHEN DimSiteID in (1062, 1059, 1063, 1061, 1060) then 'Fulbeto Chibuye'
WHEN DimSiteID in (1081, 1080, 548, 1082, 11230) then 'Kelvin Chiti'
WHEN DimSiteID in (11228, 1069, 1072, 1073) then 'Mildred Chembo'
WHEN DimSiteID in (1075, 1079, 11229, 1074, 1078) then 'Patrick Kapikili'
WHEN DimSiteID in (1064, 1065, 1068, 1067, 1066) then 'Topisi Ngosa'
WHEN DimSiteID in (1591, 1593, 1592) then 'Enico Shibwanga'
WHEN DimSiteID in (1583, 1585, 11224, 11223, 1584) then 'Michelo Chiimbwe'
WHEN DimSiteID in (1594, 1595, 1597, 1596) then 'Mutinta Muzyamba'
WHEN DimSiteID in (1590, 11225, 1588, 11226, 1586,11227) then 'Paul Nyendwa'
WHEN DimSiteID in (1576, 1587, 1574, 1577, 1575) then 'Steckias Mulinda' ELSE 'A' END as FM,
Case 
	when sum(TotalCredit) >= 935000 then 4 
	when sum(TotalCredit)  < 935000  and sum(TotalCredit) >= 860500 THEN 3 
	when sum(TotalCredit) < 860500  and sum(TotalCredit) >= 691500 THEN 2 
	when sum(TotalCredit) < 691500  and sum(TotalCredit) >= 607500 THEN 2 
	else 0 
END as FinalTRXSizeNumbers,

Case 
	when sum(TotalCredit) >= 935000 then 'A' 
	when sum(TotalCredit)  < 935000  and sum(TotalCredit) >= 860500 THEN 'B' 
	when sum(TotalCredit) < 860500  and sum(TotalCredit) >= 691500 THEN 'C'
	when sum(TotalCredit) < 691500  and sum(TotalCredit) >= 607500 THEN 'D' 
	else 'F' 
END as FinalTRXSizeGrade,
CASE 
	WHEN sum(SCI) >= 180 THEN 4 
	when sum(SCI) < 180  and sum(SCI)>= 163 THEN 3 
	when sum(SCI) < 163  and sum(SCI) >= 129 THEN 2 
	when sum(SCI) < 129  and sum(SCI) >= 112 THEN 1 
	else 0 
END as QualifiersNumber,
CASE 
	WHEN sum(SCI) >= 180 THEN 'A' 
	when sum(SCI) < 180  and sum(SCI)>= 163 THEN 'B' 
	when sum(SCI) < 163  and sum(SCI) >= 129 THEN 'C' 
	when sum(SCI) < 129  and sum(SCI) >= 112 THEN 'D' 
	else 'F' 
END as QualifiersGrade,
SUM(TotalRepaid) / SUM(TotalCredit) as PC,
CASE 
	WHEN SUM(TotalRepaid) / SUM(TotalCredit) >= .98 THEN 4 
	when SUM(TotalRepaid) / SUM(TotalCredit) < .98  and SUM(TotalRepaid) / SUM(TotalCredit) >= .96 THEN 3 
	when SUM(TotalRepaid) / SUM(TotalCredit) < .96  and SUM(TotalRepaid) / SUM(TotalCredit) >= .93 THEN 2 
	when SUM(TotalRepaid) / SUM(TotalCredit) < .93  and SUM(TotalRepaid) / SUM(TotalCredit)>= .90 THEN 1 
	else 0 
END as Repaid
From
	groupInfo
Group By
	[FO Name], DistrictName, SectorName,DimSiteID, SiteName
Order by
   [FO Name], DistrictName, SectorName, SiteName