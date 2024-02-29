select 
AccountNumber as GlobalClientID,
ContractReference,
SeasonName,
CountryName,
RegionName,
Null as DistrictName,
case when SeasonName = 'LR2021' then 215
else null end as DimSeasonID,
case when countryname = 'Kenya' then 1 else null end as DimCountryID,
Null as DimRegionID,
TotalCredit as CreditLocal,
2021 as OperationalYear,
StartDate as Enrollmentdate, 
Null as BundleUnitPrice,
Null as SAPItemcode,
Null as FirstRepaymentdate

from [reporting].[sample_v_TupandePerformance]