select DriveTitle, Theme, DriveTotal, StartDate || ' ' || EndDate DateRange
from Drive natural join (select DriveTitle, sum(Amount) DriveTotal from Donation where DriveTitle IS NOT NULL group by DriveTitle)
where DriveTotal >= Goal 
order by StartDate desc;