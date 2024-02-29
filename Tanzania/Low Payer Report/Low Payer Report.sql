CREATE TABLE #GPR (
	-- Name and format the columns in the table
	GroupID int,
	GroupRepaymentPCT float
)
-- Now add values into the table
INSERT INTO #GPR (GroupID,GroupRepaymentPCT)
SELECT DimGroupID as GroupID, case when sum(totalcredit) <> 0 then SUM(TotalRepaid) / SUM(Totalcredit) End AS GroupRepaymentPCT
	FROM v_ClientSalesBizOps
	WHERE 
		CountryName = 'Tanzania' AND
		Season = '2019, Msimu Masika' AND
		DistrictName = @District
	GROUP BY DimGroupID

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
	,GPR.GroupRepaymentPCT

	FROM v_ClientSalesBizops AS SC
	LEFT JOIN #GPR AS GPR ON
	SC.DimGroupID=GPR.GroupID
WHERE CountryName = 'Tanzania'
	AND Season = @Season
 	AND DistrictName = @District
    AND TotalCredit > 0
	AND PercentRepaid < @PercentRepaid
	

ORDER BY SiteName, GroupName ASC

DROP TABLE #GPR;