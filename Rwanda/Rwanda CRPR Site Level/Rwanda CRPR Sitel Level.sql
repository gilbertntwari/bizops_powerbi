IF OBJECT_ID('tempdb..#VR') IS NOT NULL
DROP TABLE #VR;

--DECLARE
--	@Country nvarchar(10) = 'Tanzania',
--	@Season nvarchar(20) = '2019, Msimu Masika',
--	@District nvarchar(20) = 'Meru',
--	@StartDate date = '2019-04-01', -- April 1
--	@EndDate date = '2019-04-03'; -- April 3

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
			RepaidDate BETWEEN @StartDate AND @EndDate AND
			CountryName = 'Rwanda' AND
			SeasonName = @Season AND
			DistrictName = @District
		GROUP BY DimClientID
	;


IF OBJECT_ID('tempdb..#SPR') IS NOT NULL
DROP TABLE #SPR;

CREATE TABLE #SPR (
	-- Name and format the columns in the table
	SiteID int,
	SiteRepaymentPCT float
)
-- Now add values into the table
INSERT INTO #SPR (SiteID,SiteRepaymentPCT)
SELECT DimSiteID as SiteID, SUM(TotalRepaid) / SUM(Totalcredit) AS SiteRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Rwanda' AND
		Season = @Season AND
		DistrictName = @District
                                and TotalRepaid > 0
	GROUP BY DimSiteID
;

IF OBJECT_ID('tempdb..#GPR') IS NOT NULL
DROP TABLE #GPR;

CREATE TABLE #GPR (
	-- Name and format the columns in the table
	GroupID int,
	GroupRepaymentPCT float
)
-- Now add values into the table
INSERT INTO #GPR (GroupID,GroupRepaymentPCT)
SELECT DimGroupID as GroupID, SUM(TotalRepaid) / SUM(Totalcredit) AS GroupRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Rwanda' AND
		Season = @Season AND
		DistrictName = @District
                                and TotalRepaid > 0
	GROUP BY DimGroupID
;

Select 
	SC.DistrictName
	,SC.CountryName
	,SC.SiteName
	,SC.GroupName
	,SC.DimClientID
	,SC.GlobalId
	,SC.OAFID
	,SC.FirstName
	,SC.LastName
	,SC.TotalCredit
	,SC.TotalRepaid
	,SC.TotalRemaining
	,SC.PercentRepaid
	,SC.LastRepaymentDate	
	,SC.IsGroupLeader
                ,SC.AccountNumber
	,ISNULL(VR.RepaymentSum,0) as AMOUNT
	,CASE WHEN VR.RepaymentSum IS NULL THEN 0 ELSE 1 END as count
	,SPR.SiteRepaymentPCT
	,GPR.GroupRepaymentPCT



FROM v_ClientSalesBizops AS SC
	LEFT JOIN #VR AS VR ON
		SC.DimClientID=VR.ClientID		
	left JOIN #SPR AS SPR ON
	    SC.DimSiteID=SPR.SiteID
	left join #GPR as GPR ON
		SC.DimGroupID=GPR.GroupID


where CountryName = 'Rwanda'
and Season = @Season
and DistrictName= @District
and SiteName = @Site
and TotalCredit >0

DROP TABLE #VR;
DROP TABLE #SPR;
DROP TABLE #GPR;