Use OAF_DATA_SCIENCE
select 
SeasonName
, CountryName
, DistrictName
, RegionName
, SectorName
, SiteName
, CONCAT(SeasonName
, CountryName
, DistrictName
, RegionName
, SectorName
, SiteName) as UniqueID
, GlobalClientID
, NumberOfHarrassmentCalls AS #HarrassmentCalls
, Stagnated
, NumberOfFraudCalls as #FraudCalls
, AnyUndeliveredInput as UndeliveredInput
, NumberOfBalanceChecks as BalanceChecks
, MaxNumberOfDifferentUsersBalancesCheckedFromPhoneNumberThisUser as DifferentUsersUsedthisNumberforBalanceChecks
, DifferentRepaymentPhoneNumbers
, MaxNumberOfDifferentFarmersMadePaymentsWithPhoneNumber as DifferentFarmersMadePaymentsWithPhoneNumber
, NumberOfTimesPhoneNumberRegistered
, NumberOfCalls

from DATADRIVENINVESTIGATION_ClientOverview
Where SeasonName not in ('2018','2018, Long Rain','2018, Msimu Masika','2018, Short Rain','2018A','2018B','2019','2019, Long Rain','2019, Msimu Masika','2019, Short Rain','2019A','2019B','2020','2020, Long Rain','2020, Short Rain','2020A','2020B','SEASON_DO_NOT_USE_FOMM_TRIAL', '2020, Long Rain', '2020', '2020A', '2020, Short Rain', '2020, Msimu Masika', '2020B')

and DistrictName not in ('KENYASTAFF', 'KENYA STAFF', 'OAFDuka', 'OAF Duka', 'RRTP-ShopsKayonza')