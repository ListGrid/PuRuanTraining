using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ProductManager
{

    public class ProductDAO
    {
        public static ProductVO Select(int orderID)
        {
            SqlConnection sqlCnt;
            DataSet myDataSet;
            SqlDataAdapter myDataAdapter;
            DataTable myTable;
            SqlCommandBuilder mySqlCommandBuilder;

            string connectString = "Data Source=.;Initial Catalog=bbsDB_data;Integrated Security=true";
            sqlCnt = new SqlConnection(connectString);
            sqlCnt.Open();

             //SqlCommand command = new SqlCommand();
            //command.Connection = sqlCnt;            // ��SqlConnection����

            SqlCommand cmd = sqlCnt.CreateCommand();              //����SqlCommand����
            cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select * from Product where Product = @ID";   //sql���
            cmd.CommandText = "select * from Product";   //sql���
            cmd.Parameters.Add("@ID", SqlDbType.VarChar);
            cmd.Parameters["@ID"].Value = "12";                    //������sql���Ĳ�����ֵ

            //SqlDataReader reader = cmd.ExecuteReader();		//ִ��SQL������һ��������
            //while (reader.Read())
            //{
            //    Console.Write(reader["LineID"]);	// ��ӡ��ÿ���û����û���
            //}

            // ����SqlDataAdapter
            myDataAdapter = new SqlDataAdapter();
            myDataAdapter.SelectCommand = cmd;	// ΪSqlDataAdapter�������Ҫִ�е�SqlCommand����

            myDataSet = new DataSet();		// ����DataSet
            myDataAdapter.Fill(myDataSet, "Product");	// �����ص����ݼ���Ϊ��������DataSet�У��������������ݿ���ʵ�ı���

            // �޸�DataSet
            myTable = myDataSet.Tables["product"];

            if(myTable.Rows.Count == 0)
            {
                return null;
            }

            ProductVO obj = new ProductVO();

            foreach (DataRow dr in myTable.Rows)
            {
                obj.LineID = Int32.Parse(dr["LineID"].ToString());
                obj.Product = dr["Product"].ToString();
                obj.Price = Convert.ToDouble(dr["Price"].ToString());
                obj.Quantity = Convert.ToDouble(dr["Quantity"].ToString());
                obj.LineTotal = Convert.ToDouble(dr["LineTotal"].ToString());

                break;
            }

            return obj; 
        }

        //public static void Save(ProductVO obj)
        //{
        //    if (Update(obj) == 0)
        //    {
        //        Insert(obj);
        //    }
        //}

        //public static int Insert(ProductVO obj)
        //{
        //    Database db = DatabaseFactory.CreateDatabase();
        //    string strSQL = @"insert into SalesOrder " + 
        //                    @" (CustomerID, DocDate, DocTotal) "+
        //                    @" values(@CustomerID, @DocDate, @DocTotal); " +
        //                    @" select  CAST(@@IDENTITY AS int);";

        //    DbCommand cmd = db.GetSqlStringCommand(strSQL);

        //    db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, obj.CustomerID);
        //    db.AddInParameter(cmd, "@DocDate", System.Data.DbType.DateTime, obj.DocDate);
        //    db.AddInParameter(cmd, "@DocTotal", System.Data.DbType.Currency, obj.DocTotal);

        //    obj.OrderID = (int)db.ExecuteScalar(cmd);
        //    return obj.OrderID;
        //}

        //public static int Update(ProductVO obj)
        //{
        //    string strSQL = @"update SalesOrder " + 
        //                    @" set CustomerID = @CustomerID, DocDate = @DocDate, DocTotal = @DocTotal "+
        //                    @" where OrderID = @OrderID  ";

        //    Database db = DatabaseFactory.CreateDatabase();
        //    DbCommand cmd = db.GetSqlStringCommand(strSQL);

        //    db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, obj.OrderID);
        //    db.AddInParameter(cmd, "@CustomerID", System.Data.DbType.Int32, obj.CustomerID);
        //    db.AddInParameter(cmd, "@DocDate", System.Data.DbType.DateTime, obj.DocDate);
        //    db.AddInParameter(cmd, "@DocTotal", System.Data.DbType.Currency, obj.DocTotal);

        //    return db.ExecuteNonQuery(cmd);
        //}
        //public static void Delete(int orderID)
        //{
        //    string strSQL = @"delete SalesOrder where OrderID = @OrderID ";

        //    Database db = DatabaseFactory.CreateDatabase();
        //    DbCommand cmd = db.GetSqlStringCommand(strSQL);

        //    db.AddInParameter(cmd, "@OrderID", System.Data.DbType.Int32, orderID);

        //    db.ExecuteNonQuery(cmd);
        //}

        //public static IList<ProductVO> SelectAll()
        //{
        //    string strSQL = @"select * from SalesOrder ";

        //    Database db = DatabaseFactory.CreateDatabase();
        //    DbCommand cmd = db.GetSqlStringCommand(strSQL);

        //    IList<ProductVO> objs = new List<ProductVO>();

        //    using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
        //    {
        //        while (reader.Read())
        //        {
        //            ProductVO obj = new ProductVO();
        //            obj.Fill(reader);
        //            objs.Add(obj);
        //        }
        //    }
        //    return objs;
        //}
        //public static IList<ProductVO> SelectWithCondition(string strCondition)
        //{
        //    string strSQL = @"select * from SalesOrder " + strCondition;

        //    Database db = DatabaseFactory.CreateDatabase();
        //    DbCommand cmd = db.GetSqlStringCommand(strSQL);

        //    IList<ProductVO> objs = new List<ProductVO>();

        //    using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
        //    {
        //        while (reader.Read())
        //        {
        //            ProductVO obj = new ProductVO();
        //            obj.Fill(reader);
        //            objs.Add(obj);
        //        }
        //    }
        //    return objs;
        //}

        //public static IList<int> SelectAllOrderIDs()
        //{
        //    List<int> myList = new List<int>();
        //    string strSQL = @"select OrderID from SalesOrder order by OrderID";

        //    Database db = DatabaseFactory.CreateDatabase();
        //    DbCommand cmd = db.GetSqlStringCommand(strSQL);

        //    using (System.Data.IDataReader reader = db.ExecuteReader(cmd))
        //    {
        //        while (reader.Read())
        //        {
        //            myList.Add((int)reader["OrderID"]);
        //        }
        //    }

        //    return myList;
        //}
    }
}
