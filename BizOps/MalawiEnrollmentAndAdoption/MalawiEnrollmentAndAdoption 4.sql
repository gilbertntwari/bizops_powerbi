SELECT MIN(district) AS 'district', 
SUM(TotalAdopters) AS 'totalClients', 
SUM(Qualifier) AS 'qualifiedClients'

FROM(SELECT DISTINCT GlobalId, 
debb.DistrictName AS district, 

CASE WHEN SUM(BundleQuantity) > 0 THEN 1 ELSE 0 END AS TotalAdopters,

CASE 
 WHEN TotalCredit <=100000 AND TotalRepaid >=10000 THEN 1   
 WHEN TotalCredit >100000 AND TotalRepaid >=20000 THEN 1
 ELSE 0
END AS Qualifier

FROM v_ClientSalesBizOps debb LEFT JOIN v_ClientInputs debby 
ON debby.GlobalClientID = debb.GlobalId WHERE debb.CountryName = 'Malawi'AND 
debb.OperationalYear = 2023 AND 
BundleName NOT IN('DO NOT USE') AND 
BundleQuantity > 0 AND 
debb.DistrictName <>'Staff Input Access' AND 
BundleName <> 'LR2023_Membership Fee' AND
GlobalClientID IS NOT NULL AND 
BundleName IN('LR2023_Maize_Reduced Urea','LR2023_Soya Beans', 'LR2023_Gnut CG11', 'LR2023_Gnut CG9',
'LR2023_Nua 45', 'LR2023_Nua 45 Winter','LR2023_Fruit Trees', 'LR2023_Non-Fruit Trees',
'LR2023_SK Boom', 'LR2023_SK Pico', 'LR2023_Itel Phone') OR 

debb.CountryName = 'Malawi'AND 
debb.OperationalYear = 2023 AND 
BundleName NOT IN('DO NOT USE') AND 
BundleQuantity > 0 AND 
debb.DistrictName <>'Staff Input Access' AND 
BundleName <> 'LR2023_Membership Fee' AND
GlobalClientID IS NOT NULL AND 
InputName IN('SC423', 'DK 777', 'DK 90-89', 'PW3812', 'DK 8033') 
GROUP BY GlobalId, debb.DistrictName, TotalCredit, TotalRepaid) AS innerTable
GROUP BY district;