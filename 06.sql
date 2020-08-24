SELECT Title, Last, Cphone, DonDate, Sum(Amount)  TotalDonation, MAX(DonDate) Recent
From ((person natural join Contact) natural join Donor) natural join donation
Where isAnonymous = 1 
and MailList = 0 
and isPrimary = 1
Group by Title, Last, Cphone, DonDate
Order by TotalDonation DESC;