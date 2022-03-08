select T1.REGISTRATIONID
from [Data.Registration] T1
where MONTH(T1.REGISTRATIONDATE) = 2
	and YEAR(T1.REGISTRATIONDATE) = 2022
	and T1.REGISTRATIONSTATUS = 2
	and T1.STUDENTTYPEID IN (5, 6)
	and T1.REGISTRATIONID NOT IN
		(SELECT ContractNo
		 FROM [CRM.View_Need]
		 WHERE MONTH(ContractSignedDate) = 2
			AND YEAR(ContractSignedDate) = 2022
			AND IsSale = 1
			AND StatusId < 500)