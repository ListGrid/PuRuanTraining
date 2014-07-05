/*--------1.ϵͳ�洢���̵�ʹ��-----------*/
USE bbsDB
GO
EXEC sp_helpconstraint bbsUsers --�鿴��stuInfo��Լ��
EXEC sp_helpindex bbsUsers  --�鿴��stuMarks������
USE master
GO
EXEC xp_cmdshell 'mkdir d:\project\test', NO_OUTPUT  --�����ļ���D:\bank 
EXEC xp_cmdshell 'dir D:\project\' --�鿴�ļ���
GO

/*--------2.�������Ĵ洢����-----------*/

USE bbsDB
GO
/*
--��ѡ��������ĳ���û��ķ��������
--����ĳ���û��ķ���������������ͻ�����
*/
/*---����Ƿ���ڣ��洢���̴����ϵͳ��sysobjects��---*/
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'proc_find1' )
  DROP PROCEDURE  proc_find1
GO

CREATE PROCEDURE proc_find1
  @userName varchar(10)
   AS 
     SET NOCOUNT ON
     DECLARE @userID varchar(10)
     SELECT @userID=UID FROM bbsUsers WHERE Uname=@userName --��ȡ����������û����
     IF EXISTS(SELECT * FROM bbsTopic WHERE TuID=@userID)
        BEGIN
           print @userName+'�������������:'
           SELECT ����ʱ��=convert(varchar(10),Ttime,111),�����=TclickCount, 
             ����=Ttopic,����=Tcontents FROM bbsTopic WHERE TuID=@userID
        END
     ELSE
        print @userName+'û�з����������'
     IF EXISTS(SELECT * FROM bbsReply WHERE RuID=@userID)
        BEGIN
           print @userName+'����Ļ�������:'
           SELECT ����ʱ��=convert(varchar(10),Rtime,111),�����=RclickCount,
              ��������=Rcontents FROM bbsReply WHERE RuID=@userID
        END
     ELSE
        print @userName+'û�з����������'
GO

EXEC proc_find1 '�ɿ���'

/*--------3.������ֵ�Ĵ洢����-----------*/  
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'proc_find2' )
  DROP PROCEDURE  proc_find2
GO

CREATE PROCEDURE proc_find2
  @userName varchar(10),
  @sumTopic INT OUTPUT,
  @sumReply INT OUTPUT 
   AS 
     SET NOCOUNT ON
     DECLARE @userID varchar(10)
     SELECT @userID=UID FROM bbsUsers WHERE Uname=@userName --��ȡ����������û����
     IF EXISTS(SELECT * FROM bbsTopic WHERE TuID=@userID)
        BEGIN
           SELECT @sumTopic=count(*) FROM bbsTopic WHERE TuID=@userID
           print @userName+'�������������:'
           SELECT ����ʱ��=convert(varchar(10),Ttime,111),�����=TclickCount, 
             ����=Ttopic,����=Tcontents FROM bbsTopic WHERE TuID=@userID
        END
     ELSE
        BEGIN
           SET @sumTopic=0
           print @userName+'û�з����������'
        END
     IF EXISTS(SELECT * FROM bbsReply WHERE RuID=@userID)
        BEGIN
           SELECT @sumReply=count(*) FROM bbsReply WHERE RuID=@userID
           print @userName+'����Ļ�������:'
           SELECT ����ʱ��=convert(varchar(10),Rtime,111),�����=RclickCount,
              ��������=Rcontents FROM bbsReply WHERE RuID=@userID
        END
     ELSE
        BEGIN
           SET @sumReply=0
           print @userName+'û�з����������'
        END
GO

DECLARE @sum1 INT ,@sum2 INT
EXEC proc_find2 '�ɿ���',@sum1 OUTPUT,@sum2 OUTPUT
IF @sum1>=@sum2
   print 'С�ܷ����϶࣬�����Ƚ�ϲ���򱧲�ƽ��'
ELSE
   print 'С�ܻ����϶࣬�����ȽϹ������ڼ��࣡'

print '������: '+convert(varchar(5),@sum1+@sum2 )
GO


/*---------------
--��ʾĿǰ����������
SELECT �ǳ�=Uname,�Ǽ�=CASE
                         WHEN Uclass=0 THEN ' '
                         WHEN Uclass=1 THEN '��'
                         WHEN Uclass=2 THEN '���'
                         WHEN Uclass=3 THEN '����'
                         WHEN Uclass=4 THEN '�����'
                         WHEN Uclass=5 THEN '������'
                         ELSE               '�������'
                      END
   ,����=Upoint FROM bbsUsers
GO
---------------------------------------
SELECT * FROM BBSUsers  --�û���
SELECT * FROM bbsTopic    --������
SELECT * FROM bbsReply    --������
SELECT * FROM bbsSection  --����
--------------------*/
