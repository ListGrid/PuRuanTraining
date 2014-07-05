<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        转账帐户:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>&nbsp; 转账金额:
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br />
        <br />
        目标帐户:
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="确定" />
        <asp:Label ID="Label1" runat="server" ForeColor="Red" Width="203px"></asp:Label></div>
    </form>
</body>
</html>
