/*------ʹ��ϵͳ��������ѯ���ݿ�ϵͳ���-----*/
print 'SQL Server�İ汾: '+@@VERSION 
print  '������������: '+@@SERVERNAME   
UPDATE bbsUsers SET Upassword ='1234' WHERE Uname='�ɿ���' --����Υ��Լ��
print 'ִ�������������Ĵ���ţ� '+convert(varchar(5),@@ERROR) 
GO
/*---------ʹ�ñ�����IF-ELSE���----------*/
--�������˾ٱ����ɿ������ӷ����Ϸ����ۣ������鿴�ɿ�������
SET NOCOUNT ON
print '' --Ϊ����ʾ���㣬��ӡһ����
print '������������'
SELECT �ǳ�=Uname,�ȼ�=Uclass,����˵��=Uremark,����=Upoint 
   FROM bbsUsers WHERE Uname='�ɿ���'
DECLARE @userID INT,@point INT
SELECT @userID=UID ,@point=Upoint FROM bbsUsers WHERE Uname='�ɿ���'
print '�ɿ��������£�'
SELECT ����ʱ��=convert(varchar(10),Ttime,111),�����=TclickCount, 
  ����=Ttopic,����=Tcontents FROM bbsTopic WHERE TuID=@userID
print '�ɿ���������£�'
SELECT ����ʱ��=convert(varchar(10),Rtime,111),�����=RclickCount,
   ��������=Rcontents FROM bbsReply WHERE RuID=@userID
IF (@point>30)
   print '�ɿ����Ȩ�ޣ���Ȩ����'
ELSE
   print '�ɿ����Ȩ�ޣ���Ȩ����'
GO

/*-------ʹ��WHILEѭ������CASE��END���֧���-------*/
--����Ŀǰ���Ǽ��û�ƫ�٣��û��ձ�����ֽ��ٶ��������鲻�ߣ���Ҳ���Ӱ������̳������
print '��ʼ��֣����Ժ�.....'
DECLARE @score INT,@avg INT
SET @score=0
WHILE (1=1)
  BEGIN
    UPDATE bbsUsers SET Upoint=Upoint+50 WHERE Ustate<>4
    SET @score=@score+50
    SELECT @avg=AVG(Upoint) FROM bbsUsers
    IF (@avg>2000)
      BREAK
  END
print '������ֵ��'+convert(varchar(8),@score)
UPDATE bbsUsers 
  SET Uclass=CASE
                WHEN Upoint <500 THEN 1
                WHEN Upoint BETWEEN 500 AND 1000 THEN 2
                WHEN Upoint BETWEEN 1001 AND 2000 THEN 3
                WHEN Upoint BETWEEN 2001 AND 4000 THEN 4
                WHEN Upoint BETWEEN 4001 AND 5000 THEN 5
                ELSE 6
             END
print '-------------�ӷֺ���û��������--------------'
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

/*------------��ϰ����---------------------*/
--1.��ѯ��������ķ�������Ϣ������ķ�������
SET NOCOUNT ON
DECLARE @userID INT,@amount INT,@temp INT,@grade varchar(10)
SELECT @userID=UID FROM bbsUsers WHERE Uname='�������'
SELECT @temp=count(*) FROM bbsTopic WHERE TuID=@userID
SET @amount=@temp
IF @temp>0
  BEGIN 
    print '�������������: '+convert(varchar(3),@temp)+'���������£�'
    SELECT ����ʱ��=convert(varchar(10),Ttime,111),�����=TclickCount, 
        ����=Ttopic,����=Tcontents FROM bbsTopic WHERE TuID=@userID
  END
ELSE
    print '�������������: 0'
------------------------------------------------------------
SELECT @temp=count(*) FROM bbsReply WHERE RuID=@userID
IF @temp>0
  BEGIN 
    print '�������������: '+convert(varchar(3),@temp)+'���������£�'
    SELECT ����ʱ��=convert(varchar(10),Rtime,111),�����=RclickCount,
         ��������=Rcontents FROM bbsReply WHERE RuID=@userID
  END
ELSE
    print '�������������: 0'

SET @amount=@amount+@temp
SELECT @grade=CASE 
               WHEN @amount<10                THEN  '������·'
               WHEN @amount BETWEEN 10 AND 20 THEN  '����'
               WHEN @amount BETWEEN 21 AND 30 THEN  '��ʿ'
               WHEN @amount BETWEEN 31 AND 40 THEN  '������'
               WHEN @amount BETWEEN 41 AND 50 THEN  '����ʹ��'
               ELSE                                 '����'
              END
print ''
print '������������ܼƣ�'+convert(varchar(5),@amount)+' ��'+'  ��������'+@grade
GO
----------------------------------------------------------------
/*------------��ҵ���֣���ѯ��һ����������Ϣ��������Ϣ-----------*/
SET NOCOUNT ON
DECLARE @userID INT,@topicID INT,@userName varchar(10),@amount INT
SELECT TOP 1 @userID=TuID,@topicID=TID ,@amount=TReplyCount FROM bbsTopic 
    ORDER BY TclickCount DESC
SELECT @userName=Uname FROM bbsUsers WHERE UID=@userID
print '��һ����������Ϣ���£�'
SELECT ����ʱ��=convert(varchar(10),Ttime,111),�����=TclickCount, 
  ����=@userName,����=Ttopic,����=Tcontents FROM bbsTopic WHERE TuID=@userID
print '��������'+convert(varchar(5),@amount)+'����������ʾ��'
SELECT ����ʱ��=convert(varchar(10),Rtime,111),�����=RclickCount,
    ��������=CASE 
               WHEN Rface=1 THEN '^(oo)��ͷ^'      
               WHEN Rface=2 THEN '*:o)С��'   
               WHEN Rface=3 THEN '[:|]������'   
               WHEN Rface=4 THEN '{^o~o^}���˼�'   
               ELSE              ':<)��ˮ����'    
            END    
    ,��������=Rcontents FROM bbsReply WHERE RtID=@topicID
GO
             

/*---------------------------------------
SELECT * FROM BBSUsers  --�û���
SELECT * FROM bbsTopic    --������
SELECT * FROM bbsReply    --������
SELECT * FROM bbsSection  --����
--------------------*/
