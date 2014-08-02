using System;
using System.Data;

namespace KS201008.DataAccess
{
    public class CustomerData
    {

        private int m_customerID;
        private string m_customerName;
        private string m_contactPerson;

        public CustomerData()
        {

        }

        public int CustomerID
        {
            get { return m_customerID; }
            set { m_customerID = value; }
        }

        public string CustomerName
        {
            get { return m_customerName; }
            set { m_customerName = value; }
        }

        public string ContactPerson
        {
            get { return m_contactPerson; }
            set { m_contactPerson = value; }
        }

        public void Fill(System.Data.IDataReader dr)
        {
            Utility.Fill(this, dr);
        }
    }
}
