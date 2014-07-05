drop table aa
drop table bb

--死锁演示
create table aa
(
	Ida int,
	Namea char(10)
)
go
create table bb
(
	Idb int,
	Nameb char(10)
)
go
insert into aa values(1,'a1')
insert into bb values(1,'b1')
go
begin tran
update aa set namea = 'a11' where ida = 1
waitfor delay '00:00:12'
update bb set nameb = 'b11' where idb = 1
commit tran
--在另一个会话中运行以下的功能
begin tran
update bb set nameb = 'b22' where idb = 1
waitfor delay '00:00:10'
update aa set namea = 'a22' where ida = 1
commit tran


--设置死锁解决方案.

set lock_timeout 5000
Set deadlock_priority low
begin tran
update aa set namea = 'a11' where ida = 1
waitfor delay '00:00:12'
update bb set nameb = 'b11' where idb = 1
commit tran


begin tran
update bb set nameb = 'b22' where idb = 1
waitfor delay '00:00:10'
update aa set namea = 'a22' where ida = 1
commit tran
