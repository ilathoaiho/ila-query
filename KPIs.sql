-- Current month
SELECT 'Current month' AS KPIs, T2.FiscalYear AS FiscalY, T2.MonthNumberOfYear AS [Month], T3.ILAPRODUCTGROUPID AS Product,
	T4.ILADASHBOARDCENTERID AS [ILA Centres], CAST(COUNT(DISTINCT T5.RegistrationID) AS FLOAT) / COUNT(DISTINCT T1.RegistrationID) AS Actual
	--, COUNT(DISTINCT T1.RegistrationID), COUNT(DISTINCT T5.RegistrationID)
FROM [Data.Registration] T1
LEFT JOIN [Data.RevenueDaily] T5
	ON T1.RegistrationID = T5.REGISTRATIONID
INNER JOIN [Dim.Date] T2
	ON T1.DateKey = T2.DateKey
INNER JOIN [Dim.ProjTable] T3
	ON T1.ProjectID = T3.PROJID
INNER JOIN [Dim.InventSite] T4
	ON T1.CenterID = T4.SITEID
WHERE T1.REGISTRATIONSTATUS = 2
	AND T1.STUDENTTYPEID IN (0, 5, 6)
	AND T2.FiscalYear = 2022
	AND T2.MonthNumberOfYear = 1
GROUP BY T2.FiscalYear, T2.MonthNumberOfYear, T3.ILAPRODUCTGROUPID, T4.ILADASHBOARDCENTERID

UNION ALL
-- Next month
SELECT 'Next month' AS KPIs, T2.FiscalYear AS FiscalY, T2.MonthNumberOfYear AS [Month], T3.ILAPRODUCTGROUPID AS Product,
	T4.ILADASHBOARDCENTERID AS [ILA Centres], CAST(COUNT(DISTINCT T5.RegistrationID) AS FLOAT) / COUNT(DISTINCT T1.RegistrationID) AS Actual
	--, COUNT(DISTINCT T1.RegistrationID), COUNT(DISTINCT T5.RegistrationID)
FROM [Data.Registration] T1
INNER JOIN [Dim.Date] T2
	ON T1.DateKey = T2.DateKey
INNER JOIN [Dim.ProjTable] T3
	ON T1.ProjectID = T3.PROJID
INNER JOIN [Dim.InventSite] T4
	ON T1.CenterID = T4.SITEID
LEFT JOIN [Data.DailyForeCast] T5
	ON T1.RegistrationID = T5.REGISTRATIONID
		AND MONTH(T5.DateFull) = 2
		AND YEAR(T5.DateFull) = 2022
		AND NOT EXISTS (SELECT 1
						FROM [Data.RevenueDaily]
						WHERE T1.REGISTRATIONID = RegistrationID)
WHERE T1.REGISTRATIONSTATUS = 2
	AND T1.STUDENTTYPEID IN (0, 5, 6)
	AND T2.FiscalYear = 2022
	AND T2.MonthNumberOfYear = 1
	--AND NOT EXISTS (SELECT 1
	--				FROM [Data.RevenueDaily]
	--				WHERE T1.REGISTRATIONID = RegistrationID)
GROUP BY T2.FiscalYear, T2.MonthNumberOfYear, T3.ILAPRODUCTGROUPID, T4.ILADASHBOARDCENTERID

UNION ALL
-- 3rd month
SELECT '3rd month' AS KPIs, T2.FiscalYear AS FiscalY, T2.MonthNumberOfYear AS [Month], T3.ILAPRODUCTGROUPID AS Product,
	T4.ILADASHBOARDCENTERID AS [ILA Centres], CAST(COUNT(DISTINCT T5.RegistrationID) AS FLOAT) / COUNT(DISTINCT T1.RegistrationID) AS Actual
	--, COUNT(DISTINCT T1.RegistrationID), COUNT(DISTINCT T5.RegistrationID)
FROM [Data.Registration] T1
INNER JOIN [Dim.Date] T2
	ON T1.DateKey = T2.DateKey
INNER JOIN [Dim.ProjTable] T3
	ON T1.ProjectID = T3.PROJID
INNER JOIN [Dim.InventSite] T4
	ON T1.CenterID = T4.SITEID
LEFT JOIN [Data.DailyForeCast] T5
	ON T1.RegistrationID = T5.REGISTRATIONID
		AND MONTH(T5.DateFull) = 3
		AND YEAR(T5.DateFull) = 2022
		AND NOT EXISTS (SELECT 1
						FROM [Data.RevenueDaily]
						WHERE T1.REGISTRATIONID = RegistrationID)
		AND NOT EXISTS (SELECT 1
						FROM [Data.DailyForeCast]
						WHERE T1.REGISTRATIONID = RegistrationID
							AND MONTH(DateFull) = 2
							AND YEAR(DateFull) = 2022)
WHERE T1.REGISTRATIONSTATUS = 2
	AND T1.STUDENTTYPEID IN (0, 5, 6)
	AND T2.FiscalYear = 2022
	AND T2.MonthNumberOfYear = 1
	--AND NOT EXISTS (SELECT 1
	--				FROM [Data.RevenueDaily]
	--				WHERE T1.REGISTRATIONID = RegistrationID)
GROUP BY T2.FiscalYear, T2.MonthNumberOfYear, T3.ILAPRODUCTGROUPID, T4.ILADASHBOARDCENTERID

UNION ALL
-- New enrol/ NS-RT
SELECT 'New enrol/ NS-RT' AS KPIs, T2.FiscalYear AS FiscalY, T2.MonthNumberOfYear AS [Month], T3.ILAPRODUCTGROUPID AS Product,
	T4.ILADASHBOARDCENTERID AS [ILA Centres], COUNT(DISTINCT T1.RegistrationID) AS Actual
FROM [Data.RevenueDaily] T1
INNER JOIN [Dim.Date] T2
	ON T1.DateKey = T2.DateKey
INNER JOIN [Dim.ProjTable] T3
	ON T1.ProjectID = T3.PROJID
INNER JOIN [Dim.InventSite] T4
	ON T1.CenterID = T4.SITEID
INNER JOIN [Data.Registration] T5
	ON T1.RegistrationID = T5.REGISTRATIONID
		AND T5.REGISTRATIONSTATUS = 2
		AND T5.STUDENTTYPEID IN (0, 5, 6)
		AND T5.DATEKEY < '20220101'
WHERE T2.FiscalYear = 2022
	AND T2.MonthNumberOfYear = 1
	AND NOT EXISTS (SELECT 1
					FROM [Data.RevenueDaily]
					WHERE T1.REGISTRATIONID = RegistrationID
						AND DateKey < '20220101')
GROUP BY T2.FiscalYear, T2.MonthNumberOfYear, T3.ILAPRODUCTGROUPID, T4.ILADASHBOARDCENTERID
