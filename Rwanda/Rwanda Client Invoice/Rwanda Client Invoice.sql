use RosterDataWarehouse;
SELECT
B.DistrictName
    ,B.SiteName
    ,B.GroupName
                ,B.DimClientID
	,B.OAFID
	,B.CreditCycleName
	,B.BundleName
	,B.BundleQuantity
	,B.InputNames
	,B.InputCredit
               ,B.FirstName
               ,B.LastName
    ,CASE WHEN B.CreditCycleName = '2020A' THEN '2020A Order'
	ELSE '2020B Order' END AS Cycle
	,CASE WHEN B.CreditCycleName <> '2020A' THEN 0 WHEN B.BundleName ='SKP2' THEN B.TotalCredit /2  WHEN B.BundleName ='SKM' THEN B.TotalCredit /2 WHEN BundleName = 'SHS-20A' THEN B.TotalCredit /4 
	ELSE B.TotalCredit END AS A_Credit
	,CASE WHEN B.CreditCycleName = '2020B' THEN B.TotalCredit WHEN B.BundleName ='SKP2' THEN B.TotalCredit /2  WHEN B.BundleName ='SKM' THEN B.TotalCredit /2 WHEN BundleName = 'SHS-20A' THEN B.TotalCredit /4
	ELSE 0 END AS B_Credit
	,CASE WHEN B.BundleName = 'SHS-20A' THEN 37250 ELSE 0 END AS NextSeason
	,SC.TotalCredit as TC
                ,SC.AccountNumber
	
FROM v_ClientBundles AS B
LEFT JOIN v_ClientSalesBizOps as SC
ON B.DimClientID=SC.DimClientID 
WHERE B.CountryName = 'Rwanda' 
AND B.SeasonName = '2020'
AND B.InputCredit >0
AND B.DistrictName = @District
AND B.SiteName = @Site
AND sc.Season = '2020'


Union All

SELECT 
B.DistrictName
    ,B.SiteName
    ,B.GroupName
	,B.OAFID
                ,B.DimClientID
	,B.CreditCycleName
	,B.BundleName
	,B.BundleQuantity
	,B.InputNames
	,B.InputCredit
               ,B.FirstName
               ,B.LastName
,CASE WHEN B.CreditCycleName = '2019A' THEN '2019A Order'
	ELSE '2019B Order' END AS Cycle
	,CASE WHEN B.CreditCycleName <> '2020A' THEN B.TOTALCREDIT / 4
	ELSE 0 END AS A_Credit
	,CASE WHEN B.CreditCycleName <> '2020A' THEN B.TOTALCREDIT / 4
	ELSE 0 END AS A_Credit
	,CASE WHEN CreditCycleName = '2019B' THEN 18625 ELSE 0 END AS NextSeason
	,SC.TotalCredit as TC
               ,SC.AccountNumber
	FROM v_ClientBundles AS B
LEFT JOIN v_ClientSalesBizOps as SC
ON B.DimClientID=SC.DimClientID 

WHERE B.CountryName='Rwanda' 
    and SeasonName = '2019'
    and InputCredit > 0
    and InputNames = 'SHS' 
	and BundleName <> '20A_SHS cash' 
	and B.DistrictName = @District
                AND B.SiteName = @Site
	  AND SC.Season = '2020'

--ORDER BY B.SiteName, B.GroupName, B.DimClientID, B.CreditCycleName ASC