select Last, First, MI, DocFirst, DocLast, DocPhone 
from Person, Client 
where Person.PID = Client.PID 
order by Last, First;