use pubs
go

create table students
  ( stu_id   int not null,
    stu_name varchar(20) not null,
    sex      char(2),
    age      int,
    dep      varchar(20)
  )
alter table students 
  add constraint pk_students_id
  primary key(stu_id)
alter table students 
  add constraint ck_students_age
  check(age between 16 and 40)

create table class
 ( class_id  int not null,
   class_name varchar(20) not null,
   teacher    varchar(20) 
  )
alter table class add constraint
  pk_class_id primary key(class_id)

create table grade 
  ( stu_id   int,
    class_id int,
    grade    int
   )
alter table grade add constraint
  fk_grade_stu_id foreign key(stu_id)
  references students(stu_id)

alter table grade add constraint
  fk_grade_class_id foreign key(class_id)
  references class(class_id)

alter table grade add constraint
  ck_grade check(grade between 0 and 100)

insert into students 
      values(101,'����','��',18,'�����')
insert into students
      values(102,'����','��',16,'��ѧ')
insert into students
      values(103,'����','Ů',17,'����')
insert into students
      values(105,'���','��',19,'�����')
insert into students
      values(109,'����','Ů',18,'��ʷ')
insert into students
      values(110,'��ƽ','��',20,'��ѧ') 


insert into class 
    values( 203,'����ϵͳ','����' )
insert into class 
    values( 279,'�ߵ���ѧ','����' )
insert into class 
    values( 210,'�ִ���ѧ','����' )
insert into class 
    values( 243,'�л���ѧ','��ͬ' )
insert into class 
    values( 204,'���ݽṹ','����' )  


insert into grade values( 101,203,82 )
insert into grade values( 105,203,59 )
insert into grade values( 102,279,90 )
insert into grade values( 101,279,88 )
insert into grade values( 105,279,82 ) 
insert into grade values( 110,279,68 )
insert into grade values( 109,210,72 )
insert into grade values( 103,210,90 )
insert into grade values( 110,243,92 )
insert into grade values( 101,204,85 )
insert into grade values( 105,204,91 )
insert into grade values( 102,204,56 )



select * from students
select * from class
select * from grade


--��1���1С��
select a.stu_name,c.grade,b.class_name 
from students a,class b,grade c
where a.stu_id=c.stu_id and
a.stu_name='����' and b.class_id
=c.class_id

--��1���2С��
select  stu_name from students
 where students.stu_id != all
(select distinct stu_id from grade 
where grade < 60)

--��2���3С��
select stu_name from
students a,class b,grade c
where a.stu_id=c.stu_id
and b.class_id=c.class_id
and b.teacher='����'

--��1���4С��
update grade set grade=
(select avg(grade) from 
grade where class_id=203
)
where class_id=203 and 
stu_id=105

--��1���5С��
select distinct stu_name
from students a,grade c
where a.stu_id=c.stu_id
and grade > 90

--��1���6С��
select stu_name from
students
where dep in (select dep
from students where
stu_name='����')
and stu_name not like '����'

--��1���7С��
delete from grade
where grade < 60