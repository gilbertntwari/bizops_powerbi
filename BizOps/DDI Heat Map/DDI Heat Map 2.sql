Select Distinct DistrictName
from DATADRIVENINVESTIGATION_ClientOverview
where CountryName = 'Kenya'
and SeasonName in ('2021, Long Rain', '2022, Long Rain', '2022, Short Rain')
order by DistrictName ASC