using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection sqlcon = new SqlConnection(@"server=.\SqlExpress;user=sa;pwd=sa;database=dotnet");
        string sql1 = @"update bank set balance=balance-@count where userid=@id";
        string sql2 = @"update bnk set balance=balance+@count where userid=@id";
        sqlcon.Open();
        SqlTransaction tran = sqlcon.BeginTransaction(IsolationLevel.Serializable);
        SqlCommand sqlcmd = new SqlCommand(sql1,sqlcon);
        try
        {
            sqlcmd.Transaction = tran;
            sqlcmd.Parameters.Add("@count", SqlDbType.SmallMoney, 0).Value = int.Parse(TextBox3.Text);
            sqlcmd.Parameters.Add("@id", SqlDbType.VarChar, 20).Value = TextBox1.Text;
            sqlcmd.ExecuteNonQuery();
            sqlcmd.CommandText = sql2;
            sqlcmd.Parameters["@id"].Value = TextBox2.Text;
            sqlcmd.ExecuteNonQuery();
            sqlcmd.Transaction.Commit();
            Label1.Text = "成功";
        }
        catch (Exception ex)
        {
            sqlcmd.Transaction.Rollback();
            Label1.Text = ex.Message;
        }
        finally
        {
            sqlcon.Close();
        }
    }
}
