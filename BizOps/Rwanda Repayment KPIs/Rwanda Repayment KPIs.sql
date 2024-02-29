Use RosterDataWarehouse;
IF OBJECT_ID('tempdb..#VR') IS NOT NULL
DROP TABLE #VR;


	-- Create a table with summarized Repayment data at the client level from VR
	CREATE TABLE #VR (
		-- Name and format the columns in the table
		ClientID int,
		RepaymentSum int
	)
	-- Now add values into the table
	INSERT INTO #VR (ClientID,RepaymentSum)
	SELECT 
	DimClientID as ClientID, SUM(Amount) AS RepaymentSum
		FROM v_RepaymentBasic
		WHERE 
			RepaidDate BETWEEN @WeekStart AND @WeekEnd AND
			CountryName = 'Rwanda'
			and OperationalYear = 2022
		GROUP BY DimClientID
	;

IF OBJECT_ID('tempdb..#Week1') IS NOT NULL
DROP TABLE #Week1;

-- Week One as first repayment
	-- Create a table with summarized Repayment data at the client level from VR
	CREATE TABLE #Week1 (
		-- Name and format the columns in the table
		ClientID int,
		RepaymentSum1 int
	)
	-- Now add values into the table 
	INSERT INTO #Week1 (ClientID,RepaymentSum1)
	SELECT 
	DimClientID as ClientID,  Sum(Amount) as RepaymentSum1
		FROM v_RepaymentBasic
		WHERE CountryName = 'Rwanda'
		and OperationalYear = 2022
			and RepaidDate BETWEEN @DintRepaySince
        AND @DintRepayLastDay 

		GROUP BY DimClientID
	;


IF OBJECT_ID('tempdb..#Month') IS NOT NULL
DROP TABLE #Month;

-- Week One as first repayment
	-- Create a table with summarized Repayment data at the client level from VR
	CREATE TABLE #Month (
		-- Name and format the columns in the table
		ClientID int,
		RepaymentSum2 int
	)
	-- Now add values into the table 
	INSERT INTO #Month (ClientID,RepaymentSum2)
	SELECT 
	DimClientID as ClientID,  Sum(Amount) as RepaymentSum2
		FROM v_RepaymentBasic
		WHERE CountryName = 'Rwanda'
		and OperationalYear = 2022
			and RepaidDate BETWEEN @MonthStart
        AND @MonthEnd

		GROUP BY DimClientID
	;

IF OBJECT_ID('tempdb..#Year') IS NOT NULL
DROP TABLE #Year;

-- Week One as first repayment
	-- Create a table with summarized Repayment data at the client level from VR
	CREATE TABLE #Year (
		-- Name and format the columns in the table
		ClientID int,
		RepaymentSum3 int
	)
	-- Now add values into the table 
	INSERT INTO #Year (ClientID,RepaymentSum3)
	SELECT 
	DimClientID as ClientID,  Sum(Amount) as RepaymentSum3
		FROM v_RepaymentBasic
		WHERE CountryName = 'Rwanda'
		and OperationalYear = 2022
			and RepaidDate BETWEEN '2022-01-01'
        AND @NonFinisherDate

		GROUP BY DimClientID
	;


Select
SC.CountryName,
SC.[FO Name],
sc.RegionName, 
SC.DistrictName, 
SC.SiteName, 
SC.TotalRepaid
,Case When ISNULL(Year1.RepaymentSum3,0) / SC.TotalCredit <1 then 1 else 0 end as NonFinisherBy
,ISNULL(Week1.RepaymentSum1,0) as Amount2
,Case when Week1.RepaymentSum1 IS NULL THEN 1 ELSE 0 END AS DintPaySinceMonth
,sc.Globalid
,ISNULL(VR.RepaymentSum,0) as Repaidthisweek
,CASE WHEN VR.RepaymentSum IS NULL THEN 0 ELSE 1 END as WeeklyParticipants
,CASE WHEN Month1.RepaymentSum2 IS NULL THEN 0 ELSE 1 END as MonthlyParticipants
,Case when sc.TotalRemaining >10000 then 1 else 0 end as Remaining10k
,Case when SC.PercentRepaid >=.50 then 1 else 0 end as HealthPath

FROM v_ClientSalesBizops AS SC
	LEFT JOIN #VR AS VR ON
	SC.DimClientID=VR.ClientID
	LEFT JOIN #Week1 AS Week1 ON
	SC.DimClientID=Week1.ClientID
    LEFT JOIN #Month AS Month1 ON
	SC.DimClientID=Month1.ClientID
    LEFT JOIN #Year AS Year1 ON
	SC.DimClientID=Year1.ClientID
	where SC.CountryName = 'Rwanda'
    and SC.Season = '2022'
   and SC.TotalCredit >0

   Order by Sc.DistrictName ASC

DROP TABLE #VR;
Drop Table #Week1;
Drop Table #Month;
Drop Table #Year;