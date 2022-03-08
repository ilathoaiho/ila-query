-- Train
select T1.LeadId, T1.SourceIdLasted AS [Source], T1.KidAge, T1.CenterId AS [Center], T1.ProductId, 
	T1.SellerId AS SellerId, T2.HC_MONTHTIMEWORKING AS [MonthTimeWorking],
	CASE WHEN T1.IsSale = 1 THEN DATEDIFF(DAY, T1.AssignToSellerDate, T1.ContractSignedDate)
		ELSE DATEDIFF(DAY, T1.AssignToSellerDate, ISNULL(T1.UnsuccessfulDate, T1.ModifiedDate))
	END AS DayWorking,
	COUNT(T3.ActivityId) AS NoActions,
	T1.IsSale
from [CRM.View_Need] T1
inner join ViewHeadCount T2
	on T1.SellerCode = T2.PERSONNELNUMBER
		and T2.HC_MONTHPERIOD = MONTH(T1.AssignToSellerDate)
		and T2.HC_YEARPERIOD = YEAR(T1.AssignToSellerDate)
inner join CRM.CRM.Activity T3
	on T1.SellerId = T3.CreatedBy
		and T1.KidProgramId = T3.KidProgramId
where T1.KidAge IS NOT NULL
	and (T1.StatusId = 310
	or (T1.StatusId = 400 and IsSale = 1))
group by T1.LeadId, T1.SourceIdLasted, T1.KidAge, T1.CenterId, T1.ProductId, T1.SellerId, T2.HC_MONTHTIMEWORKING,
	CASE WHEN T1.IsSale = 1 THEN DATEDIFF(DAY, T1.AssignToSellerDate, T1.ContractSignedDate)
		ELSE DATEDIFF(DAY, T1.AssignToSellerDate, ISNULL(T1.UnsuccessfulDate, T1.ModifiedDate))
	END
	, T1.IsSale

-- Test
select T1.LeadId, T1.SourceIdLasted AS [Source], T1.KidAge, T1.CenterId AS [Center], T1.ProductId, 
	T1.SellerId AS SellerId, T2.HC_MONTHTIMEWORKING AS [MonthTimeWorking],
	DATEDIFF(DAY, T1.AssignToSellerDate, T1.ModifiedDate) AS DayWorking,
	COUNT(T3.ActivityId) AS NoActions
from [CRM.View_Need] T1
inner join ViewHeadCount T2
	on T1.SellerCode = T2.PERSONNELNUMBER
		and T2.HC_MONTHPERIOD = MONTH(T1.AssignToSellerDate)
		and T2.HC_YEARPERIOD = YEAR(T1.AssignToSellerDate)
inner join CRM.CRM.Activity T3
	on T1.SellerId = T3.CreatedBy
		and T1.KidProgramId = T3.KidProgramId
where T1.KidAge IS NOT NULL
	and T1.StatusId IN (210, 330, 340, 360, 300, 350)
group by T1.LeadId, T1.SourceIdLasted, T1.KidAge, T1.CenterId, T1.ProductId, T1.SellerId, T2.HC_MONTHTIMEWORKING,
	DATEDIFF(DAY, T1.AssignToSellerDate, T1.ModifiedDate)