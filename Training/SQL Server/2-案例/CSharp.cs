int retry = 3;
        while (retry > 0)
        {
            try
            {
                //ִ��sql���Ĵ���
                //�����Դ�����Ϊ0
                retry = 0;
            }
            catch(SqlException e)
            {
                //����������Ļ�,0.5S������
                if(e.Number==1205)
                {
                    System.Threading.Thread.Sleep(500);
                    retry--;
                }
                //��������....
                else
                {
                    throw;
                }
            }
        }