SELECT 
	CI.CountryName
	,CI.DistrictName
	,CI.SiteName
	,CI.GroupName
	,CI.FirstName
	,CI.LastName
	,CI.OAFID 
	,CI.DimClientID
	,CI.BundleName
	,CI.InputName
	,CI.InputCredit
	,CI.InputQuantity
	,CI.AccountNumber
	,SI.ClientSignature
                ,SI.MimeType



FROM v_ClientInputs as CI
LEFT JOIN v_SeasonClientSignatures AS SI ON
		CI.DimClientId=SI.DimClientID

where CI.CountryName = 'Malawi'
and CI.SeasonName = @Season
and CI.DistrictName= @District
and CI.InputCredit > 0
and DroppedClient = 0

ORDER BY SiteName,GroupName,OAFID,BundleName DESC 