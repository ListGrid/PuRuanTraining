Create table locktest(
	id int primary key,
	name varchar(29) not null
)
insert into locktest values(1,'bill')
insert into locktest values(2,'mary')
insert into locktest values(3,'jack')


--������ݿ��ڲ�������ʱ����������
/*
*	������: ���� (S) �������������ȡ (SELECT) һ����Դ��
*   ��Դ�ϴ��ڹ��� (S) ��ʱ���κ��������񶼲����޸����ݡ�
*   һ���Ѿ���ȡ���ݣ��������ͷ���Դ�ϵĹ��� (S) ����
*   ���ǽ�������뼶������Ϊ���ظ�������߼���
*   ����������������������������ʾ�������� (S) ����
*/

--���뼶�����
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
use Y05
Go
Begin tran
   select * from locktest  where id=1 
   --���Դ�һ�����û��Ĳ�ѯִ�и���
       update locktest set name = 'Yao' where id=1 
commit tran

--������ʾ��
Create table locktest(
	id int primary key,
	name varchar(29) not null
)
Begin tran
	insert into locktest values(1,'bill')
--commit tran
--��һ���µĲ�ѯ����
Select * from locktest






--ע��: �������ݿ��һ��������� 

SELECT * FROM table WITH (HOLDLOCK) ����������Զ�ȡ�������ܸ���ɾ�� 

SELECT * FROM table WITH (TABLOCKX) ���������ܶ�ȡ��,���º�ɾ��

