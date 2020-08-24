delete from Volunteer
where PID in (select PID from TotalHrs where TotalHrs = (select min(TotalHrs) from TotalHrs));