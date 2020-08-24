select c.First ClientFirst, C.MI ClientMI, C.Last ClientLast, TeamName, V.First VolFirst, V.MI VolMI, V.Last VolLast, DateJoined VolDateJoin
from teamAssignment c, voldetails v
where c.teamname = v.teamname
and c.gender <> v.gender
order by C.Last, C.First, TeamName, v.Last, v.First;