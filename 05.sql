SELECT Last, First, MI, Title, Street, City, State, Zip, Profession,
SUM(Amount) DonationTotal, Count(PID) NumDonations,
CASE isAnonymous
     WHEN 1 THEN 'Wishes to remain Anonymous'
     ELSE 'Does not wish to remain Anonymous'
END AS Anonymity
from (person natural join client) natural join (donor natural join donation)
group by Last, First, MI, Title, Street, City, State, ZIP, Profession, isanonymous
order by Count(PID);