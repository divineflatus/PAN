select gender, count(gender) gencount, ethnicity,  count(ethnicity) ethcount
from (
Select gender, count(gender) gencount, ethnicity,  count(ethnicity) ethcount, gender as g, ethnicity as e
From person natural join client
Group by gender, ethnicity
Union all
Select 'gendersub', count(gender), 'enthnicitysub', count(ethnicity), gender as g, ethnicity as e
From person natural join client
Group by gender, ethnicity
) a
Group by gender, ethnicity, gencount, ethcount order by gender, ethnicity;