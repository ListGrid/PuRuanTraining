int retry = 3;
        while (retry > 0)
        {
            try
            {
                //执行sql语句的代码
                //将重试次数变为0
                retry = 0;
            }
            catch(SqlException e)
            {
                //如果是死锁的话,0.5S后重试
                if(e.Number==1205)
                {
                    System.Threading.Thread.Sleep(500);
                    retry--;
                }
                //其它错误....
                else
                {
                    throw;
                }
            }
        }