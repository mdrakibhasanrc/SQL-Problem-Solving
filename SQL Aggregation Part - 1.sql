use marketing;
/*1. Find the total amount of poster_qty paper ordered in the orders table.*/

select sum(poster_qty)
from orders;

/* 2. Find the total amount of standard_qty paper ordered in the orders table.*/

select sum(standard_qty)
from orders;

/*3. Find the total dollar amount of sales using the total_amt_usd in the 
orders table.*/

select sum(total_amt_usd)
from orders;

/* 4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper 
for each order in the orders table. This should give a dollar amount for 
each order in the table.*/

select standard_qty + gloss_amt_usd as Total_amount
from orders;

/* 5. Find the standard_amt_usd per unit of standard_qty paper. Your solution should 
use both an aggregation and a mathematical operator.*/

select sum(standard_amt_usd)/sum(standard_qty) as Per_Unit
from orders;
/* 5. When was the earliest order ever placed? You only need to return the date.*/

select min(occurred_at) as oldest_order
from orders;

/* 6. Try performing the same query as the previous one without using an aggregation function.*/

select occurred_at
from orders
order by occurred_at asc
limit 1;

/* 7. When did the most recent (latest) web_event occur?*/

select max(occurred_at) as oldest_order
from orders;

/* 8. Try to perform the result of the previous query without using an aggregation function.*/

select occurred_at
from orders
order by occurred_at desc
limit 1;

/* 9. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean 
amount of each paper type purchased per order. Your final answer should have 6 values - 
one for each paper type for the average number of sales, as well as the average amount.*/

select avg(standard_qty),
       avg(poster_qty),
       avg(gloss_qty),
       avg(standard_amt_usd),
       avg(gloss_amt_usd),
       avg(poster_amt_usd) 
from orders;

/* 10. Which account (by name) placed the earliest order? Your solution 
should have the account name and the date of the order.*/

 select a.name,o.occurred_at
 from accounts a
 join orders o
 on a.id=o.account_id
 order by occurred_at  desc
 limit 1;

/* 11. Find the total sales in usd for each account. You should include 
two columns - the total sales for each company's orders in usd and 
the company name.*/

select a.name,sum(o.total_amt_usd) as total_sales
from orders o
join accounts a
on a.id=o.account_id
group by a.name;

/* 12. Via what channel did the most recent (latest) web_event occur, which 
account was associated with this web_event? Your query should return 
only three values - the date, channel, and account name.*/

select w.occurred_at,
       a.name,
       w.channel
from accounts a
join web_events w
on a.id=w.account_id
order by w.occurred_at desc
limit 1;


/* 13. Find the total number of times each type of channel from the 
web_events was used. Your final table should have two columns - 
the channel and the number of times the channel was used.*/

select channel,count(channel) as Count
from web_events
group by channel;


/* 14.Who was the primary contact associated with the earliest web_event? */

select a.primary_poc,
        w.channel,
	   w.occurred_at
from accounts a
join web_events w
on a.id=w.account_id
order by w.occurred_at desc
limit 1;

/* 15.What was the smallest order placed by each account in terms of total 
usd. Provide only two columns - the account name and the total usd. 
Order from smallest dollar amounts to largest.*/

SELECT a.name, MIN(o.total_amt_usd) amount
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY amount;

/* 16. Find the number of sales reps in each region. Your final table should 
have two columns - the region and the number of sales_reps. Order from 
fewest reps to most reps.*/

select r.name,
	   s.name
from region r
join sales_reps s
on s.region_id=r.id
group by r.name;

/* 17. For each account, determine the average amount of each type of paper they 
purchased across their orders. Your result should have four columns - one 
for the account name and one for the average quantity purchased for each of 
the paper types for each account.*/

select a.name,
       avg(o.standard_qty) as standard_qty,
       avg(o.poster_qty) as poster_qty,
       avg(o.gloss_qty) as gloss_qty
from accounts a
join orders o
on a.id=o.account_id
group by a.name;


/* 18. For each account, determine the average amount spent per order on each paper 
type. Your result should have four columns - one for the account name and one 
for the average amount spent on each paper type.*/

select a.name,
       avg(o.standard_amt_usd) as standard_amt_usd,
       avg(o.poster_amt_usd) as poster_amt_usd,
       avg(o.gloss_amt_usd) as gloss_amt_usd
from accounts a
join orders o
on a.id=o.account_id
group by a.name;

/* 19. Determine the number of times a particular channel was used in the web_events 
table for each sales rep. Your final table should have three columns - the 
name of the sales rep, the channel, and the number of occurrences. Order your 
table with the highest number of occurrences first.*/

select s.name,
       w.channel,
       count(w.channel) as Count
from  web_events w
join  accounts a
on w.account_id=a.id
join sales_reps s
on s.id=sales_rep_id
group by w.channel,s.name;

/* 20. Determine the number of times a particular channel was used in the web_events 
table for each region. Your final table should have three columns - the region 
name, the channel, and the number of occurrences. Order your table with the 
highest number of occurrences first. */

select r.name,
       w.channel,
       count(w.channel) as Count
from  web_events w
join  accounts a
on w.account_id=a.id
join sales_reps s
on s.id=sales_rep_id
join region r
on r.id=s.region_id
group by r.name, w.channel;

/* 21.Use DISTINCT to test if there are any accounts associated with more than one 
region.*/

SELECT DISTINCT a.name, s.region_id
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
ORDER BY a.name;

/* 22. Have any sales reps worked on more than one account? */

SELECT s.name, a.sales_rep_id, COUNT(a.id) num_accounts
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, a.sales_rep_id
ORDER BY num_accounts;

/* 23.How many of the sales reps have more than 5 accounts 
that they manage?*/

SELECT s.name, a.sales_rep_id, COUNT(a.id) num_accounts
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, a.sales_rep_id
having count(a.id) > 5
ORDER BY num_accounts;


/* 24. How many accounts have more than 20 orders?*/
 
 select a.name,count(o.account_id) as Number
 from accounts a
 join orders o
 on a.id=o.account_id
 group by a.name
 having count(o.account_id) > 20
 order by Number;

/* 25. Which account has the most orders? */

select a.name,count(o.account_id) as Number
 from accounts a
 join orders o
 on a.id=o.account_id
 group by a.name
 order by Number desc
 limit 1;

/* 26.. How many accounts spent more than 30,000 usd total 
across all orders? */

select a.name,sum(o.total_amt_usd) as Total_amt
 from accounts a
 join orders o
 on a.id=o.account_id
group by a.name
having sum(o.total_amt_usd) > 30000
 order by Total_amt desc;

/* 27. How many accounts spent less than 1,000 usd total 
across all orders?*/

select a.name,sum(o.total_amt_usd) as Total_amt
 from accounts a
 join orders o
 on a.id=o.account_id
group by a.name
having sum(o.total_amt_usd) < 1000
 order by Total_amt desc;

       