SELECT MIN(BucketName) AS Bucket,  ImpactProofPointsName AS 'Impact proof points', 
MIN(AdoptionTargetInModelName) AS 'Adoption target in model',
MIN(AdoptionTargetInModelName) AS 'AdoptionTmod', SUM(TotalAdopters) AS 'Currentadoptersenrolled', 
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

CASE WHEN  InputName IN('SC423', 'DK 777', 'DK 90-89', 'PW3812', 'DK 8033') THEN 'Maize' 
ELSE 'Nada' END AS BucketName,


CASE  WHEN InputName IN('SC423', 'DK 777', 'DK 90-89', 'PW3812', 'DK 8033') THEN 'New maize variety'
ELSE 'Nada' END AS sieve,

CASE  WHEN InputName = 'DK 777'THEN 'DK 777'
WHEN InputName = 'SC423'THEN 'SC423'
WHEN InputName = 'PW3812'THEN 'PW3812'
WHEN InputName = 'DK 90-89'THEN 'DK 90-89'
WHEN InputName = 'DK 8033'THEN 'DK 8033'
ELSE 'Nada' END AS ImpactProofPointsName,

CASE WHEN  InputName ='DK 777' THEN 0.15 
WHEN  InputName ='SC423' THEN 0.28 
WHEN  InputName ='PW3812' THEN 0.05
WHEN  InputName ='DK 90-89' THEN 0.07
WHEN  InputName ='DK 8033' THEN 0.0 
ELSE 0 END AS AdoptionTargetInModelName

FROM v_ClientSalesBizOps debb LEFT JOIN v_ClientInputs debby 
ON debb.GlobalId = debby.GlobalClientID
WHERE debb.CountryName = 'Malawi' AND 
debb.DistrictName <>'Staff Input Access' AND 
GlobalClientID IS NOT NULL AND
debb.OperationalYear = 2023 AND 
BundleQuantity > 0) as innerTable
WHERE BucketName <> 'Nada' AND sieve <> 'Nada'
GROUP BY GlobalId, ImpactProofPointsName, TotalCredit, TotalRepaid) AS klaws
GROUP BY ImpactProofPointsName