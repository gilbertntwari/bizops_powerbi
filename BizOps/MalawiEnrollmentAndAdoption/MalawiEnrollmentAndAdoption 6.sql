SELECT MIN(BucketName) AS Bucket,  ImpactProofPointsName AS 'Impact proof points', 
MIN(AdoptionTargetInModelName) AS 'Adoption target in model',
MIN(AdoptionTargetInModelName) AS 'AdoptionTmoda', 
SUM(TotalAdopters) AS 'Currentadoptersenrolled', 
SUM(Qualifiers) AS 'Currentadoptersqualified'

FROM(SELECT DISTINCT GlobalId, MIN(BucketName) AS 'BucketName', 
ImpactProofPointsName, MIN(AdoptionTargetInModelName) AS 'AdoptionTargetInModelName',

CASE WHEN GlobalId IS NOT NULL THEN 1 ELSE 0 END AS TotalAdopters,

CASE 
 WHEN TotalCredit <=100000 AND TotalRepaid >=10000 THEN 1   
 WHEN TotalCredit >100000 AND TotalRepaid >=20000 THEN 1
 ELSE 0
END AS Qualifiers

FROM(SELECT GlobalId, TotalCredit, TotalRepaid,

CASE WHEN BundleName IN('LR2023_Soya Beans', 'LR2023_Gnut CG11', 'LR2023_Gnut CG9','LR2023_Nua 45', 'LR2023_Nua 45 Winter') THEN 'Legumes'
ELSE 'Nada' END AS BucketName,


CASE WHEN BundleName IN('LR2023_Gnut CG11', 'LR2023_Gnut CG9') THEN 'Groundnut'
	 WHEN BundleName IN('LR2023_Nua 45') THEN 'Nua 45 Bean'
	 WHEN BundleName IN('LR2023_Nua 45 Winter') THEN 'Nua 45 Winter Bean'
	 WHEN BundleName IN('LR2023_Soya Beans') THEN 'Soya'
ELSE 'Nada' END AS ImpactProofPointsName,

CASE WHEN BundleName IN('LR2023_Soya Beans', 'LR2023_Gnut CG11', 'LR2023_Gnut CG9') THEN 0.25
	 WHEN BundleName IN('LR2023_Nua 45', 'LR2023_Nua 45 Winter') THEN 0.5
ELSE 0.0 END AS AdoptionTargetInModelName

FROM v_ClientSalesBizOps debb LEFT JOIN v_ClientInputs debby 
ON debb.GlobalId = debby.GlobalClientID
WHERE debb.CountryName = 'Malawi' AND 
debb.DistrictName <>'Staff Input Access' AND 
GlobalClientID IS NOT NULL AND
debb.OperationalYear = 2023 AND 
BundleQuantity > 0) as innerTable
WHERE BucketName <> 'Nada' 
GROUP BY GlobalId, ImpactProofPointsName, TotalCredit, TotalRepaid) AS klaws
GROUP BY ImpactProofPointsName