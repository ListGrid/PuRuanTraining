/*��--------------����-----------------*/
USE bbsDB
GO
SET NOCOUNT ON
--�����ʻ���Ϣ��bank�ͽ�����Ϣ��transInfo
IF EXISTS(SELECT * FROM sysobjects WHERE name='bank')
   DROP TABLE bank
IF EXISTS(SELECT * FROM sysobjects WHERE name='transInfo')
   DROP TABLE transInfo
GO
CREATE TABLE bank  --�ʻ���Ϣ��
(
  customerName CHAR(8) NOT NULL,  --�˿�����
  cardID  CHAR(10) NOT NULL ,       --����
  currentMoney MONEY  NOT NULL     --��ǰ���
)
GO
CREATE TABLE transInfo  --������Ϣ��
(
  cardID  CHAR(10) NOT NULL,    --����
  transType  CHAR(4) NOT NULL,  --�������ͣ�����/֧ȡ��
  transMoney  MONEY NOT NULL,   --���׽��
  transDate  DATETIME NOT NULL, --��������
)
GO
/*---���Լ�����ʻ���������1Ԫ����������Ĭ��Ϊ��������----*/
ALTER TABLE bank
  ADD CONSTRAINT CK_currentMoney CHECK(currentMoney>=1)
ALTER TABLE transInfo
  ADD CONSTRAINT DF_transDate DEFAULT(getDate( )) FOR transDate,
      CONSTRAINT CK_transType CHECK( transType IN ('����','֧ȡ'))
GO
/*--����������ݣ������������������Ϊ1000 �����Ŀ������������1 ---*/
INSERT INTO bank(customerName,cardID,currentMoney) 
  VALUES('����','1001 0001',1000) --�����Ŀ��żٶ�Ϊ1001 0001
INSERT INTO bank(customerName,cardID,currentMoney)
  VALUES('����','1001 0002',1)  --���ĵĿ��żٶ�Ϊ1001 0002

print '---------ת��ǰ�����---------'
SELECT * FROM bank
GO


/*--��ʼ����ָ������Ӵ˴���ʼ��������T-SQL��䶼��һ������--*/
BEGIN TRANSACTION 
/*--��������������ۼ�����ִ�й����еĴ���--*/
DECLARE @errorSum INT ,@myMoney Money
SET @myMoney=800   --ת�ʽ��ٶ�Ϊ1000Ԫ
SET @errorSum=0  --��ʼ��Ϊ0�����޴���

/*--ת�ʣ�����ת��1000Ԫ�����ĵ��ʺ��ϡ�
  ��ʵ�е�ת���������ţ��������Ŀ���֧��1000Ԫ�����ĵĿ��Ŵ���1000Ԫ*/
--�����Ŀ���֧ȡ1000�������潻����Ϣ
INSERT INTO transInfo(cardID,transType,transMoney) --���潻����Ϣ
   VALUES('1001 0001','֧ȡ',@myMoney)
SET @errorSum=@errorSum+@@ERROR  --�ۼ��Ƿ��д���
UPDATE bank SET currentMoney=currentMoney-@myMoney    --�����ʻ����
   WHERE cardID='1001 0001'
SET @errorSum=@errorSum+@@ERROR  --�ۼ��Ƿ��д���

--���ĵĿ��Ŵ���1000Ԫ�������潻����Ϣ
INSERT INTO transInfo(cardID,transType,transMoney) --���潻����Ϣ
   VALUES('1001 0002','����',@myMoney)
SET @errorSum=@errorSum+@@ERROR  --�ۼ��Ƿ��д���
UPDATE bank SET currentMoney=currentMoney+@myMoney    --�����ʻ����
   WHERE cardID='1001 0002'
SET @errorSum=@errorSum+@@ERROR  --�ۼ��Ƿ��д���

print '--------ת����������е����ͽ�����Ϣ--------'
SELECT * FROM bank 
SELECT * FROM transInfo

/*--�����Ƿ��д���ȷ���������ύ���ǳ���---*/
IF @errorSum<>0  --����д���
  BEGIN
    print '����ʧ�ܣ��ع�����'
    ROLLBACK TRANSACTION 
  END  
ELSE
  BEGIN
    print '���׳ɹ����ύ����д��Ӳ�����õı���'
    COMMIT TRANSACTION   
  END
GO

print '--------ת���������������ͽ�����Ϣ--------'
SELECT * FROM bank 
SELECT * FROM transInfo 
GO
























