using System.Collections.Generic;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace KS201008.DataAccess
{
    public class OrderLineDataAccess
    {
        public static OrderLineData Select(int orderID, int lineID)
        {
            string strSQL = @"select * from OrderLine where OrderID = @OrderID and LineID = @LineID ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, orderID);
            db.AddInParameter(cmd, "@LineID", System.Data.DbType.Int32, lineID);

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                if (reader.Read())
                {
                    OrderLineData obj = new OrderLineData();
                    obj.Fill(reader);
                    return obj;
                }
            }
            return null;
        }

        public static void Save(OrderLineData obj)
        {
            if (Update(obj) == 0)
            {
                Insert(obj);
            }
        }

        public static int Insert(OrderLineData obj)
        {
            Database db = DatabaseFactory.CreateDatabase();
            string strSQL = @"insert into OrderLine " + 
                            @" (OrderID, LineID, Product, Price, Quantity, LineTotal) "+
                            @" values(@OrderID, @LineID, @Product, @Price, @Quantity, @LineTotal); " +
                            @" select  @@IDENTITY;";

            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, obj.OrderID);
            db.AddInParameter(cmd, "@LineID", System.Data.DbType.Int32, obj.LineID);
            db.AddInParameter(cmd, "@Product", System.Data.DbType.String, obj.Product);
            db.AddInParameter(cmd, "@Price", System.Data.DbType.Currency, obj.Price);
            db.AddInParameter(cmd, "@Quantity", System.Data.DbType.Int32, obj.Quantity);
            db.AddInParameter(cmd, "@LineTotal", System.Data.DbType.Currency, obj.LineTotal);

            obj.OrderID = (int)db.ExecuteScalar(cmd);
            return obj.OrderID;
        }
        public static int Update(OrderLineData obj)
        {
            string strSQL = @"update OrderLine " + 
                            @" set Product = @Product, Price = @Price, Quantity = @Quantity, LineTotal = @LineTotal "+
                            @" where OrderID = @OrderID and LineID = @LineID  ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, obj.OrderID);
            db.AddInParameter(cmd, "@LineID", System.Data.DbType.Int32, obj.LineID);
            db.AddInParameter(cmd, "@Product", System.Data.DbType.String, obj.Product);
            db.AddInParameter(cmd, "@Price", System.Data.DbType.Currency, obj.Price);
            db.AddInParameter(cmd, "@Quantity", System.Data.DbType.Int32, obj.Quantity);
            db.AddInParameter(cmd, "@LineTotal", System.Data.DbType.Currency, obj.LineTotal);

            return db.ExecuteNonQuery(cmd);
        }
        public static void Delete(int orderID, int lineID)
        {
            string strSQL = @"delete OrderLine where OrderID = @OrderID and LineID = @LineID ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, orderID);
            db.AddInParameter(cmd, "@LineID", System.Data.DbType.Int32, lineID);

            db.ExecuteNonQuery(cmd);
        }

        public static IList<OrderLineData> SelectAll()
        {
            string strSQL = @"select * from OrderLine ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            IList<OrderLineData> objs = new List<OrderLineData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    OrderLineData obj = new OrderLineData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }
        public static IList<OrderLineData> SelectWithCondition(string strCondition)
        {
            string strSQL = @"select * from OrderLine " + strCondition;

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            IList<OrderLineData> objs = new List<OrderLineData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    OrderLineData obj = new OrderLineData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }
        public static IList<OrderLineData> SelectList(int orderID)
        {
            string strSQL = @"select * from OrderLine where OrderID = @OrderID";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, orderID);

            IList<OrderLineData> objs = new List<OrderLineData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    OrderLineData obj = new OrderLineData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }
    }
}
