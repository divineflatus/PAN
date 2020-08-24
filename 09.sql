select OrgName, Type, Sum(Amount) TotalAmt, count(DID) NumDonations
from Organization natural join Donation
group by OrgName, Type
order by Type;