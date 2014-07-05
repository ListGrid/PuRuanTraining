Create table locktest(
	id int primary key,
	name varchar(29) not null
)
Begin tran
	insert into locktest values(1,’bill’)
--commit tran


Select * from locktest
--看一下此时的情况
