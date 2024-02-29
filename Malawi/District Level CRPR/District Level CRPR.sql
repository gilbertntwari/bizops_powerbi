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
			RepaidDate BETWEEN @StartDate AND @EndDate AND
			CountryName = 'Malawi' AND
			SeasonName = @Season AND
			DistrictName = @District AND
                                                ReceiptID <> 'OPR_Transfer_LR2019'
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
SELECT DimSiteID as SiteID, Case When Sum(TotalCredit) <> 0 then SUM(TotalRepaid) / SUM(Totalcredit) else 0 End AS SiteRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Malawi' AND
		Season = @Season AND
		DistrictName = @District
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
SELECT DimGroupID as GroupID, Case When Sum(TotalCredit) <> 0 then SUM(TotalRepaid) / SUM(Totalcredit) else 0 end AS GroupRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Malawi' AND
		Season = @Season AND
		DistrictName = @District
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


where CountryName = 'Malawi'
and Season = @Season
and DistrictName= @District
and TotalCredit >0

DROP TABLE #VR;
DROP TABLE #SPR;
DROP TABLE #GPR;