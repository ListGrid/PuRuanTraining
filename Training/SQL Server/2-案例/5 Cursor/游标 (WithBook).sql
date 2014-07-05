/*
*  author: Mr.Yan  
*  Title: 游标示例
*  Date: 2006-11-15
*/

/**********************************************创建只进游标*/
use Y05
select * from employee
--创建只进游标
declare emp_cust cursor
Forward_ONLY
for select empno,ename,job,Sal from employee where deptno=20
-- 打开游标
open emp_cust 
--提取记录
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
 --尝试 
  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Prior from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--关闭游标
close emp_cust
--释放游标
Deallocate emp_cust
Go



/************************************创建静态游标*/
use Y05
--创建静态游标
declare emp_cust cursor
STATIC
for select empno,ename,job,Sal from employee where deptno=20
-- 打开游标
open emp_cust 
--提取记录
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
-- --尝试 向上读取
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch Prior from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----尝试定位到最后一行
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch last from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----尝试定位到第一行
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch first from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--尝试在游标中更新数据 （考虑执行结果）  
update employee 
  set  sal =3456 where  current of emp_cust
--关闭游标
close emp_cust
--释放游标
Deallocate emp_cust
Go

/************************************创建键集驱动游标*/
use Y05
--创建键集驱动游标
declare emp_cust cursor
KEYSET
for select empno,ename,job,Sal from employee where deptno=20
-- 打开游标
open emp_cust 
--提取记录
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
-- --尝试 向上读取
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch Prior from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----尝试定位到最后一行
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch last from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--尝试定位到第一行
  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch first from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--尝试在游标中更新数据 （考虑执行结果）  
update employee 
  set sal =3456 where  current of emp_cust
       --尝试打开新的查询窗口向表里添加一条部门为20的记录。
        --通过滚动游标查看结果。能看到吗?
--关闭游标
close emp_cust
--释放游标
Deallocate emp_cust
GO


/************************************创建动态游标*/
use Y05
--创建动态游标
declare emp_cust cursor
DYNAMIC
for select empno,ename,job,Sal from employee where deptno=20
-- 打开游标
open emp_cust 
--提取记录
 Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch Next from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
-- --尝试 向上读取
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch Prior from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
----尝试定位到最后一行
--  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
-- fetch last from emp_cust into @id,@name,@job,@sal
-- print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--尝试定位到第一行
  Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
 fetch first from emp_cust into @id,@name,@job,@sal
 print (@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
--尝试在游标中更新数据 （考虑执行结果）  
update employee 
  set  sal =8888 where  current of emp_cust
       --尝试打开新的查询窗口向表里添加一条部门为20的记录。
        --insert into employee values('9876','OWEN','FC','1010','2001-1-1',9000,20)
        --通过滚动游标查看结果。能看到吗?
--关闭游标
close emp_cust
--释放游标
Deallocate emp_cust
GO


--The End 同学们通过上面的例子理解4种游标类型的工作方式

/**与游标有关的两个全局变量 **/
   --@@Cursor_rows 结果返回的行数(动态游标永远返回-1,Why?)
   --@@Fetch_status 提取到记录返回0 相反返回-1
   --游标综合示例
use Y05
declare emp_cust cursor
STATIC
for select empno,ename,job,Sal from employee where deptno=20
GO
  open emp_cust 
  print '记录总数' +cast(@@Cursor_rows as varchar)  
GO
   Declare @id varchar(5),@name varchar(20),@job varchar(20),@sal smallmoney
   fetch Next from emp_cust into @id,@name,@job,@sal 
   WHILE @@Fetch_status=0
     Begin
      print(@id+'  '+@name+'  '+@job+'  '+Cast(@sal as varchar))
	  fetch Next from emp_cust into @id,@name,@job,@sal
    END
GO
--关闭游标
close emp_cust
--释放游标
Deallocate emp_cust
Go
