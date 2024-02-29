Use OAF_DATA_SCIENCE
select 
CountryName,SeasonName, DistrictName, RegionName, SiteName, CONCAT(SeasonName, DistrictName, RegionName, SiteName) as UniqueID, Sum(NumberOfHarrassmentCalls) AS #HarrassmentCalls, Sum(Case when Stagnated = 1 then 1 else 0 end) as Stagnant, Sum(NumberOfFraudCalls) as #FraudCalls, Sum(case when AnyUndeliveredInput =1 then 1 else 0 end) as UndeliveredInput, 
Sum(NumberOfBalanceChecks) as BalanceChecks, Sum(MaxNumberOfDifferentUsersBalancesCheckedFromPhoneNumberThisUser) as DifferentUsersUsedthisNumberforBalanceChecks,
SUM(MaxNumberOfDifferentFarmersMadePaymentsWithPhoneNumber)  as DifferentFarmersMadePaymentsWithPhoneNumber, Sum(NumberOfTimesPhoneNumberRegistered) as DuplicatePhone#s, Sum(NumberOfCalls) as NumberofCalls,
Case when CountryName = 'Kenya' and SeasonName = '2022, Long Rain' then  DATEDIFF(day, getdate(), '2022/02/28') else 0 end as DaystoSeasonEnd,
Case when Sum(NumberOfHarrassmentCalls) >= @HarrassmentCalls then 1 else 0 end AS Harrassment,
Case when Sum(Case when Stagnated = 1 then 1 else 0 end)>= @Stagnant then 1 end as Stagnation,
Case when  Sum(NumberOfFraudCalls) >= @FraudCalls then 1 else 0 end as Fraud,
Case when  Sum(case when AnyUndeliveredInput =1 then 1 else 0 end) >= @UndeliveredInput then 1 else 0 end as Undelivered,
Case when Sum(NumberOfTimesPhoneNumberRegistered) >= @PhoneRegistered then 1 else 0 end as Duplicates,

Case when Sum(NumberOfHarrassmentCalls) >= @HarrassmentCalls then 1 else 0 end +
Case when Sum(Case when Stagnated = 1 then 1 else 0 end)>= @Stagnant then 1 end +
Case when  Sum(NumberOfFraudCalls) >= @FraudCalls then 1 else 0 end +
Case when  Sum(case when AnyUndeliveredInput =1 then 1 else 0 end) >= @UndeliveredInput then 1 else 0 end +
Case when Sum(NumberOfTimesPhoneNumberRegistered) >= @PhoneRegistered then 1 else 0 end as Flags



from DATADRIVENINVESTIGATION_ClientOverview
Where SeasonName in ('2021, Long Rain', '2022, Long Rain', '2022, Short Rain')
and CountryName = 'Kenya'

and DistrictName not in ('KENYASTAFF', 'OAFDuka')
and DistrictName in (@District)

Group by SeasonName, CountryName, DistrictName, RegionName, SiteName

order by DistrictName, SiteName asc 