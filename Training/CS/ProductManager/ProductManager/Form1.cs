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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        ~Form1()
        {
            myDataSet.Dispose();        // 释放DataSet对象
            myDataAdapter.Dispose();    // 释放SqlDataAdapter对象
            //myDataReader.Dispose();     // 释放SqlDataReader对象
            sqlCnt.Close();             // 关闭数据库连接
            sqlCnt.Dispose();           // 释放数据库连接对象

        }
        private void Form1_Load(object sender, EventArgs e)
        {
            string connectString = "Data Source=.;Initial Catalog=bbsDB_data;Integrated Security=true";
            sqlCnt = new SqlConnection(connectString);
            sqlCnt.Open();


            //SqlCommand command = new SqlCommand();
            //command.Connection = sqlCnt;            // 绑定SqlConnection对象

            SqlCommand cmd = sqlCnt.CreateCommand();              //创建SqlCommand对象
            cmd.CommandType = CommandType.Text;
            //cmd.CommandText = "select * from Product where Product = @ID";   //sql语句
            cmd.CommandText = "select * from Product";   //sql语句
            cmd.Parameters.Add("@ID", SqlDbType.VarChar);
            cmd.Parameters["@ID"].Value = "12";                    //给参数sql语句的参数赋值

            //SqlDataReader reader = cmd.ExecuteReader();		//执行SQL，返回一个“流”
            //while (reader.Read())
            //{
            //    Console.Write(reader["LineID"]);	// 打印出每个用户的用户名
            //}

            // 创建SqlDataAdapter
            myDataAdapter = new SqlDataAdapter();
            myDataAdapter.SelectCommand = cmd;	// 为SqlDataAdapter对象绑定所要执行的SqlCommand对象

            myDataSet = new DataSet();		// 创建DataSet
            myDataAdapter.Fill(myDataSet, "Product");	// 将返回的数据集作为“表”填入DataSet中，表名可以与数据库真实的表名

            // 修改DataSet
            myTable = myDataSet.Tables["product"];

            Decimal total = Convert.ToDecimal(0.0);

            foreach (DataRow myRow in myTable.Rows)
            {
                myRow["LineTotal"] = Convert.ToDecimal( myRow["Price"] )
                                        * Convert.ToDecimal( myRow["Quantity"] );
                total += Convert.ToDecimal( myRow["LineTotal"] );

            }

            tbTotalCost.Text = total.ToString();

            // 将DataSet的修改提交至“数据库”
            mySqlCommandBuilder = new SqlCommandBuilder(myDataAdapter);
            myDataAdapter.Update(myDataSet, "Product");

            dataGridView1.DataSource = myTable;

            //create Dataset 

            //column LineTotal is created and is computed from column 'price' and 'quantity'.
            //bingding the dataset with datagrid
            //write back to data base.

         }

        private void dataGridView1_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            DataRow dr = myTable.Rows[e.RowIndex];
            dr["LineTotal"] = Convert.ToDecimal(dr["Price"])
                                    * Convert.ToDecimal(dr["Quantity"]);

            Decimal total = Convert.ToDecimal(0.0);

            foreach (DataRow myRow in myTable.Rows)
            {
                total += Convert.ToDecimal(myRow["LineTotal"]);

            }

            tbTotalCost.Text = total.ToString();

            // 将DataSet的修改提交至“数据库”
            mySqlCommandBuilder = new SqlCommandBuilder(myDataAdapter);
            myDataAdapter.Update(myDataSet, "Product");
        }

        public SqlConnection sqlCnt;
        public DataSet myDataSet;
        public SqlDataAdapter myDataAdapter;
        public DataTable myTable;
        public SqlCommandBuilder mySqlCommandBuilder;
    }
}
