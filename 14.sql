select Team.TeamName, Type, NumOfVolunteers, TeamHours, First || ' ' || Last LeaderName, ReportTo, MostRecentReport 
from Team, Person, (select TeamName, count(PID) NumOfVolunteers from serve group by TeamName) getVols, 
(select TeamName, Sum(HrsWorked) TeamHours from serve group by TeamName) getHrs, 
(select TeamName, First || ' ' || Last ReportTo from Team, Person where Team.PID = Person.PID) ReportToConversion, 
(select TeamName, max(ReportDate) MostRecentReport from Report group by TeamName) getRecentReport 
where Leader = Person.PID 
and Team.TeamName = getVols.TeamName 
and getVols.TeamName = getHrs.TeamName 
and getHrs.TeamName = ReportToConversion.TeamName 
and ReportToConversion.TeamName = getRecentReport.TeamName
Order by Type, TeamName;