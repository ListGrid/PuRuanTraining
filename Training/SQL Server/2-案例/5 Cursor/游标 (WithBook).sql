/*
*  author: Mr.Yan  
*  Title: �α�ʾ��
*  Date: 2006-11-15
*/

/**********************************************����ֻ���α�*/
use Y05
select * from employee
--����ֻ���α�
declare emp_cust cursor
Forward_ONLY
for select empno,ename,job,Sal from employee where deptno=20
-- ���α�
open emp_cust 
--��ȡ��¼
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
 --���� 
  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Prior from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--�ر��α�
close emp_cust
--�ͷ��α�
Deallocate emp_cust
Go



/************************************������̬�α�*/
use Y05
--������̬�α�
declare emp_cust cursor
STATIC
for select empno,ename,job,Sal from employee where deptno=20
-- ���α�
open emp_cust 
--��ȡ��¼
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
-- --���� ���϶�ȡ
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch Prior from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----���Զ�λ�����һ��
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch last from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----���Զ�λ����һ��
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch first from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--�������α��и������� ������ִ�н����  
update employee 
  set  sal =3456 where  current of emp_cust
--�ر��α�
close emp_cust
--�ͷ��α�
Deallocate emp_cust
Go

/************************************�������������α�*/
use Y05
--�������������α�
declare emp_cust cursor
KEYSET
for select empno,ename,job,Sal from employee where deptno=20
-- ���α�
open emp_cust 
--��ȡ��¼
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
-- --���� ���϶�ȡ
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch Prior from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----���Զ�λ�����һ��
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch last from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--���Զ�λ����һ��
  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch first from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--�������α��и������� ������ִ�н����  
update employee 
  set sal =3456 where  current of emp_cust
       --���Դ��µĲ�ѯ������������һ������Ϊ20�ļ�¼��
        --ͨ�������α�鿴������ܿ�����?
--�ر��α�
close emp_cust
--�ͷ��α�
Deallocate emp_cust
GO


/************************************������̬�α�*/
use Y05
--������̬�α�
declare emp_cust cursor
DYNAMIC
for select empno,ename,job,Sal from employee where deptno=20
-- ���α�
open emp_cust 
--��ȡ��¼
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
-- --���� ���϶�ȡ
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch Prior from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----���Զ�λ�����һ��
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch last from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--���Զ�λ����һ��
  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch first from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--�������α��и������� ������ִ�н����  
update employee 
  set  sal =8888 where  current of emp_cust
       --���Դ��µĲ�ѯ������������һ������Ϊ20�ļ�¼��
        --insert into employee values('9876','OWEN','FC','1010','2001-1-1',9000,20)
        --ͨ�������α�鿴������ܿ�����?
--�ر��α�
close emp_cust
--�ͷ��α�
Deallocate emp_cust
GO


--The End ͬѧ��ͨ��������������4���α����͵Ĺ�����ʽ

/**���α��йص�����ȫ�ֱ��� **/
   --@@Cursor_rows ������ص�����(��̬�α���Զ����-1,Why?)
   --@@Fetch_status ��ȡ����¼����0 �෴����-1
   --�α��ۺ�ʾ��
use Y05
declare emp_cust cursor
STATIC
for select empno,ename,job,Sal from employee where deptno=20
GO
  open emp_cust 
  print '��¼����' +cast(@@Cursor_rows as varchar)  
GO
   Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
   fetch Next from emp_cust into @id,@name,@job,@sal 
   WHILE @@Fetch_status=0
     Begin
      print(@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
	  fetch Next from emp_cust into @id,@name,@job,@sal
    END
GO
--�ر��α�
close emp_cust
--�ͷ��α�
Deallocate emp_cust
Go
