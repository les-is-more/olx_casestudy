# this summarizes the # of unique Seller IDS by category; now at 1220
select `Category.ID`, 
    count(`Seller.ID`) 
from b2c 
group by `Category.ID`
;
# creates temporary table to house the temporary query results
create table temptbl1 (
  sellpopn varchar(20),
  sellwithrev varchar(20),
  sellwithbuy varchar(20)
  );
# query proper: the results are inserted into the newly-created temporary table
insert into temptbl1
select a.`Seller.ID` as sellpopn, 
  b.`Seller.ID` as sellwithRev, 
  c.`Seller.ID` as sellwithbuy
from 
b2c as a left join pay as b
    on (a.`Seller.ID` = b.`Seller.ID`) 
  left join contacts as c
    on (a.`Seller.ID` = c.`Seller.ID`);
# once finished with the temporary data, you may now delete the table using the 'drop table' command
