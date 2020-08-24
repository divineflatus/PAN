select Last, First, MI, Street, City, State, ZIP
from care natural join person, employee, (select max(monsal) sal from employee) e, team t
Where employee.MonSal = e.sal
and t.pid = employee.pid
and care.TeamName = t.TeamName
order by Last, First;