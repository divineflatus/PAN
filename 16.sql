Select DriveTitle, EndDate, last, Emptitle
from Drive natural join (select DriveTitle, sum(Amount) DriveTotal from Donation where DriveTitle IS NOT NULL group by DriveTitle), employee natural join person
where Drivetotal <= goal 
and PID = lead
order by goal desc;