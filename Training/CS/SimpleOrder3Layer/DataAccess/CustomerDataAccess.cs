using System.Collections.Generic;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace KS201008.DataAccess
{
    public class CustomerDataAccess
    {
        public static CustomerData Select(int customerID)
        {
            string strSQL = @"select * from Customer where CustomerID = @CustomerID ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, customerID);

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                if (reader.Read())
                {
                    CustomerData obj = new CustomerData();
                    obj.Fill(reader);
                    return obj;
                }
            }
            return null;
        }

        public static void Save(CustomerData obj)
        {
            if (Update(obj) == 0)
            {
                Insert(obj);
            }
        }
        public static int Insert(CustomerData obj)
        {
            Database db = DatabaseFactory.CreateDatabase();
            string strSQL = @"insert into Customer " +
                            @" (CustomerName, ContactPerson) " +
                            @" values(@CustomerName, @ContactPerson); " +
                            @" select  CAST(@@IDENTITY AS int);";

            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@CustomerName", System.Data.DbType.String, obj.CustomerName);
            Utility.AddNullableParameter(db, cmd, "@ContactPerson", System.Data.DbType.String, obj.ContactPerson);

            obj.CustomerID = (int)db.ExecuteScalar(cmd);
            return obj.CustomerID;
        }

        public static int Update(CustomerData obj)
        {
            string strSQL = @"update Customer " + 
                            @" set CustomerName = @CustomerName, ContactPerson = @ContactPerson "+
                            @" where CustomerID = @CustomerID  ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, obj.CustomerID);
            db.AddInParameter(cmd, "@CustomerName", System.Data.DbType.String, obj.CustomerName);
            Utility.AddNullableParameter(db, cmd, "@ContactPerson", System.Data.DbType.String, obj.ContactPerson);

            return db.ExecuteNonQuery(cmd);
        }
        public static void Delete(int customerID)
        {
            string strSQL = @"delete Customer where CustomerID = @CustomerID ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, customerID);

            db.ExecuteNonQuery(cmd);
        }

        public static IList<CustomerData> SelectAll()
        {
            string strSQL = @"select * from Customer ";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            IList<CustomerData> objs = new List<CustomerData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    CustomerData obj = new CustomerData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }
        public static IList<CustomerData> SelectWithCondition(string strCondition)
        {
            string strSQL = @"select * from Customer " + strCondition;

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            IList<CustomerData> objs = new List<CustomerData>();

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    CustomerData obj = new CustomerData();
                    obj.Fill(reader);
                    objs.Add(obj);
                }
            }
            return objs;
        }
        public static IList<int> SelectAllCustomerIDs()
        {
            List<int> myList = new List<int>();
            string strSQL = @"select CustomerID from Customer order by CustomerID";

            Database db = DatabaseFactory.CreateDatabase();
            DbCommand cmd = db.GetSqlStringCommand(strSQL);

            using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    myList.Add((int)reader["CustomerID"]);
                }
            }

            return myList;
        }
    }
}
