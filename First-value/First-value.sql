------ with condition -------

with table1_1(a11,a12,a13,a15) as
(select *,
case
 when lastname = 'paramasivam' then 'palani'
 when lastname = 'palaniappan' then 'ADWAIDAN'
end as column6
from persons)
select a15 from table1_1



select *,
first_value(product_name)
over(partiton by product_category order by price desc) as most_exp_product,
last_value(product_name)
over(partition by product_category order by price desc range between unbounded preceding and unbounded following) as least_exp_product
from product;

---Alternate way to write window function ---


select *,
first_value(product_name)
over w as most_exp_product,
last_value(product_name)
over w as least_exp_product
from product;
window w as (partition by product_category order by price desc range between unbounded preceding and unbounded following);

---nth value ----


select *,
first_value(product_name)
over w as most_exp_product,
last_value(product_name)
over w as least_exp_product,
nth_value(product_name,2) over w as second_most_expensive_product
from product;
window w as (partition by product_category order by price desc range between unbounded preceding and unbounded following);

--------ntile ---------

select ntile(3) over ( order by price desc) as buckets from product where product_category = 'Phone'


----- View --------
view store only the structure of the table. it does not store the actual data
We can update view if only the select statement contains only one table

1) we cannot update view if it contains distinct clause
2) we cannot update view if it contains with clause
3) we cannot update view if it contains groupby clause
4) we cannot update view if it contains window function

---- Materialized View -----------

1) Stores the sql query
2) Stores the data returned from the sql query
3) We have to manually refresh the view to have the updated data
refersh materialized view mv_random_data


-------- Joins ----------

left join ==> left outer join
right join ==> Right out join
inner join ==> join
full join ==> full outer join


1) left Join => Inner Join + all remaining records from the left table

2) Right Join => Inner Join + all remaining records from the Right table

3) Full join or Full outer join => Inner Join + all remaining records from the Right table + all remaining records from the left table

4) cross join ==> In cross join you don't want to put any condition
  eg: select e.emp_name, d.dept_name from employee e cross join department d ;
  
5) Natural join ==> In natural join sql will decide the join condition not by the user who writes sql query

6) self join ==> Self join does not have a keyword called self. if a table joining to itself is called self
  eg : select child.name as child_name, child.age as child_age, parent.name as parent_name, parent.age as parent_age
  from family as child join family as parent on child.parent_id = parent.member_id
  
--------physical joins -------------

1) Merge join or sort merge join
	i) The optimizer may choose the sort merge join over hash join, when the join condition between the two table is NOT an equijoin
	ii) First step it sort both the table on the join key
	iii) Second step - merge and gives the output
	
2) HashMatch join
	i) It has build and probe phase
	ii) during the build phase a small table is taken and hash value is generated on the join key and it is kept in the memory
	iii) In probe phase it will look for the matching hash value on the other table
	iv) it does not require data to be in sorting order
	
3) Nested loop Join - This one works like a for loop
	
	
  







