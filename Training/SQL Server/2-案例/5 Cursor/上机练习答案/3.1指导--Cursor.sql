---3.1指导

--3.1.1游标
use study
go
declare cursor_cou cursor scroll
for
select couName,couHour,couCredit
from course where couId like'B%'

open cursor_cou
fetch next from cursor_cou 
fetch first from cursor_cou
fetch last from cursor_cou
fetch absolute 3 from cursor_cou --取结果集的第3行数据
fetch relative 2 from cursor_cou--取相对当前行的第2行

fetch prior from cursor_cou -- 取当前行的上一条数据

close cursor_cou
deallocate cursor_cou

--3。1.1.2  创建只进游标
go
declare @stuName varchar(20) ,@score decimal(4,1)
declare cursor_stu cursor forward_only
for
select stuName ,score 
from student s left join student_course sc
on s.stuid = sc.stuid and couId = 'A02'
where majorId = 1
open cursor_stu
fetch next from cursor_stu into @stuName,@score
while @@fetch_status = 0
	begin
		if @score is null
			print @stuName + '缺考'
		else if @score >= 60
			print @stuName + '及格'
		else print @stuName + '不及格'
		fetch next from cursor_stu into @stuName,@score
	end

close cursor_stu
deallocate cursor_stu

go

--3.1.1.3使用游标更新数据

set nocount on --不返回计数（T-SQL语句影响的行数）
go
declare @name char(20) ,@credit int
declare cursor_cou cursor scroll keyset
for 
select couName , couCredit from course
where couId like 'C%'

open cursor_cou

print '更新前游标中的数据'
fetch next from cursor_cou into @name,@credit
while @@fetch_status = 0
	begin 
		print @name + cast(@credit as varchar)
		update course set couCredit = couCredit +1 where current of cursor_cou
     fetch next from cursor_cou into @name,@credit
  end

print'更新后游标中的数据'
fetch first from cursor_cou into @name,@credit
while @@fetch_status = 0
	begin 
		print @name + cast(@credit as varchar)
		fetch next from cursor_cou into @name,@credit
  end
close cursor_cou
deallocate cursor_cou

