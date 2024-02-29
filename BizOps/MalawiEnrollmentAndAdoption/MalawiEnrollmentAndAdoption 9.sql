SELECT MIN(BucketName) AS Bucket,  ImpactProofPointsName AS 'Impact proof points', 
MIN(AdoptionTargetInModelName) AS 'Adoption target in model',
MIN(AdoptionTargetInModelName) AS 'AdoptionTmodc', SUM(TotalAdopters) AS 'Currentadoptersenrolled', 
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

CASE WHEN BundleName IN('LR2023_SK Boom', 'LR2023_SK Pico', 'LR2023_Itel Phone') THEN 'Solar/Phones'
ELSE 'Nada' END AS BucketName,


CASE WHEN BundleName IN('LR2023_SK Boom') THEN 'SK Boom'
	 WHEN BundleName IN('LR2023_SK Pico') THEN 'SK Pico'
	 WHEN BundleName IN('LR2023_Itel Phone') THEN 'Itel 2160'
ELSE 'Nada' END AS ImpactProofPointsName,

CASE WHEN BundleName IN('LR2023_SK Boom') THEN 0.05 
	 WHEN BundleName IN('LR2023_SK Pico') THEN 0.1 
	 WHEN BundleName IN('LR2023_Itel Phone') THEN 0.15 
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