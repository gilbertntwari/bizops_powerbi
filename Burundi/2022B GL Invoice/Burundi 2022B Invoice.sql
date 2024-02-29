USE RosterDataWarehouse;
SELECT 
CB.CountryName
,CB.OAFID
,CB.DistrictName
,CB.SiteName
,CB.GroupName
,CB.DimClientID
,CB.DimGroupID
,CB.FirstName
,CB.LastName
,CB.BundleQuantity
,CB.InputCredit
,CB.CreditCycleName
,CB.BundleName 
,CB.InputNames
,CB.GlobalClientID
,CB.InputCreditAdjusted
,CASE WHEN CB.CreditCycleName = '2022A' THEN CB.TOTALCREDIT 
	ELSE 0 END AS A_Credit
,CASE WHEN CB.CreditCycleName = '2022B' THEN CB.TOTALCREDIT 
	ELSE 0 END AS B_Credit

,CASE WHEN CB.BundleName = 'Amabungo_imivyaro' THEN CB.BundleQuantity * 120 WHEN CB.BundleName = 'Amasuka' THEN CB.BundleQuantity * 9000
WHEN CB.BundleName = 'Avocat_Fruit' THEN CB.BundleQuantity * 1050 WHEN CB.BundleName = 'DAP_22B' THEN CB.BundleQuantity * 1160
WHEN CB.BundleName = 'FOMI_Bagara_22B' THEN CB.BundleQuantity * 1060 WHEN CB.BundleName = 'FOMI_Totahaza_22B' THEN CB.BundleQuantity * 1040
WHEN CB.BundleName = 'Ishiga_22B' THEN CB.BundleQuantity * 6500 WHEN CB.BundleName = 'Ishwagara_22B' THEN CB.BundleQuantity * 100
WHEN CB.BundleName = 'Macadamia_Fruit' THEN CB.BundleQuantity * 3300 WHEN CB.BundleName = 'Paneau_solaire' THEN CB.BundleQuantity * 10000  WHEN CB.BundleName = 'Phone_22B' Then CB.BundleQuantity * 41000
WHEN CB.BundleName = 'Pics_22B' Then CB.BundleQuantity * 4600 WHEN CB.BundleName = 'Pompe_22B' Then CB.BundleQuantity * 27300
WHEN CB.BundleName = 'Prune_du_japon_Fruit' Then CB.BundleQuantity * 60 WHEN CB.BundleName = 'SK Boom_22B' Then CB.BundleQuantity * 87500 WHEN CB.BundleName = 'SKH_40z_22B' Then CB.BundleQuantity * 110000
WHEN CB.BundleName = 'SKPro 300_22B' Then CB.BundleQuantity * 32000 WHEN CB.BundleName = 'Sun King Home_60_22B' Then CB.BundleQuantity * 170000
WHEN CB.BundleName = 'Telephone_Igitabo_22B' Then CB.BundleQuantity * 200000 WHEN CB.BundleName = 'Uree_22B' Then CB.BundleQuantity * 1060 
WHEN CB.BundleName = 'FOMI_Imbura_22B' Then CB.BundleQuantity * 1160 WHEN CB.BundleName = 'Arrosoir' Then CB.BundleQuantity * 10000 ELSE 0 END AS Credit 

--Adding the names as they appear on the invoice
,CASE WHEN CB.BundleName = 'Amabungo_imivyaro' THEN 'Amabungo_imivyaro_22B' WHEN CB.BundleName = 'Amasuka' THEN 'Isuka_22B'

WHEN CB.BundleName = 'Avocat_Fruit' THEN 'Imivyaro yamavoka_22B' WHEN CB.BundleName = 'DAP_22B' THEN 'DAP_22B'
WHEN CB.BundleName = 'FOMI_Bagara_22B' THEN 'FOMI_Bagara_22B' WHEN CB.BundleName = 'FOMI_Totahaza_22B' THEN 'FOMI_Totahaza_22B'
WHEN CB.BundleName = 'Ishiga_22B' THEN 'Ishiga' WHEN CB.BundleName = 'Ishwagara_22B' THEN 'Ishwagara_22B'
WHEN CB.BundleName = 'Macadamia_Fruit' THEN 'Makadamiya_22B' WHEN CB.BundleName = 'Paneau_solaire' THEN 'Paneau_solaire_22B'  WHEN CB.BundleName = 'Phone_22B' Then 'Terefone ntoya_22B' 
WHEN CB.BundleName = 'Pics_22B' Then 'Pics_22B' WHEN CB.BundleName = 'Pompe_22B' Then 'Ipompo_22B'
WHEN CB.BundleName = 'Prune_du_japon_Fruit' Then 'Amatunda_22B' WHEN CB.BundleName = 'SK Boom_22B' Then 'Itara_Boom_22B' WHEN CB.BundleName = 'SKH_40z_22B' Then 'Itara_40z_22B'
WHEN CB.BundleName = 'SKPro 300_22B' Then 'Itara_SKPro_22B'  WHEN CB.BundleName = 'Sun King Home_60_22B' Then 'Itara_60_22B'
WHEN CB.BundleName = 'Telephone_Igitabo_22B' Then 'Terefone nini_22B' WHEN CB.BundleName = 'Uree_22B' Then 'Uree_22B' 
WHEN CB.BundleName = 'FOMI_Imbura_22B' Then 'FOMI_Imbura_22B' WHEN CB.BundleName = 'Arrosoir' Then 'Arrosoir_22B' ELSE 'A' END AS Input 

FROM v_ClientBundles AS CB	

WHERE 
CB.CountryName = 'Burundi' 
AND CB.SeasonName = '2022B'
AND CB.InputCredit >0
AND CB.BundleName <> 'Houes_22B'
and CB.DistrictName = @District



Union All

SELECT 
CB.CountryName
,CB.OAFID
,CB.DistrictName
,CB.SiteName
,CB.GroupName
,CB.DimClientID
,CB.DimGroupID
,CB.FirstName
,CB.LastName
,CB.BundleQuantity
,CB.InputCredit
,CB.CreditCycleName
,CB.BundleName 
,CB.InputNames
,CB.GlobalClientID
,CB.InputCreditAdjusted
,CASE WHEN CB.CreditCycleName = '2022B' THEN CB.TOTALCREDIT 
	ELSE 0 END AS A_Credit
,CASE WHEN CB.CreditCycleName = '2022A' THEN CB.TOTALCREDIT 
	ELSE 0 END AS B_Credit
,CASE WHEN CB.BundleName ='SK_Boom_22A' THEN CB.BundleQuantity * 42500 when CB.BundleName = 'Pompe_22A' THEN CB.BundleQuantity * 13650 ELSE 0 END AS Credit

--,case WHEN CB.BundleName ='FOMI_Imbura_20A' THEN 'FOMI_Imbura' ELSE Convert(varchar(10), 0) END AS ddd
,CASE WHEN CB.BundleName = 'SK_Boom_22A' then 'Itara_Boom_22B'  
WHEN CB.BundleName = 'Pompe_22A' Then 'Ipompo_22B' ELSE 'Iterefone ku masizeni abiri_21B qty' END AS Input 

FROM v_ClientBundles AS CB	
WHERE 
CB.CountryName = 'Burundi' 
AND CB.SeasonName in ('2021A', '2021B')
AND CB.InputCredit >0
AND CB.BundleName in ('SK_Boom_22A', 'Pompe_22A')
and CB.DistrictName = @District
order by OAFID ASC 

