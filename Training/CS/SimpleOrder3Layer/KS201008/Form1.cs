using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Windows.Forms;
using KS201008.BusinessLogic;

namespace KS201008
{
    public partial class Form1 : Form
    {
        private Order _order = new Order();

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            comboBox1.DataSource = Customer.Query(string.Empty);
            orderBindingSource.DataSource = Order.Query(string.Empty);

            RefreshOrderLines();
        }

        private void RefreshOrderLines()
        {
            _order = (Order)orderBindingSource.Current;
            orderLineBindingSource.DataSource = _order.Lines;

        }

        private void bindingNavigatorMoveFirstItem_Click(object sender, EventArgs e)
        {
            RefreshOrderLines();
        }

        private void bindingNavigatorMovePreviousItem_Click(object sender, EventArgs e)
        {
            RefreshOrderLines();
        }

        private void bindingNavigatorMoveNextItem_Click(object sender, EventArgs e)
        {
            RefreshOrderLines();
        }

        private void bindingNavigatorMoveLastItem_Click(object sender, EventArgs e)
        {
            RefreshOrderLines();
        }

        private void bindingNavigatorPositionItem_Validated(object sender, EventArgs e)
        {
            RefreshOrderLines();
        }

        private void bindingNavigatorAddNewItem_Click(object sender, EventArgs e)
        {
            RefreshOrderLines();

        }

        private void bindingNavigatorDeleteItem_Click(object sender, EventArgs e)
        {
            // not implemented
            // _order.Delete();
        }

        private void toolStripButtonSave_Click(object sender, EventArgs e)
        {
            _order.Save();
        }

    }
}