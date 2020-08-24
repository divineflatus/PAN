select Type, Priority from (select Type, Priority, count(Type) "NUMBEROTYPES" from ClientNeeds where Priority >= 7 group by Type, Priority) tmp
where NUMBEROTYPES >= 2 order by Priority desc;