declare @tmp as Table (TypeInDB varchar(50), ColumnNameInExcel varchar(50),ColumnNameIn_BudgetKPI varchar(50))
declare @Type varchar(20 ),@ColumnNameInExcel varchar(50),@ColumnNameIn_BudgetKPI varchar(50)
declare @sql nvarchar(max)

--DELETE [Budget.KPIPlan] WHERE YearPeriod = 2020

insert into @tmp
select type,ColumnNameInExcel,ColumnNameIn_BudgetKPI
from DBLive.dbo.[Budget.KPIPlan_Mapping]
where type not in( 'Ave Std/cl','Enrolment')

select top 1 @Type = TypeInDB, @ColumnNameInExcel = ColumnNameInExcel,@ColumnNameIn_BudgetKPI= ColumnNameIn_BudgetKPI
From @tmp
While @@rowCount >0
Begin

Set @sql = 'INSERT INTO [Budget.KPIPlan](DateKey,DateFull,CenterID,YearPeriod,MonthPeriod,VirtualKey,Type,KPIType,KPITypeName,ClassGroup, Channel,['+@ColumnNameIn_BudgetKPI+'])
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[EA]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[EY]
UNION ALL
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[Maths]
UNION ALL
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[TPR]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[OLA]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[Corporate]
union all
select DISTINCT DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'''+@Type+''', ''Q1 Reforecast'' as KPIType,''Plan2022'' as KPITypeName,ClassGroup, ''Digital'',['+@ColumnNameInExcel +']
from [DBLIVE].[dbo].[ILO]
'
--Print @sql
exec sp_executesql @sql
delete @tmp where TypeInDB  = @type
select top 1 @Type = TypeInDB, @ColumnNameInExcel = ColumnNameInExcel,@ColumnNameIn_BudgetKPI= ColumnNameIn_BudgetKPI
From @tmp
End -- wHILE

-- Enrolment and Ave Std/cl
INSERT INTO [Budget.KPIPlan](DateKey,DateFull,CenterID,YearPeriod,MonthPeriod,VirtualKey,Type,KPIType,KPITypeName,ClassGroup, Channel,AVGSTDCLASS,Enrollment)
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[EA]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[EY]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[Maths]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[TPR]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[OLA]
union all
select DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[Corporate]

union all
select DISTINCT DateKey,Convert(DAte,DateFull),CenterID,YearPeriod,MonthPeriod,VirtualKey,'Enrolment', 'Q1 Reforecast' as KPIType,'Plan2022' as KPITypeName,ClassGroup, 'Digital',[AvgStdClass],[Enrollment]
from [DBLIVE].[dbo].[ILO]

UPDATE [Budget.KPIPlan] SET TeachingHrs = isnull(TeachingHrs,0.0000000000000)
, Lost  =  isnull(Lost,0.0000000000000)
, AVGSTDCLASS  =  isnull(AVGSTDCLASS, 0.0000000000000)
, [StdHrs/Std/month]  =  isnull([StdHrs/Std/month],0.0000000000000)
, NEWSALES  =  isnull(NEWSALES,0.0000000000000)
, NewEnrollment  =  isnull(NewEnrollment, 0.0000000000000)
, REVSTDHR  =  ISNULL(REVSTDHR, 0.0000000000000)
, Enrollment  =  ISNULL(Enrollment, 0.0000000000000)
, RETURNING  =  ISNULL(RETURNING, 0.0000000000000)
, FINISH  =  ISNULL(FINISH, 0.0000000000000)
, NOOFCLASS  =  ISNULL(NOOFCLASS, 0.0000000000000)
, REVENUE  =  ISNULL(REVENUE, 0.0000000000000)
WHERE YearPeriod = 2022;