SELECT 
CountryName,
DistrictName, 
BundleName, 
BundleQuantity,

CASE WHEN DistrictName IN ('Dedza', 'Ntcheu') THEN 'Central Region' 
ELSE 'Malawi Southern'  END AS  RegionName,

CASE WHEN BundleName IN('LR2023_Soya Beans', 'LR2023_Gnut CG11', 'LR2023_Gnut CG9','LR2023_Nua 45', 'LR2023_Nua 45 Winter') 
THEN 1 ELSE 0 END AS 'Number of legume adopters',

CASE WHEN BundleName IN('LR2023_Soya Beans', 'LR2023_Gnut CG11', 'LR2023_Gnut CG9','LR2023_Nua 45', 'LR2023_Nua 45 Winter') 
THEN BundleQuantity ELSE 0 END AS 'legume adopters quantity',

CASE WHEN BundleName IN('LR2023_Maize_Reduced Urea') THEN 1 ELSE 0 END AS 'Maize reduced urea adopters',

CASE WHEN BundleName IN('LR2023_Maize_Reduced Urea') THEN BundleQuantity ELSE 0 END AS 'Maize reduced urea adopters quantity',

CASE WHEN BundleQuantity > 0 THEN 1 ELSE 0 END AS 'Total Adopters'

FROM v_ClientInputs

WHERE CountryName = 'Malawi'AND 
OperationalYear = 2023 AND 
BundleName NOT IN('DO NOT USE') AND 
BundleQuantity > 0 AND 
DistrictName <>'Staff Input Access' AND 
BundleName <> 'LR2023_Membership Fee';