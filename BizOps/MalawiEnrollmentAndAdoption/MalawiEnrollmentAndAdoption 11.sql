SELECT MIN(Buket) AS 'Bucket', ImpactProofPoints AS 'Impact Proof Points', 
MIN(AdoptionTarget) AS 'Adoption Target In Model', MIN(AdoptionTarget) AS 'AdoptionTcalc', 
SUM(TotalAdopters) AS 'Currentadoptersenrolled', 
SUM(Qualifiers) AS 'Currentadoptersqualified'


FROM(SELECT DISTINCT GlobalId, SUM(Urea) ureaSum, SUM(Ureatopup) AS Ureatopupsum, MIN(BucketName) AS Buket,
MIN(ImpactProofPointsName) AS ImpactProofPoints, MIN(AdoptionTargetInModelName)AS AdoptionTarget,

CASE WHEN GlobalId IS NOT NULL THEN 1 ELSE 0 END AS TotalAdopters,

CASE 
 WHEN MIN(TotalCredit) <=100000 AND MIN(TotalRepaid) >=10000 THEN 1   
 WHEN MIN(TotalCredit) >100000 AND MIN(TotalRepaid) >=20000 THEN 1
 ELSE 0
END AS Qualifiers

FROM(SELECT GlobalId, BundleName, TotalCredit, TotalRepaid,

CASE WHEN  BundleName IN('LR2023_Maize_Reduced Urea', 'LR2023_TopUp Urea') THEN 'Maize' 
ELSE 'Nada' END AS BucketName,

CASE  WHEN BundleName IN('LR2023_Maize_Reduced Urea', 'LR2023_TopUp Urea') THEN 'Urea reduction'
ELSE 'Nada' END AS ImpactProofPointsName,

CASE WHEN BundleName IN('LR2023_Maize_Reduced Urea', 'LR2023_TopUp Urea') THEN 0.75
ELSE 0 END AS AdoptionTargetInModelName,

CASE WHEN BundleName='LR2023_Maize_Reduced Urea' THEN 1
ELSE 0
END AS Urea,

CASE WHEN BundleName='LR2023_TopUp Urea' THEN 1
ELSE 0
END AS Ureatopup

FROM v_ClientSalesBizOps debb LEFT JOIN v_ClientInputs debby 
ON debb.GlobalId = debby.GlobalClientID
WHERE BundleName IN('LR2023_Maize_Reduced Urea', 'LR2023_TopUp Urea') AND 
debb.CountryName = 'Malawi'AND 
debb.OperationalYear = 2023 AND 
BundleName NOT IN('DO NOT USE') AND 
BundleQuantity > 0 AND 
debb.DistrictName <>'Staff Input Access' AND 
BundleName <> 'LR2023_Membership Fee' AND
GlobalClientID IS NOT NULL GROUP BY GlobalId, BundleName,TotalCredit, TotalRepaid) AS innerTable
GROUP BY GlobalId) AS nesTable WHERE Ureatopupsum=0
GROUP BY ImpactProofPoints