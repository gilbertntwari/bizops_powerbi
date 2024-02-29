IF OBJECT_ID('tempdb..#tempAllInputs') IS NOT NULL 
BEGIN 
    DROP TABLE #tempAllInputs
END;

IF OBJECT_ID('tempdb..#tempAllAgric') IS NOT NULL 
BEGIN 
    DROP TABLE #tempAllAgric
END;

IF OBJECT_ID('tempdb..#tempAllAddOns') IS NOT NULL 
BEGIN 
    DROP TABLE #tempAllAddOns
END;



select 
  DimCountryId, DimDistrictID, CreditCycleName, a.DimSeasonID, c.OperationalYear, 
  DATEFROMPARTS(c.OperationalYear, 1, 1) As OperationalYearDate, 
  DimClientId, 
  Count(Distinct b.InputCategory) As InputCategoryCount,
  Sum(InputCredit) As InputCredit
into
  #tempAllInputs
from 
	ClientOrdersDetail a inner join OAF_SHARED_DIMENSIONS.dbo.DimInputs b on a.DimInputID = b.InputId
	Inner join OAF_SHARED_DIMENSIONS.dbo.DimSeasons c on a.DimSeasonID = c.SeasonID and a.DimCountryID = c.CountryId
	inner join OAF_SHARED_DIMENSIONS.dbo.DimCreditCycles d on a.DimCreditCycleId = d.CreditCycleID
Where
   DimCountryID = 2 and c.OperationalYear >= 2018 and BundleStatus = 'Delivered'
Group By
    DimCountryId, DimDistrictID, CreditCycleName, a.DimSeasonID, c.OperationalYear,DimClientId


select 
  DimCountryId, DimDistrictID, CreditCycleName, a.DimSeasonID, c.OperationalYear, 
  DATEFROMPARTS(c.OperationalYear, 1, 1) As OperationalYearDate, 
  DimClientId, Count(Distinct b.InputCategory) As InputCategoryCount,
  Sum(InputCredit) As InputCredit
into
	#tempAllAgric
from 
	ClientOrdersDetail a inner join OAF_SHARED_DIMENSIONS.dbo.DimInputs b on a.DimInputID = b.InputId
	Inner join OAF_SHARED_DIMENSIONS.dbo.DimSeasons c on a.DimSeasonID = c.SeasonID and a.DimCountryID = c.CountryId
	inner join OAF_SHARED_DIMENSIONS.dbo.DimCreditCycles d on a.DimCreditCycleId = d.CreditCycleID
Where
   DimCountryID = 2 and c.OperationalYear >= 2018 and ( b.InputCategory like '%seed%' or b.InputCategory like '%fertilizer%' )
   and BundleStatus = 'Delivered'
Group By
   DimCountryId, DimDistrictID, CreditCycleName, a.DimSeasonID, c.OperationalYear,DimClientId


select 
  DimCountryId, DimDistrictID, CreditCycleName, a.DimSeasonID, c.OperationalYear, 
  DATEFROMPARTS(c.OperationalYear, 1, 1) As OperationalYearDate, 
  DimClientId, 
  Count(Distinct b.InputCategory) As InputCategoryCount,
  Sum(InputCredit) As InputCredit
into
	#tempAllAddOns
from 
	ClientOrdersDetail a inner join OAF_SHARED_DIMENSIONS.dbo.DimInputs b on a.DimInputID = b.InputId
	Inner join OAF_SHARED_DIMENSIONS.dbo.DimSeasons c on a.DimSeasonID = c.SeasonID and a.DimCountryID = c.CountryId
	inner join OAF_SHARED_DIMENSIONS.dbo.DimCreditCycles d on a.DimCreditCycleId = d.CreditCycleID
Where
   DimCountryID = 2 and c.OperationalYear >= 2018 and BundleStatus = 'Delivered'
  and ( b.InputCategory not like '%seed%' and b.InputCategory not like '%fertilizer%' )
Group By
     DimCountryId, DimDistrictID, CreditCycleName, a.DimSeasonID, c.OperationalYear,DimClientId


select 
	a.DimCountryId, a.DimDistrictID, a.CreditCycleName, a.DimSeasonID, a.OperationalYear, a.OperationalYearDate, a.DimClientId, 
	a.InputCategoryCount As AllInputs, isnull(b.InputCategoryCount,0) AgricInputs, isnull(c.InputCategoryCount,0) AddOnsInputs,
	case when a.InputCategoryCount = isnull(b.InputCategoryCount,0) then 1 else 0 end as AgricInputOnly,
	case when a.InputCategoryCount = isnull(c.InputCategoryCount,0) then 1 else 0 end as AddOnsInputOnly,
    b.InputCredit as AgricInputCredit,
	c.InputCredit as AddOnsCredit
from
	#tempAllInputs a left outer join #tempAllAgric b on a.DimDistrictID = b.DimDistrictID and a.DimSeasonID = b.DimSeasonID and a.DimClientId = b.DimClientId
	left outer join #tempAllAddOns c on a.DimDistrictID = c.DimDistrictID and a.DimSeasonID = c.DimSeasonID and a.DimClientId = c.DimClientId
