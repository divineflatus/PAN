Update donation
Set amount = amount * 2
Where orgname IS NOT NULL 
and dondate IN ( select Max(dondate) from donation where orgname IS NOT NULL group by OrgName);