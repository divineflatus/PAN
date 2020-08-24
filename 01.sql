select First, Mi, Last, Title, Street, City, State, Zip
from Person
where MailList = 1
order by State, City, Last, First, MI desc;