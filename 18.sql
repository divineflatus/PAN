select HereItIs.*, Title, Last, Primary from HereItIs inner join Person on Person.PID = OffContact
inner join PersonPrimaryPhone on PNum = Person.PID order by OrganizationName;