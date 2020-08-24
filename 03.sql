select TeamName, First, Last, DateJoined 
from Person natural join (select TeamName, PID from Serve natural join (select TeamName from Care where PID = &ClientID) natural join (select First, Last, PID from Person)) natural join (select * from Volunteer) 
order by DateJoined;