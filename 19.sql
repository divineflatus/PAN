select First, Last, to_char(WorkDate, 'MON') as Month, sum(Hrs) as TotalHours, TeamCount 
from Person natural join (select * from DailyHrs where WorkDate between (add_months(to_date(sysdate), -3)) and to_date(sysdate) order by PID, WorkDate) natural join
(select PID, count(distinct TeamName) as TeamCount from Serve group by PID)
group by First, Last, to_char(WorkDate, 'MON'), TeamCount
order by Last, First, to_char(WorkDate, 'MON');