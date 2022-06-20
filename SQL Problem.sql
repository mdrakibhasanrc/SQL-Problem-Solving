use marketing;

/* 1.What is the lifetime average amount spent in terms of total_amt_usd 
for only the companies that spent more than the average of all orders.*/

WITH
	sub AS (
		SELECT account_id,
			AVG(total_amt_usd) total_amt_usd
		FROM orders
		GROUP BY account_id
		)

SELECT AVG(total_amt_usd)
FROM sub
WHERE total_amt_usd > 
	(SELECT AVG(total_amt_usd) total_amt_usd
	FROM orders);
    
/* 2. What is the lifetime average amount spent in terms of total_amt_usd 
for the top 10 total spending accounts? */

with sub
   as ( select account_id,sum(total_amt_usd) as total
        from orders
        group by account_id
        limit 10)
select avg(total)
from sub;


/* 3.For the region with the largest (sum) of sales total_amt_usd, how many 
total (count) orders were placed? */

SELECT r.name region,
    SUM(o.total_amt_usd) total_amt_usd,
    COUNT(*)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* 4. For the name of the account that purchased the most (in total over their 
lifetime as a customer) standard_qty paper, how many accounts still had 
more in total purchases?*/


SELECT COUNT(*)
FROM (
	SELECT a.name, SUM(o.total)
	FROM accounts a
	JOIN orders o
	ON o.account_id = a.id
	GROUP BY a.name
	HAVING SUM(o.total) > (
      	SELECT total
      	FROM (
			SELECT SUM(o.standard_qty) standard_qty,
      			SUM(o.total) total 
			FROM orders o
			GROUP BY account_id
			ORDER BY 1 DESC
			LIMIT 1
			)sub1
      	)
	)sub;

    
    
    

