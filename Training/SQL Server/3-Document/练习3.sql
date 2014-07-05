------------------------练习1----------------
USE bbsDB
GO
SET NOCOUNT ON
print '--->>>>>>>>>>>>各位大虾注意了,本论坛即将发布年度无记名评奖<<<<<<<<<<<<<<<<<<<<--'
--评估总体人气：如果论坛总点击率>1000,人气较旺
IF (SELECT SUM(SclickCount) FROM bbsSection)>1000 
  print '论坛人气年度评估：熊旺旺,大家辛苦了！'
ELSE
  print '论坛人气年度评估：一般般,大家加油啊！'
--评选品牌版块和倒胃版块：根据主帖数量评估
print '年度品牌版块：'
SELECT 版块名称=Sname,主帖数量=StopicCount,简介=Sprofile FROM bbsSection
   WHERE StopicCount=(SELECT MAX(StopicCount) FROM bbsSection)

print '年度倒胃版块：'
SELECT 版块名称=Sname,主帖数量=StopicCount,简介=Sprofile FROM bbsSection
   WHERE StopicCount=(SELECT MIN(StopicCount) FROM bbsSection)

--评选回贴人气最旺的前两名作者
print '年度回贴人气最IN的前两名获奖作者：'
SELECT 大名=Uname,星级=Uclass FROM bbsUsers 
  WHERE UID IN (SELECT TOP 2 TuID FROM bbsTopic ORDER BY TclickCount DESC)

--评选最差版主：如果存在发帖量为0的板块,列出对应的版块和版主信息
IF EXISTS (SELECT * FROM bbsSection WHERE StopicCount=0 OR SclickCount<=500)
  BEGIN 
    print '请下列版块的斑竹加加油哦！'
    SELECT 版块名称=Sname,主帖数量=StopicCount,点击率=SclickCount FROM bbsSection
       WHERE StopicCount=0 OR SclickCount<=500
 END
GO

------------------------练习2----------------
/*--发主贴:
心酸果冻在.Net技术版块发贴：
怯怯的问：什么是.Net啊？
微软的.Net广告超过半个北京城啊。。。
--*/
DECLARE @userID varchar(10),@sID INT --定义变量存放用户编号和版块编号
SELECT @userID=UID FROM bbsUsers WHERE Uname='心酸果冻' --获取心酸果冻的用户编号
SELECT @sID=SID FROM bbsSection WHERE Sname LIKE '%.Net技术%' ----获取.Net版块的编号
--插入主贴表
INSERT INTO bbsTopic (TsID,TuID,Tface,Ttopic,Tcontents)
  VALUES(@sID,@userID,3,'什么是.Net啊？','微软的.Net广告超过半个北京城啊。。。')
--更新版块表：.Net技术版块主贴数+1
UPDATE bbsSection SET StopicCount=StopicCount+1 WHERE SID=@sID
--更新用户的积分：如果是新主题,则积分增加100,否则增加50
IF NOT EXISTS (SELECT * FROM bbsTopic
      WHERE Ttopic LIKE '什么是.Net啊？' AND TuID<>@userID)
   UPDATE bbsUsers SET Upoint=Upoint+100 WHERE UID=@userID
ELSE
   UPDATE bbsUsers SET Upoint=Upoint+50 WHERE UID=@userID
---更新用户的积分后,更新相应的级别
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
--对外公告心酸果冻的发贴
SELECT 发贴作者='心酸果冻',发贴时间=convert(varchar(10),Ttime,111), 
    主题=Ttopic,内容=Tcontents FROM bbsTopic WHERE TID=@@IDENTITY
--显示目前的最新排名
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
-------------------------------------------------------------------




---------------------------------------
SELECT * FROM BBSUsers  --用户表
SELECT * FROM bbsTopic    --主贴表
SELECT * FROM bbsReply    --回帖表
SELECT * FROM bbsSection  --版块表
--------------------