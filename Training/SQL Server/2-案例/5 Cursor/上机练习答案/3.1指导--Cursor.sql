---3.1ָ��

--3.1.1�α�
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
fetch absolute 3 from cursor_cou --ȡ������ĵ�3������
fetch relative 2 from cursor_cou--ȡ��Ե�ǰ�еĵ�2��

fetch prior from cursor_cou -- ȡ��ǰ�е���һ������

close cursor_cou
deallocate cursor_cou

--3��1.1.2  ����ֻ���α�
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
			print @stuName + 'ȱ��'
		else if @score >= 60
			print @stuName + '����'
		else print @stuName + '������'
		fetch next from cursor_stu into @stuName,@score
	end

close cursor_stu
deallocate cursor_stu

go

--3.1.1.3ʹ���α��������

set nocount on --�����ؼ�����T-SQL���Ӱ���������
go
declare @name char(20) ,@credit int
declare cursor_cou cursor scroll keyset
for 
select couName , couCredit from course
where couId like 'C%'

open cursor_cou

print '����ǰ�α��е�����'
fetch next from cursor_cou into @name,@credit
while @@fetch_status = 0
	begin 
		print @name + cast(@credit as varchar)
		update course set couCredit = couCredit +1 where current of cursor_cou
     fetch next from cursor_cou into @name,@credit
  end

print'���º��α��е�����'
fetch first from cursor_cou into @name,@credit
while @@fetch_status = 0
	begin 
		print @name + cast(@credit as varchar)
		fetch next from cursor_cou into @name,@credit
  end
close cursor_cou
deallocate cursor_cou

