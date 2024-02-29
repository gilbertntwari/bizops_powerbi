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
,CASE WHEN CB.CreditCycleName = '2021A' THEN CB.TOTALCREDIT 
	ELSE 0 END AS A_Credit
,CASE WHEN CB.CreditCycleName = '2021B' THEN CB.TOTALCREDIT 
	ELSE 0 END AS B_Credit
,CASE WHEN CB.BundleName = 'Telephone Itel 5615' THEN CB.BundleQuantity * 19000 WHEN CB.BundleName = 'Chaux_22A' THEN CB.BundleQuantity * 100 
WHEN CB.BundleName = 'Tomato seeds_10g_22A' THEN CB.BundleQuantity * 2000 WHEN CB.BundleName = 'Ishiga_22A' THEN CB.BundleQuantity * 6500
WHEN CB.BundleName = 'Plants de Banane_22A' THEN CB.BundleQuantity * 800 WHEN CB.BundleName = 'Arachide' THEN CB.BundleQuantity * 2500
WHEN CB.BundleName = 'Pompe_22A' THEN CB.BundleQuantity * 27300 WHEN CB.BundleName = 'FOMI_Imbura_22A' THEN CB.BundleQuantity * 1160
WHEN CB.BundleName = 'Avocat_Fruit_21B' THEN CB.BundleQuantity * 525 WHEN CB.BundleName = 'Pics_100_22A' THEN CB.BundleQuantity * 4600 WHEN CB.BundleName = 'SK_Boom_22A' Then CB.BundleQuantity * 42500 
WHEN CB.BundleName = 'FOMI_Totahaza_22A' Then CB.BundleQuantity * 1040 WHEN CB.BundleName = 'Japanese_Plum_Fruit_21B' Then CB.BundleQuantity * 60
WHEN CB.BundleName = 'Cahier de 100 Feuilles' Then CB.BundleQuantity * 1000 WHEN CB.BundleName = 'FOMI_Bagara_22A' Then CB.BundleQuantity * 1060 WHEN CB.BundleName = 'Pomme de terre_22A' Then CB.BundleQuantity * 1400
WHEN CB.BundleName = 'SK Boom_21B' Then CB.BundleQuantity * 42500 
WHEN CB.BundleName = 'SK_Boom_22A' Then CB.BundleQuantity * 42500
WHEN CB.BundleName = 'Mais 53_22A' Then CB.BundleQuantity * 4700
WHEN CB.BundleName = 'SKPro 300_22A' Then CB.BundleQuantity * 32000 WHEN CB.BundleName = 'Soja' Then CB.BundleQuantity * 2200 WHEN CB.BundleName = 'Macadamia_Fruit_21B' Then CB.BundleQuantity * 3300 ELSE 0 END AS Credit 

--Adding the names as they appear on the invoice
,CASE WHEN CB.BundleName = 'Telephone Itel 5615' THEN 'Telefone_22A qty' WHEN CB.BundleName = 'Chaux_22A' THEN 'ishwagara_22A kgs' 
WHEN CB.BundleName = 'Tomato seeds_10g_22A' THEN 'Imbuto zitomati_22A gs' WHEN CB.BundleName = 'Ishiga_22A' THEN 'Ishiaga_22A Qty'
WHEN CB.BundleName = 'Plants de Banane_22A' THEN 'imivyaro yibitoke_22A Qty' WHEN CB.BundleName = 'Arachide' THEN 'ibiyoba_22A kgs'
WHEN CB.BundleName = 'Pompe_22A' THEN 'Ipompo_22A qty' WHEN CB.BundleName = 'FOMI_Imbura_22A' THEN 'FOMI_Imbura_22A Kgs'
WHEN CB.BundleName = 'Avocat_Fruit_21B' THEN 'ivoka_22A qty' WHEN CB.BundleName = 'Pics_100_22A' THEN 'Pics_100_22A Qty'  WHEN CB.BundleName = 'SK_Boom_22A' Then 'SK_Boom_22A Qty' 
WHEN CB.BundleName = 'FOMI_Totahaza_22A' Then 'FOMI_Totahaza_22A Qty' WHEN CB.BundleName = 'Japanese_Plum_Fruit_21B' Then 'Amatunda_22A qty'
WHEN CB.BundleName = 'Cahier de 100 Feuilles' Then 'Amakaye_22A Qty' WHEN CB.BundleName = 'FOMI_Bagara_22A' Then 'FOMI_Bagara_22A Qty' WHEN CB.BundleName = 'Pomme de terre_22A' Then 'ibiraya_22A kgs'
WHEN CB.BundleName = 'SK Boom_21B' Then 'SK Boom_21B'  WHEN CB.BundleName = 'Mais 53_22A' Then 'Ibigori_22A kgs'
WHEN CB.BundleName = 'SK_Boom_22A' Then 'SK_Boom_22A Qty'
WHEN CB.BundleName = 'SKPro 300_22A' Then 'SKPro 300_22A Qty' WHEN CB.BundleName = 'Soja' Then 'Isoya_22A kgs' WHEN CB.BundleName = 'Macadamia_Fruit_21B' Then 'Makadamiya_22A qty' ELSE 'A' END AS Input 

FROM v_ClientBundles AS CB	

WHERE 
CB.CountryName = 'Burundi' 
AND CB.SeasonName = '2022A'
AND CB.InputCredit >0
AND CB.BundleName <> 'Houes_20B'
and CB.DistrictName = @District
and CB.BundleName <> 'Houes_22A'
and CB.BundleName <> 'Pics_100_22A'
and CB.BundleName <> 'FOMI_Bagara_21B'
and CB.BundleName <> 'SKH_40z'
and CB.BundleName <> 'Chaux_21B'


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
,CASE WHEN CB.CreditCycleName = '2021B' THEN CB.TOTALCREDIT 
	ELSE 0 END AS A_Credit
,CASE WHEN CB.CreditCycleName = '2021A' THEN CB.TOTALCREDIT 
	ELSE 0 END AS B_Credit
,CASE WHEN CB.BundleName ='SKPro_21B' THEN CB.BundleQuantity * 31000 when CB.BundleName = 'SKP 300_21A_0.1' THEN CB.BundleQuantity * 15500
when CB.BundleName = 'SK_Boom' THEN CB.BundleQuantity * 41500
when CB.BundleName = 'Phone_21B_2seasons' THEN CB.BundleQuantity * 17000 ELSE 0 END AS Credit

--,case WHEN CB.BundleName ='FOMI_Imbura_20A' THEN 'FOMI_Imbura' ELSE Convert(varchar(10), 0) END AS ddd
,CASE WHEN CB.BundleName = 'SKPro_21B' then 'Itara SKPro_21B QTY'  
WHEN CB.BundleName = 'SK_Boom' Then 'SK Boom Qty'
when CB.BundleName = 'SKP 300_21A_0.1' then 'SKP 300_ Itara 21A_0.1 QTY'   ELSE 'Iterefone ku masizeni abiri_21B qty' END AS Input 

FROM v_ClientBundles AS CB	
WHERE 
CB.CountryName = 'Burundi' 
AND CB.SeasonName in ('2021A', '2021B')
AND CB.InputCredit >0
AND CB.BundleName in ('SKPro_21B', 'Phone_21B_2seasons', 'SK_Boom')
and CB.DistrictName = @District
order by OAFID ASC 