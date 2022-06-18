-- Views Practice

-- marketing database

use marketing;
create view summary_one 
as
select s.name as Sales_Person_Name,
        r.name as Region_Name,
		a.name as Account_Name,
        o.total_amt_usd,
        (o.standard_qty+o.gloss_qty+o.poster_qty) as Total_qty,
        w.channel
from sales_reps s 
join region r
on s.region_id=r.id
join accounts a 
on a.sales_rep_id=s.id
join orders o
on o.account_id=a.id
join web_events w
on w.account_id=a.id
;

select * from summary_one;

drop view summary;



-- comapny database
use company;

create view company_detail
as
select e.first_name,
       e.last_name,
       e.sex,
       e.salary,
       b.supplier_name,
       b.supply_type,
       s.branch_name
from employee e
join branch_supplier b
on e.branch_id=b.branch_id
join branch s
on s.branch_id=e.branch_id;
	
select count(*) from company_detail;