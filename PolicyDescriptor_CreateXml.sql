-- This script creates the PolicyDescriptor.xml file, for loading into MarkLogic RSCert
-- The top section provides some attributes that are not in RSDM:
--   Sector:   RealEstate, Specialty, Museum
--   Category: Select, Premier and numerous other descriptors for a string of policies
--   PacCode2: Addition descriptor for a string of policies
-- This script should be run when new policies get issued, which typically occurs at anniversary dates.
-- Most of the anniversary dates are September 1 and March 1, but there are other months as well.  
-- So, we might as well run this monthly, and see whether anything has been added. 
-- When new policies come on (or changes were made, which is less frequent), then we'll also need to add a line to the cte below, indicating Category/Sector/PacCode2.

-- The bottom section queries RSDM for policies, and joins in the cte.  If something shows up as Unknown, we should discuss with Jon to find out that attribute value.
-- We might want to preserve the previous version, so we can better understand what changes and when.
WITH cteA AS (
	SELECT *
	FROM (VALUES
		('1234166','RealEstate','RealEstate','')
		,('1234167','RealEstate','RealEstate','')
		,('1235734','RealEstate','RealEstate','')
		,('1235735','RealEstate','RealEstate','')
		,('1410877','RealEstate','RealEstate','')
		,('1410886','RealEstate','RealEstate','')
		,('1743916','Specialty','Select','Select Lead Umb')
		,('1743917','Specialty','Select','Select $25ml x $75ml')
		,('1744099','RealEstate','RE UMXS','POP & CAP $10ml')
		,('1744100','RealEstate','RE UMXS','$25ml x $100ml')
		,('1744101','Museum','NFP Museum','')
		,('1744104','Museum','For Profit Museum','')
		,('1744113','Specialty','UM Gross/Net','Fulcrum Lead Umb - Full Commission')
		,('1744114','Specialty','UM Gross/Net','Fulcrum Lead Umb - Net Commission')
		,('1744300','Specialty','Quarterly aggregate, XS','Fulcrum $25M x $175M')
		,('1745119','Museum','NFP Museum Net Commission','')
		,('1942897','Museum','NFP Museum','')
		,('1942898','RealEstate','RE UMXS','POP & CAP $10ml')
		,('1942911','Specialty','Select','Select Lead Umb')
		,('1943128','Specialty','Select','Select $25ml x $75ml')
		,('1943217','RealEstate','RE UMXS','$25ml x $100ml')
		,('1943600','Specialty','HLI','HLI')
		,('1944601','Specialty','Premier','Premier $25ml x $175ml')
		,('1944602','Specialty','Premier','Premier $25ml x $75ml')
		,('1945035','Museum','For Profit Museum','')
		,('2250689','Specialty','Premier','Premier $15ml x $25ml')
		,('2250690','Specialty','Premier','Premier $25ml x $175ml')
		,('2258415','Specialty','Select','Select Lead Umb')
		,('2259894','RealEstate','RE UMXS','POP & CAP $10ml')
		,('2259983','Specialty','Select','Select $25ml x $75ml')
		,('2260084','Specialty','UM Gross/Net','Fulcrum Lead Umb - Full Commission')
		,('2260085','Specialty','UM Gross/Net','Fulcrum Lead Umb - Net Commission')
		,('2260086','Museum','NFP Museum','')
		,('2260087','Museum','For Profit Museum','')
		,('2260088','Museum','NFP Museum Net Commission','')
		,('2260173','RealEstate','RE UMXS','$25ml x $100ml')
		,('2260198','Specialty','Quarterly aggregate, XS','Fulcrum $25M x $175M')
		,('2386960','RealEstate','RealEstate','')
		,('2386961','RealEstate','RealEstate','')
		,('2387949','Museum','NFP Museum','')
		,('2388452','RealEstate','RealEstate','')
		,('2388453','RealEstate','RealEstate','')
		,('2388455','Museum','NFP Museum','')
		,('2648421','Specialty','Premier','Premier $15ml x $25ml')
		,('2648422','Specialty','Premier','Premier $25ml x $175ml')
		,('2664580','Specialty','Select','Select Lead Umb')
		,('2664599','RealEstate','RE UMXS','POP & CAP $10ml')
		,('2664644','Specialty','Premier','Premier $15ml x $10ml')
		,('2664683','Specialty','UM Gross/Net','GA Lead Net')
		,('2664684','Specialty','UM Gross/Net','GA Lead Gross')
		,('2664685','Museum','Museum','')
		,('2664687','Museum','Museum','')
		,('2665196','Specialty','Select','Select $25ml x $75ml')
		,('3305246','Specialty','Select','Select Lead Umb')
		,('3305247','Specialty','Select','Select $25ml x $75ml')
		,('3305282','RealEstate','RE UMXS','POP & CAP $10ml')
		,('3305283','RealEstate','RE UMXS','$25ml x $100ml')
		,('3305295','Museum','NFP Museum','')
		,('3305297','Museum','For Profit Museum','')
		,('3306711','Specialty','HLI','HLI')
		,('3306847','RealEstate','RE NYBB','')
		,('3717708','Specialty','Premier','Premier $25ml x $175ml')
		,('3717709','Specialty','Premier','Premier $25ml x $75ml')
		,('3718488','Specialty','Select','Select Lead Umb')
		,('3718490','Specialty','Select','Select $25ml x $75ml')
		,('3842794','RealEstate','RE UMXS','POP & CAP $10ml')
		,('3842795','RealEstate','RE UMXS','$25ml x $100ml')
		,('3842874','Museum','NFP Museum','')
		,('3842875','Museum','For Profit Museum','')
		,('3843221','RealEstate','RE NYBB','')
		,('4433561','RealEstate','RealEstate','')
		,('4433562','Museum','NFP Museum','')
		,('4957221','Specialty','Premier','Premier $25ml x $75ml')
		,('4957222','Specialty','Premier','Premier $25ml x $175ml')
		,('4957250','Specialty','HLI','HLI')
		,('4958943','Specialty','Select','Select Lead Umb')
		,('4958944','Specialty','Select','Select $25ml x $75ml')
		,('4959365','RealEstate','RE UMXS','POP & CAP $10ml')
		,('4959368','RealEstate','RE UMXS','$25ml x $100ml')
		,('4959369','RealEstate','RE NYBB','')
		,('4959370','Museum','NFP Museum','')
		,('4959374','Museum','For Profit Museum','')
		,('5279928','RealEstate','RealEstate','')
		,('5279929','RealEstate','RealEstate','')
		,('5575106','RealEstate','RealEstate','')
		,('5599216','RealEstate','RealEstate','')
		,('5599790','RealEstate','RealEstate','')
		,('5611514','RealEstate','RealEstate','')
		,('5612283','RealEstate','RealEstate','')
		,('5612284','RealEstate','RealEstate','')
		,('5613240','RealEstate','RealEstate','')
		,('7856088','RealEstate','RealEstate','')
		,('9833266','Specialty','UM Gross/Net','Fulcrum Lead Umb - Full Commission')
		,('9833593','Specialty','Quarterly aggregate, XS','Fulcrum $25M x $175M')
		,('9925321','RealEstate','RealEstate','')
		,('9925325','RealEstate','RealEstate','')
		,('9925987','RealEstate','RealEstate','')
		,('9925991','RealEstate','RealEstate','')
		,('9952003','Specialty','UM Gross/Net','Fulcrum Lead Umb - Net Commission')
		,('9953326','Specialty','Premier','Premier $25ml x $175ml')
		,('9953327','Specialty','Premier','Premier $25ml x $75ml')
		-- 2/27/2020 new
		,('2665933','RealEstate','RE UMXS','$25ml x $100ml')

		-- 2/26/2020
		-- These next 4 policies fit the DPG filter, and in RSDM thus in FDW.
		-- However, we don't have a bordereau folder for them, so no RSCert premium.
		-- I have guessed the Sector/Category below based on similarity to the Anniversary date of other policies, but it is just a guess.
		-- Once we know more, we should fill this in.
		,('2664701','Specialty','Quarterly aggregate, XS','Fulcrum $25M x $175M')
		,('2665087','Specialty','Premier','Premier $15ml x $10ml')
		,('1744105','RealEstate','RE UMXS','POP & CAP $10ml')
		,('2259895','RealEstate','RE UMXS','POP & CAP $10ml')
	) x (PolicyNumber, Sector, Category, PacCode2)
)
SELECT ps.PolicyNumber, ps.PolicySymbol, ps.PolicyStatus, ps.PolicyEffectiveDate, ps.PolicyExpirationDate
	, YEAR(ps.PolicyEffectiveDate) AS EffYr
	, RIGHT(CONVERT(VARCHAR(20), ps.PolicyEffectiveDate, 120), 5) AS EffMD
	, ps.PolicyInsuredName, ps.PolicyProducerName
	, COALESCE(cteA.Sector, 'Unknown') AS Sector
	, COALESCE(cteA.Category, 'Unknown') AS Category
	, COALESCE(ps.PolicyPacCode, 'Unknown') AS PacCode
	, COALESCE(cteA.PacCode2, 'Unknown') AS PacCode2
FROM dbo.StgDimPolicySymbol ps
LEFT JOIN cteA ON cteA.PolicyNumber = ps.PolicyNumber
WHERE (
	ps.PolicyProducerCode = '793925'
	OR (
		ps.PolicyProducerCode = '107049'
		AND ps.PolicyInsuredName LIKE 'DISTINGUISHED PROP%'
		)
)
AND ps.PolicyStatus <> 'CANCELLED'
ORDER BY ps.PolicyNumber 
FOR XML PATH, ROOT('rows');
