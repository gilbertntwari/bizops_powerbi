Select Distinct CountryName
, SeasonName
, Max(AuditDateCreated) AS [Last Updated Time]
, CONVERT(varchar(8)
, Max(AuditDateCreated)
, 3) as [Last Updated Date]
, CONVERT(varchar(8)
, GetDate()
, 3) as TodayDate
from v_RepaymentBasic
Where OperationalYear > 2020
and SeasonName <> 'SEASON_DO_NOT_USE_FOMM_TRIAL'
Group By  CountryName, SeasonName
Order by CountryName, SeasonName ASC
