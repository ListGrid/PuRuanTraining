using System;
using System.Data;

namespace KS201008.DataAccess
{
    public class OrderData
    {

        private int m_orderID;
        private int m_customerID;
        private DateTime m_docDate;
        private decimal m_docTotal;

        public OrderData()
        {

        }

        public int OrderID
        {
            get { return m_orderID; }
            set { m_orderID = value; }
        }

        public int CustomerID
        {
            get { return m_customerID; }
            set { m_customerID = value; }
        }

        public DateTime DocDate
        {
            get { return m_docDate; }
            set { m_docDate = value; }
        }

        public decimal DocTotal
        {
            get { return m_docTotal; }
            set { m_docTotal = value; }
        }

        public void Fill(System.Data.IDataReader dr)
        {
            Utility.Fill(this, dr);
        }
    }
}
