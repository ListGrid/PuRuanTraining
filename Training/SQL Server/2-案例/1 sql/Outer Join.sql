--可以是不同的任意两张表，通常是有主外键关系的字段匹配

select * from DutyStaff A FULL/RIGHT/LEFT outer join Employees B on A.StaffName = B.LastName