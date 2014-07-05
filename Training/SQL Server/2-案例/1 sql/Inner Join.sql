--可以是不同的任意两张表，通常是有主外键关系的字段匹配
use stuDB
go
select * from students A 
select * from grade B


select * from students A 
inner join grade B on A.stu_id = B.stu_id