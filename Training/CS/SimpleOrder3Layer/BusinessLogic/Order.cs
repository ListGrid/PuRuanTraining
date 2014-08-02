using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Transactions;
using KS201008.DataAccess;


namespace KS201008.BusinessLogic
{
    public class Order:INotifyPropertyChanged
    {
        private OrderData m_data;
        private ObservableCollection<OrderLine> m_lines = new ObservableCollection<OrderLine>();
        private Customer m_customer;

        public Customer Customer
        {
            get 
            {
                if (m_customer == null)
                {
                    m_customer = new Customer(this.CustomerID);
                }
                return m_customer;
            }
        }

        public Order()
        {
            m_data = new OrderData();
            this.DocDate = DateTime.Now;
            m_lines.CollectionChanged += delegate(object sender, NotifyCollectionChangedEventArgs e)
            {
                if (e.NewItems != null)
                {
                    foreach (OrderLine line in e.NewItems)
                    {
                        line.PropertyChanged += new PropertyChangedEventHandler(CalcDocTotal);
                    }
                    CalcDocTotal(sender, new PropertyChangedEventArgs("LineTotal"));
                }
            };
        }

        public Order(int orderID)
        {
            m_data = OrderDataAccess.Select(orderID);
            if (m_data == null)
                m_data = new OrderData();
            
            var lines = OrderLine.GetList(orderID);
            foreach(OrderLine line in lines)
            {
                line.PropertyChanged += new PropertyChangedEventHandler(CalcDocTotal);
                m_lines.Add(line);
            }

            m_lines.CollectionChanged += delegate(object sender, NotifyCollectionChangedEventArgs e)
            {
                if (e.NewItems != null)
                {
                    foreach (OrderLine line in e.NewItems)
                    {
                        line.PropertyChanged += new PropertyChangedEventHandler(CalcDocTotal);
                    }
                    CalcDocTotal(sender, new PropertyChangedEventArgs("LineTotal"));
                }                
            };
                       
        }

        public ObservableCollection<OrderLine> Lines
        {
            get { return m_lines; }
        }

        public void CalcDocTotal(object sender, PropertyChangedEventArgs info)
        {
            if (info.PropertyName == "LineTotal")
            {
                decimal sum = 0.0M;
                foreach (OrderLine line in m_lines)
                {
                    sum += line.LineTotal;
                }
                DocTotal = sum;
            }
            
        }

        public static IList<int> GetPrimaryKeyIDs()
        {
            return OrderDataAccess.SelectAllOrderIDs();
        }

        public void Save()
        {
            using (TransactionScope scope = new TransactionScope())
            {
                try
                {
                    OrderDataAccess.Save(m_data);
                    foreach (OrderLine line in this.Lines)
                    {
                        if (line.LineID != 0 )
                        {
                            line.OrderID = this.OrderID;
                            line.Save();
                        }
                    }                   
                    scope.Complete();
                }
                catch (Exception ex)
                {
                    string err = ex.Message;
                }
            }
        }

        public static IList<Order> Query(string strCondition)
        {
            IList<OrderData> dataList = OrderDataAccess.SelectWithCondition(strCondition);
            IList<Order> orderList = new List<Order>();
            foreach (OrderData data in dataList)
            {
                Order order = new Order(data.OrderID);
                order.m_data = data;
                orderList.Add(order);
            }
            return orderList;
        }

        public int OrderID
        {
            get { return m_data.OrderID; }
            set
            { 
                m_data.OrderID = value;
            }
        }

        public int CustomerID
        {
            get { return m_data.CustomerID; }
            set
            { 
                m_data.CustomerID = value;
            }
        }

        public DateTime DocDate
        {
            get { return m_data.DocDate; }
            set
            { 
                m_data.DocDate = value;
            }
        }

        public decimal DocTotal
        {
            get { return m_data.DocTotal; }
            set
            { 
                m_data.DocTotal = value;
                NotifyPropertyChanged("DocTotal");
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }
    }
}
