select First, Last, Type, MonSal*12, Year, TotalExpenses from Employee
natural join (select PID, to_char(ExpDate, 'YYYY') year, sum(Amount) totalexpenses from Expense
group by PID, to_char(ExpDate, 'YYYY')) natural join (select PID, First, Last from Person)
where Type = 'Full' and MonSal*12 < TotalExpenses;