------------------------��ϰ1----------------
USE bbsDB
GO
SET NOCOUNT ON
print '--->>>>>>>>>>>>��λ��Ϻע����,����̳������������޼�������<<<<<<<<<<<<<<<<<<<<--'
--�������������������̳�ܵ����>1000,��������
IF (SELECT SUM(SclickCount) FROM bbsSection)>1000 
  print '��̳�������������������,��������ˣ�'
ELSE
  print '��̳�������������һ���,��Ҽ��Ͱ���'
--��ѡƷ�ư��͵�θ��飺����������������
print '���Ʒ�ư�飺'
SELECT �������=Sname,��������=StopicCount,���=Sprofile FROM bbsSection
   WHERE StopicCount=(SELECT MAX(StopicCount) FROM bbsSection)

print '��ȵ�θ��飺'
SELECT �������=Sname,��������=StopicCount,���=Sprofile FROM bbsSection
   WHERE StopicCount=(SELECT MIN(StopicCount) FROM bbsSection)

--��ѡ��������������ǰ��������
print '��Ȼ���������IN��ǰ���������ߣ�'
SELECT ����=Uname,�Ǽ�=Uclass FROM bbsUsers 
  WHERE UID IN (SELECT TOP 2 TuID FROM bbsTopic ORDER BY TclickCount DESC)

--��ѡ��������������ڷ�����Ϊ0�İ��,�г���Ӧ�İ��Ͱ�����Ϣ
IF EXISTS (SELECT * FROM bbsSection WHERE StopicCount=0 OR SclickCount<=500)
  BEGIN 
    print '�����а��İ���Ӽ���Ŷ��'
    SELECT �������=Sname,��������=StopicCount,�����=SclickCount FROM bbsSection
       WHERE StopicCount=0 OR SclickCount<=500
 END
GO

------------------------��ϰ2----------------
/*--������:
���������.Net������鷢����
���ӵ��ʣ�ʲô��.Net����
΢���.Net��泬����������ǰ�������
--*/
DECLARE @userID varchar(10),@sID INT --�����������û���źͰ����
SELECT @userID=UID FROM bbsUsers WHERE Uname='�������' --��ȡ����������û����
SELECT @sID=SID FROM bbsSection WHERE Sname LIKE '%.Net����%' ----��ȡ.Net���ı��
--����������
INSERT INTO bbsTopic (TsID,TuID,Tface,Ttopic,Tcontents)
  VALUES(@sID,@userID,3,'ʲô��.Net����','΢���.Net��泬����������ǰ�������')
--���°���.Net�������������+1
UPDATE bbsSection SET StopicCount=StopicCount+1 WHERE SID=@sID
--�����û��Ļ��֣������������,���������100,��������50
IF NOT EXISTS (SELECT * FROM bbsTopic
      WHERE Ttopic LIKE 'ʲô��.Net����' AND TuID<>@userID)
   UPDATE bbsUsers SET Upoint=Upoint+100 WHERE UID=@userID
ELSE
   UPDATE bbsUsers SET Upoint=Upoint+50 WHERE UID=@userID
---�����û��Ļ��ֺ�,������Ӧ�ļ���
UPDATE bbsUsers 
  SET Uclass=CASE
                WHEN Upoint <500 THEN 1
                WHEN Upoint BETWEEN 500 AND 1000 THEN 2
                WHEN Upoint BETWEEN 1001 AND 2000 THEN 3
                WHEN Upoint BETWEEN 2001 AND 4000 THEN 4
                WHEN Upoint BETWEEN 4001 AND 5000 THEN 5
                ELSE 6
             END
   WHERE UID=@userID
--���⹫����������ķ���
SELECT ��������='�������',����ʱ��=convert(varchar(10),Ttime,111), 
    ����=Ttopic,����=Tcontents FROM bbsTopic WHERE TID=@@IDENTITY
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
-------------------------------------------------------------------




---------------------------------------
SELECT * FROM BBSUsers  --�û���
SELECT * FROM bbsTopic    --������
SELECT * FROM bbsReply    --������
SELECT * FROM bbsSection  --����
--------------------