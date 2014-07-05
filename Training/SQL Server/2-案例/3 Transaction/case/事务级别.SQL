begin tran
insert into aa values(1,'aa')
insert into aa values(5,'well5')
select * from aa
commit tran

--set transaction isolation level read uncommitted
--set transaction isolation level read committed 
--set transaction isolation level repeatable read 
--set transaction isolation level serializable

select * from aa
