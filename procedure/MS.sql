create or alter procedure pr_buy_products
as
	declare @v_product_code varchar(20), @v_price int;
begin
	select @v_product_code = product_code, @v_price = price
	from products
	where product_name = 'iphone 13 pro max';

	insert into sales(order_date, product_code, quantity_ordered, sale_price) values (cast(getdate() as date),@v_product_code,1,(@v_price*1));

	update products set quantity_remaining = (quantity_remaining -1), quantity_sold = (quantity_sold + 1) where product_code = @v_product_code;

	print('product sold !');
end;


How to call procedure ?
=========================

exec pr_buy_products

exec pr_buy_products 'AirPods Pro', 5; # You cannot use paranthesis when calling the procedure 




with parameter
==================

# Here if statement has begin clause if it has multiple statement 
# if you don't specify the parameter it is always IN parameter
# M Sql server you have to provide some number in the varchar if you give empty it just take only one 




create or alter procedure pr_buy_products(@p_product_name varchar(40),@p_quantity int)
as
	declare @v_name varchar(20), @v_age int, @v_cnt int;
begin

	select  @v_cnt = count(1) from products where product_name = @p_product_name and quantity_remaining >= @p_quantity;

	if @v_cnt > 0
	begin

			select @v_product_code = product_code, @v_price = price
			from products
			where product_name = @p_product_name;

			insert into sales(order_date, product_code, quantity_ordered, sale_price) values (cast(getdate() as date),@v_product_code,@p_quantity,(@v_price*@p_quantity));

			update products set quantity_remaining = (quantity_remaining - @p_quantity), quantity_sold = (quantity_sold + @p_quantity) where product_code = @v_product_code;

			print 'product sold !';
	end
	else

			print 'Dont have products';
	end if;
end;