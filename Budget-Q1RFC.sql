/****** Script for SelectTopNRows command from SSMS  ******/
SELECT COUNT(1)
  FROM [DBLIVE].[dbo].[BudgetQ1RFC2022]
  WHERE Centers = '800'

INSERT INTO [Budget.CostDashBoardPlan]
SELECT T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date) AS DateFull, T2.BudgetCenter AS CenterID,
	SUM(T1.Amount) AS Amount, CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int) AS [MonthPeriod], LEFT(T1.DateKey, 4) AS [YearPeriod], T3.DashboardCostVirtualKey, 'Q1 Reforecast' AS BudgetType,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END AS DataAreaId--, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses
FROM [DBLIVE].[dbo].[BudgetQ1RFC2022] T1
INNER JOIN [Dim.InventSite] T2
	ON T2.ERPCenter = CASE WHEN LEN(Centers) = 3 THEN '000' + Centers
						WHEN LEN(Centers) = 4 THEN '00' + Centers
						WHEN LEN(Centers) = 5 THEN '0' + Centers
					  ELSE Centers
					  END
		AND T2.ERPCenter NOT IN ('000800') --, '321000', '221000', '421000')
INNER JOIN [Dim.CostVirtualKey] T3
	ON T1.MainAccount LIKE T3.AccountNo + '%'
		AND T1.Expenses = T3.AccountingCode
		AND T1.Projects = CASE WHEN T3.ProjectCode IS NULL OR T3.ProjectCode = '' THEN 'I0.00'
							ELSE T3.ProjectCode
							END
		AND T1.Expenses <> 'E0.000'
		AND T3.isActive = 1
--WHERE T3.DashboardCostVirtualKey LIKE 'E1.001SA016%'
GROUP BY T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date), CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int), T2.BudgetCenter
	, LEFT(T1.DateKey, 4), T3.DashboardCostVirtualKey,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END

UNION ALL

SELECT T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date) AS DateFull, T2.BudgetCenter AS CenterID,
	SUM(T1.Amount) AS Amount, CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int) AS [MonthPeriod], LEFT(T1.DateKey, 4) AS [YearPeriod], T3.DashboardCostVirtualKey, 'Q1 Reforecast' AS BudgetType,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END AS DataAreaId--, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses
FROM [DBLIVE].[dbo].[BudgetQ1RFC2022] T1
INNER JOIN [Dim.InventSite] T2
	ON T2.AccountCenter = T1.Departments
		AND T2.ERPCenter = CASE WHEN LEN(Centers) = 3 THEN '000' + Centers
						WHEN LEN(Centers) = 4 THEN '00' + Centers
						WHEN LEN(Centers) = 5 THEN '0' + Centers
					  ELSE Centers
					  END
		AND T2.ERPCenter IN ('000800') --, '321000', '221000', '421000')
INNER JOIN [Dim.CostVirtualKey] T3
	ON T1.MainAccount LIKE T3.AccountNo + '%'
		AND T1.Expenses = T3.AccountingCode
		AND T1.Projects = CASE WHEN T3.ProjectCode IS NULL OR T3.ProjectCode = '' THEN 'I0.00'
							ELSE T3.ProjectCode
							END
		AND T1.Expenses <> 'E0.000'
		AND T3.isActive = 1
--WHERE T3.DashboardCostVirtualKey LIKE 'E1.001SA016%'
--	AND T1.Centers = '800'
--	AND T2.SITEID IS NULL
GROUP BY T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date), CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int), T2.BudgetCenter
	, LEFT(T1.DateKey, 4), T3.DashboardCostVirtualKey,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END
--	, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses

UNION ALL 

SELECT T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date) AS DateFull, T2.BudgetCenter AS CenterID,
	SUM(T1.Amount) AS Amount, CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int) AS [MonthPeriod], LEFT(T1.DateKey, 4) AS [YearPeriod], T3.DashboardCostVirtualKey, 'Q1 Reforecast' AS BudgetType,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END AS DataAreaId--, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses
FROM [DBLIVE].[dbo].[BudgetQ1RFC2022] T1
INNER JOIN [Dim.InventSite] T2
	ON T2.AccountCenter = T1.Departments
		AND T2.ERPCenter = T2.AccountCenter
		AND T1.Centers = '800'
INNER JOIN [Dim.CostVirtualKey] T3
	ON T1.MainAccount LIKE T3.AccountNo + '%'
		AND T1.Expenses = T3.AccountingCode
		AND T1.Projects = CASE WHEN T3.ProjectCode IS NULL OR T3.ProjectCode = '' THEN 'I0.00'
							ELSE T3.ProjectCode
							END
		AND T1.Expenses <> 'E0.000'
		AND T3.isActive = 1
WHERE T3.DashboardCostVirtualKey LIKE 'E1.005SA066'
	AND T1.MainAccount IN (627100, 641100, 642100)
GROUP BY T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date), CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int), T2.BudgetCenter
	, LEFT(T1.DateKey, 4), T3.DashboardCostVirtualKey,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END
	--, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses

UNION ALL

INSERT INTO [Budget.CostDashBoardPlan]
SELECT T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date) AS DateFull, T2.BudgetCenter AS CenterID,
	SUM(T1.Amount) AS Amount, CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int) AS [MonthPeriod], LEFT(T1.DateKey, 4) AS [YearPeriod], T3.DashboardCostVirtualKey, 'Q1 Reforecast' AS BudgetType,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END AS DataAreaId--, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses
FROM [DBLIVE].[dbo].[BudgetQ1RFC2022] T1
INNER JOIN [Dim.InventSite] T2
	ON  T2.ERPCenter = CASE WHEN LEN(Centers) = 3 THEN '000' + Centers
						WHEN LEN(Centers) = 4 THEN '00' + Centers
						WHEN LEN(Centers) = 5 THEN '0' + Centers
					  ELSE Centers
					  END
		AND T2.ERPCenter NOT IN ('321000', '000800')
INNER JOIN [Dim.CostVirtualKey] T3
	ON T1.MainAccount LIKE T3.AccountNo + '%'
		AND T1.Projects = CASE WHEN T3.ProjectCode IS NULL OR T3.ProjectCode = '' THEN 'I0.00'
							ELSE T3.ProjectCode
							END
		AND T1.Expenses = 'E0.000'
		AND T3.isActive = 1
		AND T3.RefCode LIKE 'OI%'
--WHERE T3.DashboardCostVirtualKey LIKE 'E1.001SA016%'
--	AND T1.Centers = '800'
--	AND T2.SITEID IS NULL
GROUP BY T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date), CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int), T2.BudgetCenter
	, LEFT(T1.DateKey, 4), T3.DashboardCostVirtualKey,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END
--	, T1.Centers, T1.Departments, T1.Expenses, T1.Products, T1.Projects, T1.Expenses


INSERT INTO [dbo].[Budget.RevenueDashboardPlan]
SELECT T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date) AS DateFull, T2.BudgetCenter AS CenterID,
	SUM(T1.Amount), CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int) AS [MonthPeriod], LEFT(T1.DateKey, 4) AS [YearPeriod], T3.CostVirtualKey, 'Q1 Reforecast' AS BudgetType,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END AS DataAreaId
FROM [DBLIVE].[dbo].[BudgetQ1RFC2022] T1
INNER JOIN [Dim.InventSite] T2
	ON T2.ERPCenter = CASE WHEN LEN(Centers) = 3 THEN '000' + Centers
						WHEN LEN(Centers) = 4 THEN '00' + Centers
						WHEN LEN(Centers) = 5 THEN '0' + Centers
					  ELSE Centers
					  END
		AND T2.ERPCenter NOT IN ('000800', '321000', '221000', '421000')
INNER JOIN [Dim.RevenueAndCostVirtualKey] T3
	ON T1.MainAccount LIKE '5%'
		AND T1.Expenses = 'E0.000'
		AND T3.AccountingCode = CASE WHEN T1.Products = 'P2.001' THEN 'P2.101,P2.104'
							   WHEN T1.Products = 'P1.001' THEN 'P1.001-P1.004'
							   ELSE T1.Products
						  END
GROUP BY T1.DateKey, CAST(CAST(T1.DateKey AS varchar(8)) AS date), CAST(LEFT(RIGHT(T1.DateKey, 4), 2) AS int), T2.BudgetCenter
	, LEFT(T1.DateKey, 4), T3.CostVirtualKey,
	CASE WHEN T1.Products LIKE 'P2.2%' THEN 'ola'
		 WHEN T1.Products LIKE 'P9.0%' THEN 'iMaths'
		 WHEN T1.Products LIKE 'S%' THEN 'iloa'
		 WHEN T1.Products = 'P0.000' THEN 'HQ'
		 ELSE 'ilav'
	END


SELECT CASE WHEN LEN(Centers) = 3 THEN '000' + Centers
			WHEN LEN(Centers) = 4 THEN '00' + Centers
			WHEN LEN(Centers) = 5 THEN '0' + Centers
		ELSE Centers
		END AS Centers
  FROM [DBLIVE].[dbo].[BudgetQ1RFC2022]


select sum(Budget)
from View_DashboardRevenueAndCost
where FiscalYear = 2022
	and BudgetType = 'Q1 Reforecast'
	and SubCost = 'COST OF SALES'