Use RosterDataWarehouse;

select 
CountryName
, SeasonName
, DistrictName
, RepaymentTypeName
, RevenueCategoryName
, RepaidDate
, Concat(CountryName, SeasonName, DistrictName) as UniqueID
, Sum(Amount) TotalAmount
, Count(ReceiptID) As TotalTransactions

FROM v_RepaymentBasic

WHERE OperationalYear > 2020


group by CountryName, SeasonName, DistrictName, RepaymentTypeName, RevenueCategoryName, RepaidDate

ORDER BY CountryName, SeasonName, DistrictName, RepaymentTypeName, RevenueCategoryName, RepaidDate ASC