use marketing;

/* 1. Try pulling all the data from the accounts table, and all the data from the 
orders table.*/

select a.*,o.*
from accounts a
join orders o 
on a.id=o.account_id;


/* 2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, 
and the website and the primary_poc from the accounts table.*/

select a.website,a.primary_poc,
       o.standard_qty,o.gloss_qty,o.poster_qty
from accounts a
join orders o
on a.id=o.account_id;

/* 3. Provide a table for all web_events associated with account name of Walmart. 
There should be three columns. Be sure to include the primary_poc, time of the 
event, and the channel for each event. Additionally, you might choose to add a 
fourth column to assure only Walmart events were chosen.*/

select a.name,a.primary_poc,
       w.occurred_at,w.channel
from accounts a
join web_events w
on a.id=w.account_id
where a.name ="Walmart";

/* 4. Provide a table that provides the region for each sales_rep along with their 
associated accounts. Your final table should include three columns: the region name, 
the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) 
according to account name. */

select r.name as Region_name,
	   s.name as Sales_rep_name,
       a.name as Account_name
from region r
join sales_reps s
on s.region_id=r.id
join accounts a
on s.id=a.sales_rep_id
order by a.name;


/* 5. Provide the name for each region for every order, as well as the account name 
and the unit price they paid (total_amt_usd/total) for the order. Your final table 
should have 3 columns: region name, account name, and unit price. */

select r.name,
       a.name,
	   (o.total_amt_usd/o.total) as Unit_price
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on s.id=a.sales_rep_id
join orders o
on o.account_id=a.id
order by a.name;


/* 6. Provide a table that provides the region for each sales_rep along with their associated 
accounts. This time only for the Midwest region. Your final table should include three 
columns: the region name, the sales rep name, and the account name. Sort the accounts 
alphabetically (A-Z) according to account name.*/

SELECT a.name acoount_name, 
    s.name sales_rep_name, 
    r.name region_name
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = 'Midwest'
ORDER BY a.name ;


/* 7. Provide a table that provides the region for each sales_rep along with their associated 
accounts. This time only for accounts where the sales rep has a first name starting with 
S and in the Midwest region. Your final table should include three columns: the region 
name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) 
according to account name. */

SELECT a.name acoount_name, 
    s.name sales_rep_name, 
    r.name region_name
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = 'Midwest' and s.name like "S%"
ORDER BY a.name ;

/* 8.Provide a table that provides the region for each sales_rep along with their associated 
accounts. This time only for accounts where the sales rep has a last name starting with 
K and in the Midwest region. Your final table should include three columns: the region 
name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) 
according to account name.*/

SELECT a.name acoount_name, 
    s.name sales_rep_name, 
    r.name region_name
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = 'Midwest' and s.name like "%k%"
ORDER BY a.name ;

/* 9. Provide the name for each region for every order, as well as the account name and the 
unit price they paid (total_amt_usd/total) for the order. However, you should only 
provide the results if the standard order quantity exceeds 100. Your final table should 
have 3 columns: region name, account name, and unit price. In order to avoid a division 
by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*/

select r.name,
       a.name,
	   (o.total_amt_usd/o.total) as Unit_price
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on s.id=a.sales_rep_id
join orders o
on o.account_id=a.id
where o.standard_qty > 100
order by a.name;

/* 10. Provide the name for each region for every order, as well as the account name and the 
unit price they paid (total_amt_usd/total) for the order. However, you should only 
provide the results if the standard order quantity exceeds 100 and the poster order 
quantity exceeds 50. Your final table should have 3 columns: region name, account name, 
and unit price. Sort for the smallest unit price first. In order to avoid a division by 
zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). */

select r.name,
       a.name,
	   (o.total_amt_usd/o.total) as Unit_price
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on s.id=a.sales_rep_id
join orders o
on o.account_id=a.id
where o.standard_qty > 100 and poster_qty > 50
order by a.name;

/* 11. Provide the name for each region for every order, as well as the account name and the 
unit price they paid (total_amt_usd/total) for the order. However, you should only 
provide the results if the standard order quantity exceeds 100 and the poster order 
quantity exceeds 50. Your final table should have 3 columns: region name, account name, 
and unit price. Sort for the largest unit price first. In order to avoid a division by 
zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
*/

select r.name,
       a.name,
	   (o.total_amt_usd/o.total) as Unit_price
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on s.id=a.sales_rep_id
join orders o
on o.account_id=a.id
where o.standard_qty > 100 and poster_qty > 50
order by Unit_price desc;



/* 12. What are the different channels used by account id 1001? Your final table should have 
only 2 columns: account name and the different channels. You can try SELECT DISTINCT 
to narrow down the results to only the unique values.*/


SELECT DISTINCT w.channel,
    a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.id = 1001 ;

/* 13. What are the different channels used by account id 1001? Your final table should have 
only 2 columns: account name and the different channels. You can try SELECT DISTINCT 
to narrow down the results to only the unique values.*/

SELECT o.occurred_at,
    a.name,
    o.total,
    o.total_amt_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01' ;

