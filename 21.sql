Update clientneeds
Set priority = (Case  
When priority != 10
Then priority + 1
End)
Where type = (select type from (select type, count(type) as countA from clientneeds where rownum = 1 group by type order by countA Desc ));