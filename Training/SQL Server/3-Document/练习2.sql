/*------使用系统变量，查询数据库系统情况-----*/
print 'SQL Server的版本: '+@@VERSION 
print  '服务器的名称: '+@@SERVERNAME   
UPDATE bbsUsers SET Upassword ='1234' WHERE Uname='可卡因' --密码违反约束
print '执行上条语句产生的错误号： '+convert(varchar(5),@@ERROR) 
GO
/*---------使用变量和IF-ELSE语句----------*/
--网上有人举报，可卡因涉嫌发表不合法言论，版主查看可卡因的情况
SET NOCOUNT ON
print '' --为了显示方便，打印一空行
print '个人资料如下'
SELECT 昵称=Uname,等级=Uclass,个人说明=Uremark,积分=Upoint 
   FROM bbsUsers WHERE Uname='可卡因'
DECLARE @userID INT,@point INT
SELECT @userID=UID ,@point=Upoint FROM bbsUsers WHERE Uname='可卡因'
print '可卡因发贴如下：'
SELECT 发贴时间=convert(varchar(10),Ttime,111),点击率=TclickCount, 
  主题=Ttopic,内容=Tcontents FROM bbsTopic WHERE TuID=@userID
print '可卡因回贴如下：'
SELECT 回贴时间=convert(varchar(10),Rtime,111),点击率=RclickCount,
   回贴内容=Rcontents FROM bbsReply WHERE RuID=@userID
IF (@point>30)
   print '可卡因的权限：有权发贴'
ELSE
   print '可卡因的权限：无权发贴'
GO

/*-------使用WHILE循环语句和CASE－END多分支语句-------*/
--鉴于目前的星级用户偏少，用户普遍因积分较少而发贴热情不高，这也间接影响了论坛的人气
print '开始提分，请稍后.....'
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
print '提升分值：'+convert(varchar(8),@score)
UPDATE bbsUsers 
  SET Uclass=CASE
                WHEN Upoint <500 THEN 1
                WHEN Upoint BETWEEN 500 AND 1000 THEN 2
                WHEN Upoint BETWEEN 1001 AND 2000 THEN 3
                WHEN Upoint BETWEEN 2001 AND 4000 THEN 4
                WHEN Upoint BETWEEN 4001 AND 5000 THEN 5
                ELSE 6
             END
print '-------------加分后的用户级别情况--------------'
SELECT 昵称=Uname,星级=CASE
                         WHEN Uclass=0 THEN ' '
                         WHEN Uclass=1 THEN '★'
                         WHEN Uclass=2 THEN '★★'
                         WHEN Uclass=3 THEN '★★★'
                         WHEN Uclass=4 THEN '★★★★'
                         WHEN Uclass=5 THEN '★★★★★'
                         ELSE               '★★★★★★'
                      END
   ,积分=Upoint FROM bbsUsers
GO

/*------------练习部分---------------------*/
--1.查询心酸果冻的发贴数信息，具体的发贴内容
SET NOCOUNT ON
DECLARE @userID INT,@amount INT,@temp INT,@grade varchar(10)
SELECT @userID=UID FROM bbsUsers WHERE Uname='心酸果冻'
SELECT @temp=count(*) FROM bbsTopic WHERE TuID=@userID
SET @amount=@temp
IF @temp>0
  BEGIN 
    print '心酸果冻发贴数: '+convert(varchar(3),@temp)+'，贴子如下：'
    SELECT 发贴时间=convert(varchar(10),Ttime,111),点击率=TclickCount, 
        主题=Ttopic,内容=Tcontents FROM bbsTopic WHERE TuID=@userID
  END
ELSE
    print '心酸果冻发贴数: 0'
------------------------------------------------------------
SELECT @temp=count(*) FROM bbsReply WHERE RuID=@userID
IF @temp>0
  BEGIN 
    print '心酸果冻回贴数: '+convert(varchar(3),@temp)+'，贴子如下：'
    SELECT 回贴时间=convert(varchar(10),Rtime,111),点击率=RclickCount,
         回贴内容=Rcontents FROM bbsReply WHERE RuID=@userID
  END
ELSE
    print '心酸果冻回贴数: 0'

SET @amount=@amount+@temp
SELECT @grade=CASE 
               WHEN @amount<10                THEN  '新手上路'
               WHEN @amount BETWEEN 10 AND 20 THEN  '侠客'
               WHEN @amount BETWEEN 21 AND 30 THEN  '骑士'
               WHEN @amount BETWEEN 31 AND 40 THEN  '精灵王'
               WHEN @amount BETWEEN 41 AND 50 THEN  '光明使者'
               ELSE                                 '法老'
              END
print ''
print '心酸果冻贴数总计：'+convert(varchar(5),@amount)+' 贴'+'  功臣级别：'+@grade
GO
----------------------------------------------------------------
/*------------作业部分：查询第一精华贴的信息及回帖信息-----------*/
SET NOCOUNT ON
DECLARE @userID INT,@topicID INT,@userName varchar(10),@amount INT
SELECT TOP 1 @userID=TuID,@topicID=TID ,@amount=TReplyCount FROM bbsTopic 
    ORDER BY TclickCount DESC
SELECT @userName=Uname FROM bbsUsers WHERE UID=@userID
print '第一精华贴的信息如下：'
SELECT 发贴时间=convert(varchar(10),Ttime,111),点击率=TclickCount, 
  作者=@userName,主题=Ttopic,内容=Tcontents FROM bbsTopic WHERE TuID=@userID
print '回贴数：'+convert(varchar(5),@amount)+'贴，如下所示：'
SELECT 回贴时间=convert(varchar(10),Rtime,111),点击率=RclickCount,
    回帖表情=CASE 
               WHEN Rface=1 THEN '^(oo)猪头^'      
               WHEN Rface=2 THEN '*:o)小丑'   
               WHEN Rface=3 THEN '[:|]机器人'   
               WHEN Rface=4 THEN '{^o~o^}老人家'   
               ELSE              ':<)吹水大王'    
            END    
    ,回贴内容=Rcontents FROM bbsReply WHERE RtID=@topicID
GO
             

/*---------------------------------------
SELECT * FROM BBSUsers  --用户表
SELECT * FROM bbsTopic    --主贴表
SELECT * FROM bbsReply    --回帖表
SELECT * FROM bbsSection  --版块表
--------------------*/
