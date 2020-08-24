select O.OrgName, OrgAmount + IndAmount as EffTotal
from OrgDonations O, PersonDonations P
group by O.OrgName, OrgAmount + IndAMount
order by O.OrgName;