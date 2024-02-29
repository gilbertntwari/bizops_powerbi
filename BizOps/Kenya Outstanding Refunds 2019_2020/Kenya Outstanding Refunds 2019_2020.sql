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
			CountryName = 'Kenya' AND
			OperationalYear IN (2019, 2020, 2021) AND
			RevenueCategoryName = 'Bonus'

		GROUP BY DimClientID
	;



SELECT
SC.CountryName, 
	SC.SeasonName, 
	SC.DistrictName, 
	SC.SiteName, 
	Case When SC.TotalRepaid_IncludingOverpayments-SC.CreditLocal >0 then SC.TotalRepaid_IncludingOverpayments-CreditLocal else 0 end as Overpayments,
	VR.RepaymentSum as CreditAdjustment

FROM v_ClientSales AS SC
LEFT JOIN #VR AS VR ON
SC.DimClientID=VR.ClientID
WHERE SC.CountryName = 'Kenya'
and SC.OperationalYear in (2019, 2020, 2021)
and SC.TotalRepaid_IncludingOverpayments-CreditLocal > 0
