using System;
using System.Data;

namespace KS201008.DataAccess
{
    public class OrderLineData
    {

        private int m_orderID;
        private int m_lineID;
        private string m_product;
        private decimal m_price;
        private int m_quantity;
        private decimal m_lineTotal;

        public OrderLineData()
        {

        }

        public int OrderID
        {
            get { return m_orderID; }
            set { m_orderID = value; }
        }

        public int LineID
        {
            get { return m_lineID; }
            set { m_lineID = value; }
        }

        public string Product
        {
            get { return m_product; }
            set { m_product = value; }
        }

        public decimal Price
        {
            get { return m_price; }
            set { m_price = value; }
        }

        public int Quantity
        {
            get { return m_quantity; }
            set { m_quantity = value; }
        }

        public decimal LineTotal
        {
            get { return m_lineTotal; }
            set { m_lineTotal = value; }
        }

        public void Fill(System.Data.IDataReader dr)
        {
            Utility.Fill(this, dr);
        }
    }
}
