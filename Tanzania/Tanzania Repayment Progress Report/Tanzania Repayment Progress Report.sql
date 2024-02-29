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
		RepaidDate BETWEEN DATEADD(WEEK,-1,@EndDate) AND @EndDate AND
		CountryName = 'Tanzania' AND
		SeasonName = @Season
	GROUP BY DimClientID
;

IF OBJECT_ID('tempdb..#MTH') IS NOT NULL
DROP TABLE #MTH;

-- Create a table with summarized Repayment data at the client level from VR
CREATE TABLE #MTH (
	-- Name and format the columns in the table
	ID int,
	SumM int
)
-- Now add values into the table
INSERT INTO #MTH (ID,SumM)
SELECT DimClientID as ID, SUM(Amount) AS RepaymentSum
	FROM v_RepaymentBasic
	WHERE 
		RepaidDate BETWEEN DATEADD(Month,-1,@EndDate) AND @EndDate AND
		CountryName = 'Tanzania' AND
		SeasonName = @Season
	GROUP BY DimClientID
;


IF OBJECT_ID('tempdb..#SR') IS NOT NULL
DROP TABLE #SR;

CREATE TABLE #SR (
	-- Name and format the columns in the table
	SiteID int,
	SiteRepaymentPCT float
)
-- Now add values into the table
INSERT INTO #SR (SiteID,SiteRepaymentPCT)
SELECT DimSiteID as SiteID, case when sum(totalcredit) <> 0 then SUM(TotalRepaid) / SUM(Totalcredit) END AS SiteRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Tanzania' AND
		Season = @Season
	GROUP BY DimSiteID
;

IF OBJECT_ID('tempdb..#DR') IS NOT NULL
DROP TABLE #DR;

CREATE TABLE #DR (
	-- Name and format the columns in the table
	DistrictID int,
	DistrictRepaymentPCT float
)
-- Now add values into the table
INSERT INTO #DR (DistrictID,DistrictRepaymentPCT)
SELECT DimDistrictID as DistrictID, case when sum(totalcredit) <> 0 then SUM(TotalRepaid) / SUM(Totalcredit) END AS DistrictRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Tanzania' AND
		Season = @Season
	GROUP BY DimDistrictID
;


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
			RepaidDate BETWEEN '2017-07-01' AND DATEADD(year, -1, @EndDate)  AND
			CountryName = 'Tanzania' AND
			SeasonName = @PreviousSeason 
		GROUP BY DimClientID

IF OBJECT_ID('tempdb..#LSTC') IS NOT NULL
DROP TABLE #LSTC;


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
			CountryName = 'Tanzania' AND
			Season = @PreviousSeason
		GROUP BY DimClientID

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
                ,SC.LastRepaymentDate
                ,CASE WHEN SC.PercentRepaid < @HealthyPath THEN 1 ELSE 0 END as BelowHealthyPath
                ,CASE WHEN SC.LastRepaymentDate < DATEADD(Month,-1,@EndDate) THEN CASE WHEN SC.PercentRepaid < 1 THEN 1 ELSE 0 end ELSE 0 END AS StrugglingClients
	,ISNULL(VR.RepaymentSum,0) as AMOUNT
	,CASE WHEN VR.RepaymentSum IS NULL THEN 0 ELSE 1 END as count
	,SR.SiteRepaymentPCT
	,DR.DistrictRepaymentPCT
	,ISNULL(MTH.SumM,0) as AMOUNT4Wks
	,CASE WHEN MTH.SumM IS NULL THEN SC.TotalRepaid ELSE (SC.TotalRepaid - MTH.SumM) END AS Repaid4WKS
                ,dense_RANK () OVER (ORDER BY DR.DistrictRepaymentPCT DESC) AS DistrictRank
	,dense_RANK () OVER (PARTITION BY DR.DistrictID ORDER BY SR.SiteRepaymentPCT DESC) AS SiteRank
	,ISNULL(LST.TtlRpdSum,0) AS TtlRpdLastYR
                ,ISNULL(LSTC.TtlCrdtSum,0) AS LstYrCredt


FROM v_ClientSalesBizops AS SC
	LEFT JOIN #VR AS VR ON
		SC.DimClientID=VR.ClientID	
		LEFT JOIN #MTH AS MTH ON
		SC.DimClientID=MTH.ID
		LEFT JOIN #LST AS LST ON
		SC.DimClientID=LST.FarmerID
                                LEFT JOIN #LSTC AS LSTC ON
		SC.DimClientID=LSTC.FarmerIDs
		left JOIN #SR AS SR ON
	    SC.DimSiteID=SR.SiteID
		left JOIN #DR AS DR ON
	    SC.DimDistrictID=DR.DistrictID
		
		
WHERE 
	SC.CountryName = 'Tanzania'
	AND SC.Season = @Season 
                AND SC.TotalCredit > 0
                AND SC.DistrictName <> 'Arusha Rural'
                AND SC.DistrictName <> 'Meru'
                AND SC.SiteName <> 'Warehouse'
                AND SC.SiteName <> 'Ware house'
                AND SC.Sitename <> 'Warehouse Mbozi'

ORDER BY SC.DistrictName, SC.SiteName ASC
	
DROP TABLE #VR;
DROP TABLE #SR;
DROP TABLE #DR;
DROP TABLE #MTH;
DROP TABLE #LST;
DROP TABLE #LSTC;