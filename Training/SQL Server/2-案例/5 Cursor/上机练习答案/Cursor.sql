--3.1 homework
use ebuy
go
select * from commodity
declare cur_comm cursor for select comid , comname from commodity where catid = 2
open cur_comm
fetch next from cur_comm
while(@@fetch_status = 0)
begin
	fetch next from cur_comm 
end
close cur_comm
deallocate cur_comm

--3.1
--1
use study
go
declare couCur cursor scroll  for select couName , couHour , couCredit from course where could like 'B%'
open couCur
fetch next from couCur
fetch first from couCur
fetch last from couCur
fetch absolute 3 from couCur
fetch relative 2 from couCur
fetch prior from couCur
close couCur
deallocate couCur

--3.2
--1
use ebuy
go
declare catCursor cursor  for select * from commodity_category
open catCursor
fetch next from catCursor
close catCursor
deallocate catCursor

--2
declare catCursor cursor for select * from customer order by cusid desc
open catCursor
fetch next from catCursor
while(@@fetch_status = 0)
begin
	fetch next from catCursor
end
close catCursor
deallocate catCursor



--3.3
--1
select * from orders
declare orders_cur cursor for select ordid , payamount , issendgoods from orders where cusid = '1001'
open orders_cur
declare @ordld int , @total_price int ,@issendgoods varchar(1)
fetch next from orders_cur into @ordld , @total_price , @issendgoods
while(@@fetch_status = 0)
 begin
	if(@issendgoods = '0')
		print cast(@ordld as varchar) +'  '+ cast(@total_price * 0.9 as varchar)
	else
		print cast(@ordld as varchar) +'  '+ cast(@total_price as varchar)
	fetch next from orders_cur into @ordld , @total_price , @issendgoods
 end
close orders_cur
deallocate orders_cur

