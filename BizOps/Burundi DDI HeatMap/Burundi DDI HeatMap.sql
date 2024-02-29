use OAF_DATA_SCIENCE;

select Distinct 
CountryName,
	SeasonName, 
	DistrictName, 
	RegionName, 
	SiteName, 
	CONCAT(DistrictName, SiteName) as UniqueID, 
	Sum(NumberOfHarrassmentCalls) AS #HarrassmentCalls, 
	Sum(Case when Stagnated = 1 then 1 else 0 end) as Stagnant, 
	Sum(NumberOfFraudCalls) as #FraudCalls, 
	Sum(case when AnyUndeliveredInput =1 then 1 else 0 end) as UndeliveredInput, 
    Sum(NumberOfBalanceChecks) as BalanceChecks, Sum(MaxNumberOfDifferentUsersBalancesCheckedFromPhoneNumberThisUser) as DifferentUsersUsedthisNumberforBalanceChecks,
    SUM(MaxNumberOfDifferentFarmersMadePaymentsWithPhoneNumber)  as DifferentFarmersMadePaymentsWithPhoneNumber, Sum(NumberOfTimesPhoneNumberRegistered) as DuplicatePhone#s, Sum(NumberOfCalls) as NumberofCalls,
    Case when CountryName = 'Rwanda' and SeasonName = '2022' then  DATEDIFF(day, getdate(), '2022/07/31') else 0 end as DaystoSeasonEnd,
	proba_true



from DATADRIVENINVESTIGATION_ClientOverview 
LEFT JOIN (
   --use OAF_DATA_SCIENCE;
select CONCAT(DistrictName, SiteName) as UniqueID, proba_true
from DATADRIVENINVESTIGATION_sitefraudpredictions
WHERE CountryName = 'Rwanda'
AND SeasonName = '2022'
) FB ON CONCAT(DistrictName, SiteName)=FB.UniqueID
Where SeasonName = '2022'
and CountryName = 'Rwanda'

Group by SeasonName, CountryName, DistrictName, RegionName, SiteName, proba_true

order by DistrictName, SiteName asc 