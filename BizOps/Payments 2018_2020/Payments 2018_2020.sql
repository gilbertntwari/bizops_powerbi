select CountryName, SeasonName, RegionName, DistrictName, 
SectorName, SiteName, GroupName, FirstName, 
LastName, OAFID, AccountNumber, Amount, ReceiptID, CreatedDate, RepaymentTypeName

from v_RepaymentConfidential
Where CountryName <> 'Kenya'
and SeasonName IN ('2020, Long Rain',
'2019, Short Rain',
'2018, Short Rain',
'2019B',
'2018, Long Rain',
'2018, Msimu Masika',
'2019, Long Rain',
'2020A',
'2019A',
'2020, Short Rain',
'2018B',
'2018A',
'2018',
'2020',
'2019',
'2019, Msimu Masika',
'2020, Msimu Masika',
'2020B')