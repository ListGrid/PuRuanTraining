using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ThreeLayerDemo.Core;

namespace ThreeLayerDemo
{
    public partial class frmLogin : Form
    {
        private UserBUS _userBUS;
        private ProductBUS _ProductBUS;
        public frmLogin()
        {
            InitializeComponent();
            _userBUS = new UserBUS();
            _ProductBUS = new ProductBUS();
        }

        private void btnSearch_Click1(object sender, EventArgs e)
        {
            UserVO _userVO = new UserVO();
            _userVO = _userBUS.getUserEmailByName(txtUsername.Text);
            if (_userVO.email == null)
                MessageBox.Show("No Match Found!", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            else
                MessageBox.Show(_userVO.email ,"Result",MessageBoxButtons.OK,MessageBoxIcon.Information);
                
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            ProductVO _ProductVO = new ProductVO();
            _ProductVO = _ProductBUS.getProductByName(txtUsername.Text);
            if (_ProductVO.Product == null)
                MessageBox.Show("No Match Found!", "Not Found", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            else
                MessageBox.Show(_ProductVO.Product + " Price:" + _ProductVO.Price.ToString(), "Result", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
