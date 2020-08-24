select Last, Salary, MarStatus, NumDrives, count(distinct teamName) NumTeams 
from q17 natural join team
group by Last, Salary, MarStatus;