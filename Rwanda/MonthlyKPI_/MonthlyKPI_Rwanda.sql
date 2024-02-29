Use RosterDataWarehouse;
-- First Query for repayment for the first week
IF OBJECT_ID('tempdb..#VR1') IS NOT NULL
DROP TABLE #VR1;

-- Create a table with summarized Repayment data at the client level from VR
CREATE TABLE #VR1 (
	-- Name and format the columns in the table
	ClientID int,
	RepaymentSum int
)
-- Now add values into the table
INSERT INTO #VR1 (ClientID,RepaymentSum)
SELECT DimClientID as ClientID, SUM(Amount) AS RepaymentSum
	FROM v_RepaymentBasic
	WHERE 
	-- Add dates @Week1StartDate AND @Week1EndDate 
		RepaidDate BETWEEN @WeekOneStartDate AND @WeekOneEndDate AND 
		CountryName = 'Rwanda' AND
		SeasonName =  @Season
AND Amount >0
	GROUP BY DimClientID
;


-- Second Query for repayment for the whole month
IF OBJECT_ID('tempdb..#VR2') IS NOT NULL
DROP TABLE #VR2;

-- Create a table with summarized Repayment data at the client level from VR
CREATE TABLE #VR2 (
	-- Name and format the columns in the table
	ClientID int,
	RepaymentSum int
)
-- Now add values into the table
INSERT INTO #VR2 (ClientID,RepaymentSum)
SELECT DimClientID as ClientID, SUM(Amount) AS RepaymentSum
	FROM v_RepaymentBasic
	WHERE 
	-- Add dates @MonthStartDate AND @MonthEndDate 
		RepaidDate BETWEEN @MonthStartDate AND @MonthEndDate AND 
		CountryName = 'Rwanda' AND
		SeasonName =  @Season
AND Amount >0
	GROUP BY DimClientID
;



IF OBJECT_ID('tempdb..#GC') IS NOT NULL
DROP TABLE #GC;

CREATE TABLE #GC (
	-- Name and format the columns in the table
	GroupID int,
	GP int
)
INSERT INTO #GC (GroupID,GP)
SELECT DimGroupID as GroupID,  Count(Distinct DimGroupID) AS GP
	FROM v_ClientSalesBizOps
	WHERE CountryName = 'Rwanda' AND
		Season = @Season
		and TotalCredit > 0
	and TotalRepaid > 0
	
	GROUP BY DimGroupID
;

SELECT 
	SC.CountryName
	,SC.DistrictName
	,SC.DimDistrictID
	,SC.SiteName
                   ,SC.DimSiteID
	,SC.GroupName
    ,SC.DimGroupID
	,SC.DimClientID
	,SC.FirstName
	,SC.LastName
	,SC.TotalCredit 
	,SC.TotalRepaid 
	,CONCAT(DistrictName,SiteName) as [site.id]
	,case when SC.PercentRepaid >= .50 then 1 else 0 end as [50Percent]
	,case when SC.PercentRepaid >= .75 then 1 else 0 end as [70Percent]
	,case when SC.PercentRepaid >= 1 then 1 else 0 end as [100Percent]
	-- add heathy path parameter @Stagnation Parameter
	,CASE WHEN SC.LastRepaymentDate < @StagnatedDate and SC.PercentRepaid <1 THEN 1 else 0 end as Stagnated 
	,ISNULL(VR1.RepaymentSum,0) as AMOUNT
	,CASE WHEN VR1.RepaymentSum IS NULL THEN 0 ELSE 1 END as count
	,ISNULL(VR2.RepaymentSum,0) as AMOUNT2
	,CASE WHEN VR2.RepaymentSum IS NULL THEN 0 ELSE 1 END as count2
                   ,GC.GP




FROM v_ClientSalesBizops AS SC
	LEFT JOIN #VR1 AS VR1 ON
		SC.DimClientID=VR1.ClientID	
		left JOIN #VR2 AS VR2 ON
		SC.DimClientID=VR2.ClientID	
		left Join #GC AS GC ON
		SC.DimGroupID = GC.GroupID	
		
WHERE 
	SC.CountryName = 'Rwanda'
	AND SC.Season = @Season
                AND SC.TotalCredit > 0



ORDER BY SC.DistrictName, SC.SiteName ASC
	

-- Finally, drop the temp table since we don't need it anymore
DROP TABLE #VR1;
DROP TABLE #VR2;
DROP TABLE #GC;