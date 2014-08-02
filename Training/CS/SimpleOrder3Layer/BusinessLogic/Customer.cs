using System;
using System.Collections.Generic;
using System.Transactions;
using KS201008.DataAccess;

namespace KS201008.BusinessLogic
{
    public class Customer
    {
        private CustomerData m_data;

        public Customer()
        {
            m_data = new CustomerData();
        }

        public Customer(int customerID)
        {
            m_data = CustomerDataAccess.Select(customerID);
            if (m_data == null)
                m_data = new CustomerData();
        }

        public IList<int> GetPrimaryKeyIDs()
        {
            return CustomerDataAccess.SelectAllCustomerIDs();
        }

        public static IList<Customer> Query(string strCondition)
        {
            IList<CustomerData> dataList = CustomerDataAccess.SelectWithCondition(strCondition);
            IList<Customer> customerList = new List<Customer>();
            foreach (CustomerData data in dataList)
            {
                Customer customer = new Customer();
                customer.m_data = data;
                customerList.Add(customer);
            }
            return customerList;
        }

        public int CustomerID
        {
            get { return m_data.CustomerID; }
            set
            { 
                m_data.CustomerID = value;
            }
        }

        public string CustomerName
        {
            get { return m_data.CustomerName; }
            set
            { 
                m_data.CustomerName = value;
            }
        }

        public string ContactPerson
        {
            get { return m_data.ContactPerson; }
            set
            { 
                m_data.ContactPerson = value;
            }
        }
		
    }
}
