Create table locktest(
	id int primary key,
	name varchar(29) not null
)
insert into locktest values(1,'bill')
insert into locktest values(2,'mary')
insert into locktest values(3,'jack')


--理解数据库在并发运行时的锁定类型
/*
*	共享锁: 共享 (S) 锁允许并发事务读取 (SELECT) 一个资源。
*   资源上存在共享 (S) 锁时，任何其它事务都不能修改数据。
*   一旦已经读取数据，便立即释放资源上的共享 (S) 锁，
*   除非将事务隔离级别设置为可重复读或更高级别，
*   或者在事务生存周期内用锁定提示保留共享 (S) 锁。
*/

--隔离级别最高
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
use Y05
Go
Begin tran
   select * from locktest  where id=1 
   --尝试打开一个新用户的查询执行更新
       update locktest set name = 'Yao' where id=1 
commit tran

--排它锁示例
Create table locktest(
	id int primary key,
	name varchar(29) not null
)
Begin tran
	insert into locktest values(1,'bill')
--commit tran
--打开一个新的查询窗口
Select * from locktest






--注意: 锁定数据库的一个表的区别 

SELECT * FROM table WITH (HOLDLOCK) 其他事务可以读取表，但不能更新删除 

SELECT * FROM table WITH (TABLOCKX) 其他事务不能读取表,更新和删除

