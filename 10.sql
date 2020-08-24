Select First, Last, totalDon, CPhone 
from( (totaldonations natural join person) natural join contact)
where isPrimary = 1
and totalDon in (select max(totalDon) from totalDonations);