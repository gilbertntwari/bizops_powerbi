Select Distinct CountryName
, Season
, Max(AuditDateCreated) AS [Last Updated Time]
, CONVERT(varchar(8)
, Max(AuditDateCreated)
, 3) as [Last Updated Date]
, CONVERT(varchar(8)
, GetDate()
, 3) as TodayDate
from v_ClientSalesBizOps
Where OperationalYear > 2020
and Season <> 'SEASON_DO_NOT_USE_FOMM_TRIAL'
Group By  CountryName, Season
Order by CountryName, Season ASC