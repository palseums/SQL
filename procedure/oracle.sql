create or replace procedure pr_buy_products
as
	v_name varchar(20), v_age int;
begin
	select product_code, price
	into v_product_code, v_price
	from products
	where product_name = 'iphone 13 pro max';

	insert into sales(order_date, product_code, quantity_ordered, sale_price) values (current_date,v_product_code,1,(v_price*1));

	update products set quantity_remaining = (quantity_remaining -1), quantity_sold = (quantity_sold + 1) where product_code = v_product_code;

	dbms_output.put_line ('product sold !');
end;



How to call procedure ?
=========================

exec pr_buy_products


with parameter
==================

# if you don't specify the parameter it is always IN parameter



create or replace procedure pr_buy_products(p_product_name varchar,p_quantity int)
as
	v_name varchar(20), v_age int, v_cnt int;
begin

	select count(1) into v_cnt from products where product_name = p_product_name and quantity_remaining >= p_quantity;

	if v_cnt > 0 then

			select product_code, price
			into v_product_code, v_price
			from products
			where product_name = p_product_name;

			insert into sales(order_date, product_code, quantity_ordered, sale_price) values (current_date,v_product_code,p_quantity,(v_price*p_quantity));

			update products set quantity_remaining = (quantity_remaining - p_quantity), quantity_sold = (quantity_sold + p_quantity) where product_code = v_product_code;

			dbms_output.put_line 'product sold !';
	else

			dbms_output.put_line 'Dont have products';
	end if;
end;

