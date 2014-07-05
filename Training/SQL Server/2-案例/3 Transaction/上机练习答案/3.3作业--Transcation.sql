--3.2练习
--3.2.1
use EBuy
go
declare cursor_cat cursor scroll
for
select * from commodity_category
 
open cursor_cat

fetch first from cursor_cat
close cursor_cat
deallocate cursor_cat

go


--3.2.3
begin try
	begin tran
		insert into customer values('1005','123456','gghgf','1','01@email.com','1345001000','上海市,浦东新区,金桥镇,X1188号','200109','098259458')
		insert into orders values (5,'1005',1,10,100000.00,'network trade','2005-9-11','0','0')

	commit tran
end try
begin catch
	rollback tran
end catch

--select * from customer
--select * from orders

--3.2.4
begin try
	begin tran
		delete from orders where  orderId = 3
        delete  from sales where orderId = 3
	commit tran
end try
begin catch
	rollback tran
end catch
--select * from orders
--select * from sales


--3.3.2

declare @comId int ,@amount int
declare @address varchar(80)
declare @orderId
set @orderId = 4

begin try
	begin tran
		update orders set isSendGoods = '1' where orderId = @orderId
		select @comId=comId ,@amount = amount from orders where orderId = @orderId
		update commodity set stoAmount = stoAmount-@amount where comId = @comId
        select @address = c.address from customer c inner join orders o on c.cusId = o.cusId
		where o.orderId = @orderId
         insert into sales
				select orderId,cusId,comId ,amount,dTime,payAmount,@address from orders
					where orderId = @orderId
	commit tran
end try
begin catch
	rollback tran
end catch


select * from orders
select * from commodity
select * from sales
