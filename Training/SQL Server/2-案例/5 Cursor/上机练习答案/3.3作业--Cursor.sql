--3.2Á·Ï°
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
--3.2.2
declare @cusId varchar(20)
declare @cusName varchar(30)
declare cursor_cus cursor scroll
for
select cusId,cusName from customer
open cursor_cus
fetch last from cursor_cus into @cusId ,@cusName
while @@fetch_status = 0
	begin 
	 print @cusId+'£¬'+@cusName
    fetch prior from cursor_cus into @cusId ,@cusName
    end
   close cursor_cus
   deallocate cursor_cus 



----3.3×÷Òµ
--3.3.1 

declare @orderId int,@cusId varchar(20),@payAmount decimal(10,2)
declare @payWay varchar(50),@isSendGoods varchar(1)
declare cursor_order cursor scroll
for 
select orderId,cusId,payAmount,payWay,isSendGoods from orders where cusId = '1001'

open cursor_order
fetch first from cursor_order into @orderId,@cusId,@payAmount,@payWay,@isSendGoods
while @@fetch_status = 0 
 begin
	if @isSendGoods ='0'
		begin 
			update orders set payAmount = payAmount*0.90 where current of cursor_order

		end
	print 'OrderId:'+cast(@orderId as varchar) +', cusId:'+@cusId +', payAmount:'
    + cast(@payAmount as varchar) +', payWay:'+ @payWay +',isSendGoods:' +@isSendGoods

fetch next from cursor_order into @orderId,@cusId,@payAmount,@payWay,@isSendGoods
 end
close cursor_order
deallocate cursor_order

select * from orders
