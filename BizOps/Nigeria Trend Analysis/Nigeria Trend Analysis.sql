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
SELECT DimClientID as ClientID, SUM(Amount) AS RepaymentSum
	FROM v_RepaymentBasic
	WHERE 
		RepaidDate BETWEEN '2022-03-04' AND @EndDate AND
		CountryName = 'Nigeria' AND
		SeasonName = '2022, Long Rain'
	GROUP BY DimClientID
;

-- Create a temporary table with Last Year Repayment data from when repayment started to where we are at IN 2021
IF OBJECT_ID('tempdb..#LST') IS NOT NULL
DROP TABLE #LST;


	CREATE TABLE #LST (
		-- Name and format the columns in the table
		FarmerID int,
		TtlRpdSum int
	)
	-- Now add values into the table
	INSERT INTO #LST (FarmerID,TtlRpdSum)
	SELECT 
	DimClientID as FarmerID, SUM(Amount) AS TtlRpdSum
		FROM v_RepaymentBasic
		WHERE 
			RepaidDate BETWEEN '2021-03-16' AND DATEADD(year, -1, @EndDate)  AND
			CountryName = 'Nigeria' AND
			SeasonName = '2021, Long Rain'
		GROUP BY DimClientID
-------------------------------------------------------
IF OBJECT_ID('tempdb..#LSTC') IS NOT NULL
DROP TABLE #LSTC;

--- Calculate the total credit for each client from last year
	CREATE TABLE #LSTC (
		FarmerIDs int,
		TtlCrdtSum int
	)
	-- Now add values into the table
	INSERT INTO #LSTC (FarmerIDS,TtlCrdtSum)
	SELECT 
	DimClientID as FarmerIDs, SUM(TotalCredit) AS tlCrdtSum
		FROM v_ClientSalesBizops
		WHERE 
			CountryName = 'Nigeria' AND
			Season = '2021, Long Rain'
		GROUP BY DimClientID
;

----------------------------------------------------------------
-- 2020 Repayment Data
IF OBJECT_ID('tempdb..#LST20') IS NOT NULL
DROP TABLE #LST20;


	CREATE TABLE #LST20 (
		-- Name and format the columns in the table
		FarmerID20 int,
		TtlRpdSum20 int
	)
	-- Now add values into the table
	INSERT INTO #LST20 (FarmerID20,TtlRpdSum20)
	SELECT 
	DimClientID as FarmerID20, SUM(Amount) AS TtlRpdSum20
		FROM v_RepaymentBasic
		WHERE 
			RepaidDate BETWEEN '2020-01-05' AND DATEADD(year, -2, @EndDate)  AND
			CountryName = 'Nigeria' AND
			SeasonName = '2020, Long Rain'
		GROUP BY DimClientID


---------------------------------------------------------------
--- Calculate the total credit for each client from 2020
IF OBJECT_ID('tempdb..#LSCL20') IS NOT NULL
DROP TABLE #LSCL20;

--- Calculate total clients 2020
	CREATE TABLE #LSCL20 (
		DimSiteID20 int,
		TtlClientSum20 int,
		Finishers2020 int,
	)
	-- Now add values into the table
	INSERT INTO #LSCL20 (DimSiteID20,TtlClientSum20, Finishers2020)
	SELECT 
	DimSiteID as SiteIDs20, Count(DimClientID) AS TtlClientSum20, Sum(Case when PercentRepaid = 1 then 1 else 0 end) as Finshers2020
		FROM v_ClientSalesBizops
		WHERE 
			CountryName = 'Nigeria' AND
			Season = '2020, Long Rain'
	
		GROUP BY DimSiteID

-------------------------------------------------
-- Calculate the total credit for each client from last year
IF OBJECT_ID('tempdb..#LSTC20') IS NOT NULL
DROP TABLE #LSTC20;

--- Calculate the total credit for each client from last year
	CREATE TABLE #LSTC20 (
		FarmerIDs20 int,
		TtlCrdtSum20 int
	)
	-- Now add values into the table
	INSERT INTO #LSTC20 (FarmerIDS20,TtlCrdtSum20)
	SELECT 
	DimClientID as FarmerIDs20, SUM(TotalCredit) AS tlCrdtSum20
		FROM v_ClientSalesBizops
		WHERE 
			CountryName = 'Nigeria' AND
			Season = '2020, Long Rain'
		GROUP BY DimClientID
;

-------------------------------------------------

IF OBJECT_ID('tempdb..#LSCL') IS NOT NULL
DROP TABLE #LSCL;

--- Calculate the total credit for each client from last year
	CREATE TABLE #LSCL (
		DimSiteID int,
		TtlClientSum int
	)
	-- Now add values into the table
	INSERT INTO #LSCL (DimSiteID,TtlClientSum)
	SELECT 
	DimSiteID as SiteIDs, Count(DimClientID) AS TtlClientSum
		FROM v_ClientSalesBizops
		WHERE 
			CountryName = 'Nigeria' AND
			Season = '2021, Long Rain'
		GROUP BY DimSiteID



SELECT 
	SC.CountryName
	,SC.SectorName
	,SC.DistrictName
	,SC.SiteName
	,SC.GroupName
	,SC.DimClientID
	,SC.FirstName
	,SC.LastName
	,SC.TotalCredit 
	,SC.TotalRepaid 
	,SC.PercentRepaid
	,ISNULL(VR.RepaymentSum,0) as AMOUNT
	,ISNULL(LST.TtlRpdSum,0) AS TtlRpdLastYR
     ,ISNULL(LSTC.TtlCrdtSum,0) AS LstYrCredt
	 ,Case When ISNULL(LST.TtlRpdSum,0) >0 and ISNULL(LST.TtlRpdSum,0)>= ISNULL(LSTC.TtlCrdtSum,0) then 1 else 0 end as [2021Finishers] 
	 ,Case when ISNULL(VR.RepaymentSum,0)>= TotalCredit then 1 else 0 end as Finishers
	 ,LSCL.TtlClientSum
	 ,LSCL20.TtlClientSum20
	 ,LSCL20.Finishers2020
	 ,LSTC20.TtlCrdtSum20
	 ,LST20.TtlRpdSum20



FROM v_ClientSalesBizops AS SC
	LEFT JOIN #VR AS VR ON
		SC.DimClientID=VR.ClientID	
		LEFT JOIN #LST AS LST ON
		SC.DimClientID=LST.FarmerID
        LEFT JOIN #LSTC AS LSTC ON
		SC.DimClientID=LSTC.FarmerIDs
		Left join #LSCL AS LSCL ON
		SC.DimSiteID=LSCL.DimSiteID
		Left Join #LSTC20 AS LSTC20 ON
		SC.DimClientID=LSTC20.FarmerIDs20
		Left Join #LSCL20 AS LSCL20 ON 
		SC.DimClientID=LSCL20.TtlClientSum20
		Left Join #LST20 as LST20 ON
		SC.DimClientID=LST20.FarmerID20
		
		
WHERE 
	SC.CountryName = 'Nigeria'
	AND SC.Season = '2022, Long Rain' 
                AND SC.TotalCredit > 0


ORDER BY SC.DistrictName, SC.SiteName ASC
-- Drop tables	
DROP TABLE #VR;
DROP TABLE #LST;
DROP TABLE #LSTC;
Drop Table #LSCL;
Drop Table #LSTC20;
Drop Table #LSCL20;