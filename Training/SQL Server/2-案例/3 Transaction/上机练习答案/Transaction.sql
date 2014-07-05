--3.1 homework
use ebuy
go

--3
select * from customer
select * from orders

begin try
	begin tran
		insert into customer values('1007','888888','田丰','1',null,'1388888888','上海市闵行区HAWA路','200241','08878978977')
		insert into orders values(5,'1007',1,30,500,'network trade' , getdate() , '1','0')
	commit tran
end try
begin catch
	rollback tran
end catch

--4
select * from orders
select * from sales

begin try
	begin tran
		delete from orders where ordid = 3
		delete from sales where ordid = 3
    commit tran
end try
begin catch
	rollback tran
end catch



--2
select * from orders
select * from commodity
declare @amount int , @comid int
begin try
	begin tran
		select @amount = amount , @comid = comid from orders where ordid = 4
		update orders set isSendGoods = '1' where ordid = 4
		update commodity set stoamount = stoamount - @amount where comid = @comid
	commit tran
end try
begin catch
	rollback tran
end catch