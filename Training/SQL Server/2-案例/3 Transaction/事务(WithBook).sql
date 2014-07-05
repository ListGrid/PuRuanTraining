/*
*  author: 
*  Title: ����ʾ��
*  Date: 
*/


/*�Զ��ύ���� */
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
--�鿴�������Զ��ύ����
select * from Account
GO


/**************�ֶ����� ***/
begin try   --���ܲ��������쳣
     begin tran  --�����ֶ�����
		insert into Account values(4444,'saving',3000)
		insert into Account values(2222,'saving',null)
		insert into Account values(5555,'saving',8000)
     commit tran   --�ύ����
end try
begin catch
   print error_number() +'  ' + error_Line() +'  ' + error_Message()
   rollback tran    --�ع�����
end catch
GO
---�鿴�������ֶ��ύ����
select * from Account


/**************��ʽ����**/
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


