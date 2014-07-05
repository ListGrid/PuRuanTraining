--事务的并发问题
begin tran
if (select count(*) from aa where ida=2) <= 0
	waitfor delay '00:00:10'
	insert into aa values (2,'a33')
commit tran

--在另一个会话中,INSERT一些数据
insert into aa values(1,'a1')
go
