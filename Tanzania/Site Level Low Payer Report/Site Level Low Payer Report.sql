Use RosterDataWarehouse;

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
		CountryName = 'Tanzania' AND
		Season = '2019, Msimu Masika' AND
		DistrictName = @District
	GROUP BY DimSiteID
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
	,SPR.SiteRepaymentPCT

FROM v_ClientSalesBizops AS SC	
left JOIN #SPR AS SPR ON
	    SC.DimSiteID=SPR.SiteID


where CountryName = 'Tanzania'
and Season = '2019, Msimu Masika'
and DistrictName= @District
and TotalCredit >0
and TotalRepaid >0
and PercentRepaid < @PercentRepaid


DROP TABLE #SPR;