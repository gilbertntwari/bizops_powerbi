uSE Rosterdatawarehouse;

Select 
VR.FirstName, 
	VR.LastName,
                VR.OAFID,
	VR.RepaidDate, 
	VR.SeasonName, 
	VR.Amount, 
	VR.ReceiptID,
	vr.RepaymentPhoneNumber,
	VR.AccountNumber,
	VR.RegionName,
	VR.DistrictName,
	VR.SiteName,
	VR.GroupName,
	SC.TotalCredit,
	SC.TotalRepaid,
	SC.TotalRemaining,
	SC.[FO Name],
	SC.GroupLeader,
	SC.PercentRepaid,
	DATEDIFF(DAY,getdate(), sc.LastRepaymentDate) as Days
from [v_RepaymentConfidential] as VR
Left Join v_ClientSalesBizOps as SC
ON VR.OAFID =  SC.OAFID

where VR.CountryName = 'Tanzania'
and VR.SeasonName = '2021, Msimu Masika'
AND VR.DistrictName = @District
and VR.OAFID = @OAFID
and SC.OAFID = @OAFID
AND sc.DistrictName = @District
AND sc.Season = '2021, Msimu Masika'