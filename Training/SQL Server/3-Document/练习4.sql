/*－--------------建表-----------------*/
USE bbsDB
GO
SET NOCOUNT ON
--创建帐户信息表bank和交易信息表transInfo
IF EXISTS(SELECT * FROM sysobjects WHERE name='bank')
   DROP TABLE bank
IF EXISTS(SELECT * FROM sysobjects WHERE name='transInfo')
   DROP TABLE transInfo
GO
CREATE TABLE bank  --帐户信息表
(
  customerName CHAR(8) NOT NULL,  --顾客姓名
  cardID  CHAR(10) NOT NULL ,       --卡号
  currentMoney MONEY  NOT NULL     --当前余额
)
GO
CREATE TABLE transInfo  --交易信息表
(
  cardID  CHAR(10) NOT NULL,    --卡号
  transType  CHAR(4) NOT NULL,  --交易类型（存入/支取）
  transMoney  MONEY NOT NULL,   --交易金额
  transDate  DATETIME NOT NULL, --交易日期
)
GO
/*---添加约束：帐户余额不能少于1元，交易日期默认为当天日期----*/
ALTER TABLE bank
  ADD CONSTRAINT CK_currentMoney CHECK(currentMoney>=1)
ALTER TABLE transInfo
  ADD CONSTRAINT DF_transDate DEFAULT(getDate( )) FOR transDate,
      CONSTRAINT CK_transType CHECK( transType IN ('存入','支取'))
GO
/*--插入测试数据：张三开户，开户金额为1000 ；李四开户，开户金额1 ---*/
INSERT INTO bank(customerName,cardID,currentMoney) 
  VALUES('张三','1001 0001',1000) --张三的卡号假定为1001 0001
INSERT INTO bank(customerName,cardID,currentMoney)
  VALUES('李四','1001 0002',1)  --李四的卡号假定为1001 0002

print '---------转帐前的余额---------'
SELECT * FROM bank
GO


/*--开始事务（指定事务从此处开始，后续的T-SQL语句都是一个整体--*/
BEGIN TRANSACTION 
/*--定义变量，用于累计事务执行过程中的错误--*/
DECLARE @errorSum INT ,@myMoney Money
SET @myMoney=800   --转帐金额假定为1000元
SET @errorSum=0  --初始化为0，即无错误

/*--转帐：张三转帐1000元到李四的帐号上。
  现实中的转帐依靠卡号，即张三的卡号支出1000元，李四的卡号存入1000元*/
--张三的卡号支取1000，并保存交易信息
INSERT INTO transInfo(cardID,transType,transMoney) --保存交易信息
   VALUES('1001 0001','支取',@myMoney)
SET @errorSum=@errorSum+@@ERROR  --累计是否有错误
UPDATE bank SET currentMoney=currentMoney-@myMoney    --更新帐户余额
   WHERE cardID='1001 0001'
SET @errorSum=@errorSum+@@ERROR  --累计是否有错误

--李四的卡号存入1000元，并保存交易信息
INSERT INTO transInfo(cardID,transType,transMoney) --保存交易信息
   VALUES('1001 0002','存入',@myMoney)
SET @errorSum=@errorSum+@@ERROR  --累计是否有错误
UPDATE bank SET currentMoney=currentMoney+@myMoney    --更新帐户余额
   WHERE cardID='1001 0002'
SET @errorSum=@errorSum+@@ERROR  --累计是否有错误

print '--------转帐事务过程中的余额和交易信息--------'
SELECT * FROM bank 
SELECT * FROM transInfo

/*--根据是否有错误，确定事务是提交还是撤销---*/
IF @errorSum<>0  --如果有错误
  BEGIN
    print '交易失败，回滚事务'
    ROLLBACK TRANSACTION 
  END  
ELSE
  BEGIN
    print '交易成功，提交事务，写入硬盘永久的保存'
    COMMIT TRANSACTION   
  END
GO

print '--------转帐事务结束后的余额和交易信息--------'
SELECT * FROM bank 
SELECT * FROM transInfo 
GO
























