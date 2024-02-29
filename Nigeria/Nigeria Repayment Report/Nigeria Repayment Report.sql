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
		CountryName = 'Nigeria' AND
		SeasonName = '2019, Long Rain'
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
		CountryName = 'Nigeria' AND
		Season = '2019, Long Rain'
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
		CountryName = 'Nigeria' AND
		Season = '2019, Long Rain' 
	GROUP BY DimDistrictID

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
                ,CASE WHEN SC.PercentRepaid = 1 THEN 1 ELSE 0 END AS Finishers
                ,CASE WHEN SC.LastRepaymentDate < DATEADD(WEEK,-6,@EndDate) THEN CASE WHEN SC.PercentRepaid < @HealthyPath THEN 1 ELSE 0 end ELSE 0 END AS StrugglingClients
	,ISNULL(VR.RepaymentSum,0) as AMOUNT
	,CASE WHEN VR.RepaymentSum IS NULL THEN 0 ELSE 1 END as count
	,SR.SiteRepaymentPCT
	,DR.DistrictRepaymentPCT

FROM v_ClientSalesBizops AS SC
	LEFT JOIN #VR AS VR ON
		SC.DimClientID=VR.ClientID	
		left JOIN #SR AS SR ON
	    SC.DimSiteID=SR.SiteID
		left JOIN #DR AS DR ON
	    SC.DimDistrictID=DR.DistrictID	
		
WHERE 
	SC.CountryName = 'Nigeria'
	AND SC.Season = '2019, Long Rain'
                AND SC.TotalCredit > 0

ORDER BY SC.DistrictName, SC.SiteName ASC
	

-- Finally, drop the temp table since we don't need it anymore
DROP TABLE #VR;
DROP TABLE #SR;
DROP TABLE #DR;

