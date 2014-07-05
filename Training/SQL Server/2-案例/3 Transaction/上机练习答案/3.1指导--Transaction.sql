---3.1指导

---3.1.2 事务
--3.1.2.3显示事务

declare @stuid char(6),@couid char(3),@score decimal(4,1)
declare @credit int
set @stuid = '071001'
set @couid = 'B09'
set @score = 70
begin try
		begin tran
			insert into student_course values(@stuid,@couid,@score)
			if @score>=60
				begin 
					select  @credit = couCredit from course where couid = @couid
					update student set credit = credit + @credit where stuid = @stuid
				end 
		commit tran
end try 
begin catch
	rollback tran
end catch
select * from student