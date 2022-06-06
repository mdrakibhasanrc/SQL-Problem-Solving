use marketing;

/* 1. Which account has spent the most with us? */

select a.name,
       sum(o.total_amt_usd) as toal_amt_usd
from accounts a 
join orders o
on a.id=o.account_id
group by a.name
order by total_amt_usd desc
limit 1;
       

/* 2. Which account has spent the least with us?*/

select a.name,
       sum(o.total_amt_usd) as toal_amt_usd
from accounts a 
join orders o
on a.id=o.account_id
group by a.name
order by total_amt_usd asc
limit 1;

/* 3. Which accounts used facebook as a channel to 
contact customers more than 6 times?*/

select a.name,
       w.channel,
       count(channel) as Number
from accounts a
join web_events w
on a.id=w.account_id
where channel="facebook"
group by a.name
having count(channel) > 6
order by number;

/* 4. Which account used facebook most as a channel? */
select a.name,
       w.channel,
       count(channel) as Number
from accounts a
join web_events w
on a.id=w.account_id
where channel="facebook"
group by a.name,w.channel
order by number desc
limit 1;

/* 5. Which channel was most frequently used by most 
accounts?*/

select a.name,
       w.channel,
       count(channel) as Number
from accounts a
join web_events w
on a.id=w.account_id
group by a.name,w.channel
order by number desc;

/* 6. We would like to understand 3 different levels of customers 
based on the amount associated with their purchases. The 
top branch includes anyone with a Lifetime Value (total 
sales of all orders) greater than 200,000 usd. The second 
branch is between 200,000 and 100,000 usd. The lowest 
branch is anyone under 100,000 usd. Provide a table that 
includes the level associated with each account. You should 
provide the account name, the total sales of all orders for 
the customer, and the level. Order with the top spending 
customers listed first. */

SELECT a.name,
	SUM(total_amt_usd) total_spent,
	CASE 
		WHEN SUM(total_amt_usd) > 200000 
			THEN 'top'
    	WHEN SUM(total_amt_usd) BETWEEN 100000 AND 200000 
    		THEN 'middle'
    	ELSE 'lowest' END 
	AS level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;


/* 7. We would now like to perform a similar calculation to the first, 
but we want to obtain the total amount spent by customers only 
in 2016 and 2017. Keep the same levels as in the previous 
question. Order with the top spending customers listed first.
*/

SELECT a.name,
	SUM(total_amt_usd) total_spent,
	CASE 
		WHEN SUM(total_amt_usd) > 200000 
			THEN 'top'
    	WHEN SUM(total_amt_usd) BETWEEN 100000 AND 200000 
    		THEN 'middle'
    	ELSE 'lowest' END 
	AS level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
where o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY 1
ORDER BY 2 DESC;

/* 8. We would like to identify top performing sales reps, which are 
sales reps associated with more than 200 orders. Create a table 
with the sales rep name, the total number of orders, and a 
column with top or not depending on if they have more than 200 
orders. Place the top sales people first in your final table.*/

SELECT s.name, 
	COUNT(o.id) total_orders,
	CASE 
		WHEN COUNT(o.id) > 200 
		THEN 'top'
    	ELSE 'not' 
	END AS top_or_not
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;

/* 9. The previous one didn't account for the middle, nor the dollar amount 
associated with the sales. Management decides they want to see 
these characteristics represented as well. We would like to identify 
top performing sales reps, which are sales reps associated with more 
than 200 orders or more than 750000 in total sales. The middle group 
has any rep with more than 150 orders or 500000 in sales. Create a 
table with the sales rep name, the total number of orders, total 
sales across all orders, and a column with top, middle, or low 
depending on this criteria. Place the top sales people based on 
dollar amount of sales first in your final table. You might see a 
few upset sales people by this criteria!
*/
SELECT s.name, 
	COUNT(o.id) total_orders,
    SUM(o.total_amt_usd) sales_value,
	CASE 
    	WHEN COUNT(o.id) > 200 
        	OR SUM(o.total_amt_usd) > 750000 
        THEN 'top'
    	WHEN COUNT(o.id) BETWEEN 150 AND 200 
        	OR SUM(o.total_amt_usd) BETWEEN 500000 AND 750000 
        THEN 'middle'
    	ELSE 'low' 
	END AS top_or_not
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 3 DESC;