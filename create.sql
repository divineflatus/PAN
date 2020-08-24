drop table ClientNeeds;
drop table Promote;
drop table Liaison;
drop table Serve;
drop table Care;
drop table Sponsor;
drop table TeamNeeds;
drop table Report;
drop table Donor;
drop table Drive;
drop table Donation;	
drop table Organization;
drop table Client;
drop table Expense;
drop table Team;
drop table Employee;
drop table Volunteer;
drop table Contact;
drop table Person;
Drop TeamAssignment;
Drop VolDetails;
Drop view TotalDonations;
Drop view orgDonations;
Drop view PersonDonations;
Drop view Q17;
Drop view OrgThatHave;
Drop view OrgThatHaveNot;
Drop view XPromYIsEmp;
Drop view GetMyInfo;
Drop view HerItIs;
Drop view PersonPrimaryPhone;
Drop view PayRaise;
Drop view TotalHrs;
Drop view NullDriveTotals;
CREATE TABLE Person(
  PID number,
  First varchar2(20),
  MI varchar2(2),
  Last varchar2(20),
  Title varchar2(20),
  Gender varchar2(10),
  DOB date,
  Email varchar2(50),
  Ethnicity varchar2(20),
  Profession varchar2(50),
  Street varchar2(50),
  City varchar2(50),
  State varchar2(10),
  ZIP number,
  MailList number,
  primary key (PID)
);
CREATE TABLE Contact(
  PID number,
  CPhone number,
  CType varchar2(10),
  isPrimary number, /*0 for no, 1 for yes*/
  primary key(PID, CPhone),
  foreign key(PID) references Person on delete cascade
);
CREATE TABLE Employee(
  PID number,
  EmpTitle varchar2(50),
  Type varchar2(20),
  MarStatus varchar2(1),
  HireDate date,
  MonSal number,
  primary key(PID),
  foreign key(PID) references Person on delete cascade
);
CREATE TABLE Expense(
  PID number,
  ExpenseNo number,
  Description varchar2(50),
  ExpDate date,
  Amount number(7,2),
  check(Amount > -1),
  primary key(PID, ExpenseNo),
  foreign key(PID) references Employee on delete cascade  
);
CREATE TABLE Organization(
  OrgName varchar2(50),
  Address varchar2(100),
  Type varchar2(20),
  Website varchar2(100),
  OffContact number, /*PID of Person who is official contact*/
  primary key(OrgName)
);
CREATE TABLE Volunteer(
  PID number,
  DateJoined date,
  primary key(PID),
  foreign key(PID) references Person on delete cascade
);
CREATE TABLE Client(
  PID number,
  DocFirst varchar2(20),
  DocLast varchar2(20),
  DocPhone number,
  AttFirst varchar2(20),
  AttLast varchar2(20),
  AttPhone number,
  JoinDate date,
  primary key(PID),
  foreign key(PID) references Person on delete cascade
);
CREATE TABLE ClientNeeds(
  PID number,
  Type varchar2 (10),
  Priority number,
  Check(Priority between 1 AND 10),
  primary key(PID, Type),
  foreign key(PID) references Client on delete cascade
);
CREATE TABLE Drive(
  DriveTitle varchar2(50),
  Theme varchar2(20),
  Goal number,
  StartDate date,
  EndDate date,
  Lead number, /*PID of employee that heads drive*/
  primary key(DriveTitle)
); 
CREATE TABLE Donor(
  PID number,
  primary key(PID),
  foreign key(PID) references Person on delete cascade
);
CREATE TABLE Donation(
  DID number,
  PID number, /*keeps track of which donor made donation*/
  OrgName varchar2(50), /*If an organization made the donation (no PID)*/
  Amount number,
  PayType varchar2(10),
  DonDate date,
  DriveTitle varchar2(50), /*Keeps track of which drive generated donation*/
  isAnonymous number,
  primary key(DID)
);
CREATE TABLE Team(
  TeamName varchar2(50),
  Type varchar2(10),
  Leader number,
  DateFormed date,
  PID number NOT NULL, /*Reports to this person*/
  primary key(TeamName)
);
CREATE TABLE Report(
  TeamName varchar2(50),
  ReportNo number,
  Status varchar2(10),
  ReportDate date,
  primary key(ReportNo)
);
CREATE TABLE TeamNeeds(
  ReportNo number,
  Need varchar(50),
  primary key(ReportNo, Need),
  foreign key(ReportNo) references Report on delete cascade
);
CREATE TABLE Serve(
  TeamName varchar2(50),
  PID number,
  HrsWorked number,
  check(HrsWorked > -1),
  primary key(TeamName, PID),
  foreign key(TeamName) references Team on delete cascade,
  foreign key(PID) references Volunteer on delete cascade
);
CREATE TABLE DailyHrs(
  PID number,
  WorkDate date,
  Hrs number
  check(Hrs > -1),
  primary key(PID, WorkDate),
  foreign key(PID) references Volunteer on delete cascade
);
  
CREATE TABLE Care(
  TeamName varchar2(50),
  PID number,
  primary key(TeamName, PID),
  foreign key(TeamName) references Team on delete cascade,
  foreign key(PID) references Client on delete cascade
);   
CREATE TABLE Liaison(
  PID number,
  OrgName varchar2(50),
  primary key(PID, OrgName),
  foreign key(PID) references Person on delete cascade,
  foreign key(OrgName) references Organization on delete cascade
);
CREATE TABLE Promote(
  OrgName varchar2(50),
  DriveTitle varchar2(50), 
  primary key(OrgName, DriveTitle)
);
CREATE TABLE Sponsor(
  TeamName varchar2(50),
  OrgName varchar2(50),
  primary key(TeamName, OrgName),
  foreign key(TeamName) references Team on delete cascade,
  foreign key(OrgName) references Organization on delete cascade
);
create view TeamAssignment as
select PID, TeamName, First, MI, Last, Gender
from (care natural join client) natural join person;	
create view VolDetails
as select PID, First, MI, Last, DateJoined, Gender, TeamName
from (serve natural join volunteer) natural join person;
create view TotalDonations as
select extract(year from donDate) DonYear, PID, sum(amount) TotalDon, DriveTitle
From donation natural join person
Group by pid, extract(year from donDate), DriveTitle;
Create view orgDonations as
select OrgName, sum(Amount) OrgAmount
from Donation 
where OrgName IS NOT NULL 
group by OrgName 
order by OrgName;
Create view PersonDonations as
select L.OrgName, sum(Amount) IndAmount
from Donation D, Liaison L 
where D.PID = L.PID 
group by D.PID, L.OrgName 
order by D.PID;
CREATE VIEW Q17 as
select PID, Last, monsal * 12 Salary, marstatus, count(distinct driveTitle) NumDrives
from (employee natural join person), drive
where type = 'P/T'
and PID = Drive.Lead
group by PID, Last, monsal * 12, marstatus;
Create view OrgsThatHave as
select OrgName, DriveTitle, Lead from Drive natural join Promote where to_char(StartDate, 'YYYY') =
to_char(sysdate, 'YYYY') or to_char(StartDate, 'YYYY') = to_char(sysdate, 'YYYY')-1 and
to_char(sysdate, 'DD-MM-YYYY') > to_char(EndDate, 'DD-MM-YYYY') order by DriveTitle;
Create view OrgsThatHaveNot as
select OrgName, Drive.DriveTitle as TheTitle, Drive.Lead as Leader from Drive left join OrgsThatHave on Drive.DriveTitle
= OrgsThatHave.DriveTitle where OrgName is NULL;
Create view XPromYIsEmp as
select Promote.OrgName OrganizationName, DriveTitle as SponsoredTitle, PID from Promote, Liaison where Promote.OrgName = Liaison.OrgName;
Create view GetMyInfo as
select OrganizationName from OrgsThatHaveNot inner join XPromYIsEmp on Leader = PID and TheTitle = SponsoredTitle;
Create view HereItIs as
select OrganizationName, Type, Website, OffContact from GetMyInfo inner join Organization on OrganizationName = OrgName;
Create view PersonPrimaryPhone as
select PID PNum, CPhone Primary from Contact where isPrimary = 1;
create view PayRaise as
(select PID, MonSal from (select PID, count(PID) NumOfTeams
from Team group by PID order by PID) tmp natural join
(select * from Employee where Type = 'P/T') where NumOfTeams > 1);
create view TotalHrs as(
select PID, sum(Hrs) as TotalHrs 
from DailyHrs group by PID);
Create view NullDriveTotals as (
select t1.DriveTitle, Goal, EndDate, TotalFunded from (select DriveTitle, Goal, EndDate from Drive where to_date(EndDate) < to_date(sysdate)) t1 left join (select DriveTitle, sum(Amount) as TotalFunded from Donation group by DriveTitle) t2 on t1.DriveTitle = t2.DriveTitle);
commit;