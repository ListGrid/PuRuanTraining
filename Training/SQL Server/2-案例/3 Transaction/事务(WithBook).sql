/*
*  author: 
*  Title: 事务示例
*  Date: 
*/


/*自动提交事务 */
use Y05
Create table Account
(
   accid int not null,
   [type] varchar(10),
   balance decimal(10,2) not null 
)
GO
insert into Account values(1111,'saving',3000)
insert into Account values(2222,'saving',null)
insert into Account values(3333,'saving',8000)
GO
--查看结果理解自动提交事务
select * from Account
GO


/**************手动事务 ***/
begin try   --可能操作引发异常
     begin tran  --开启手动事务
		insert into Account values(4444,'saving',3000)
		insert into Account values(2222,'saving',null)
		insert into Account values(5555,'saving',8000)
     commit tran   --提交事务
end try
begin catch
   print error_number() +'  ' + error_Line() +'  ' + error_Message()
   rollback tran    --回滚事务
end catch
GO
---查看结果理解手动提交事务
select * from Account


/**************隐式事务**/
SET IMPLICIT_TRANSACTIONS ON
Create table BBB(A int)   
Go
  Declare @i int
  set @i=0
  while @i<10
   Begin
      insert into BBB values(@i)
      set @i = @i+1
   end
GO
rollback
Go
select * from BBB
SET IMPLICIT_TRANSACTIONS OFF


