select 
	DimCountryId
	, DimDistrictID
	, DimSeasonID
	, OperationalYear
	, DATEFROMPARTS(OperationalYear, 1, 1) As OperationalYearDate
	, Count(Distinct DimClientId) As ClientCount
from 
	ClientOrdersDetail a inner join OAF_SHARED_DIMENSIONS.dbo.DimInputs b on a.DimInputID = b.InputId
	Inner join OAF_SHARED_DIMENSIONS.dbo.DimSeasons c on a.DimSeasonID = c.SeasonID and a.DimCountryID = c.CountryId
Where
   DimCountryID = 2 and c.OperationalYear >= 2018 and ( b.InputCategory like '%seed%' or b.InputCategory like '%fertilizer%' )
Group By
    DimCountryId, DimDistrictID, DimSeasonID, OperationalYear