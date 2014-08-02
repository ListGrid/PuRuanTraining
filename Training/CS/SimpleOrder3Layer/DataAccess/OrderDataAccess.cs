using System;
using System.Data.Common;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace KS201008.DataAccess
{

    public class OrderDataAccess
    {
        public static OrderData Select(int orderID)
        {
            string strSQL = @"select * from SalesOrder where OrderID = @OrderID ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, orderID);

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                if (reader.Read())
                {
                    OrderData obj = new OrderData();
                    obj.Fill(reader);
                    return obj;
                }
            }
            return null;
        }

        public static void Save(OrderData obj)
        {
            if (Update(obj) == 0)
            {
                Insert(obj);
            }
        }

        public static int Insert(OrderData obj)
        {
            Database db = DatabaseFactory.CreateDatabase();
            string strSQL = @"insert into SalesOrder " + 
                            @" (CustomerID, DocDate, DocTotal) "+
                            @" values(@CustomerID, @DocDate, @DocTotal); " +
                            @" select  CAST(@@IDENTITY AS int);";

            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, obj.CustomerID);
            db.AddInParameter(cmd, "@DocDate", System.Data.DbType.DateTime, obj.DocDate);
            db.AddInParameter(cmd, "@DocTotal", System.Data.DbType.Currency, obj.DocTotal);

            obj.OrderID = (int)db.ExecuteScalar(cmd);
            return obj.OrderID;
        }

        public static int Update(OrderData obj)
        {
            string strSQL = @"update SalesOrder " + 
                            @" set CustomerID = @CustomerID, DocDate = @DocDate, DocTotal = @DocTotal "+
                            @" where OrderID = @OrderID  ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, obj.OrderID);
            db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, obj.CustomerID);
            db.AddInParameter(cmd, "@DocDate", System.Data.DbType.DateTime, obj.DocDate);
            db.AddInParameter(cmd, "@DocTotal", System.Data.DbType.Currency, obj.DocTotal);

            return db.ExecuteNonQuery(cmd);
        }
        public static void Delete(int orderID)
        {
            string strSQL = @"delete SalesOrder where OrderID = @OrderID ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, orderID);

            db.ExecuteNonQuery(cmd);
        }

        public static IList<OrderData> SelectAll()
        {
            string strSQL = @"select * from SalesOrder ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            IList<OrderData> objs = new List<OrderData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    OrderData obj = new OrderData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }
        public static IList<OrderData> SelectWithCondition(string strCondition)
        {
            string strSQL = @"select * from SalesOrder " + strCondition;

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            IList<OrderData> objs = new List<OrderData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    OrderData obj = new OrderData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }

        public static IList<int> SelectAllOrderIDs()
        {
            List<int> myList = new List<int>();
            string strSQL = @"select OrderID from SalesOrder order by OrderID";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    myList.Add((int)reader["OrderID"]);
                }
            }

            return myList;
        }
    }
}
