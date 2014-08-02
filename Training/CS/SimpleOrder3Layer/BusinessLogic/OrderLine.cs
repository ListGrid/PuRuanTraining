using System;
using System.Collections.Generic;
using System.ComponentModel;
using KS201008.DataAccess;

namespace KS201008.BusinessLogic
{

    public class OrderLine : INotifyPropertyChanged
    {
        #region INotifyPropertyChanged
        public event PropertyChangedEventHandler PropertyChanged;

        protected void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }
        #endregion  

        #region Generated Code
        private OrderLineData m_data;
        private IDictionary<string, bool> m_Changing = new Dictionary<string, bool>();

        public OrderLine()
        {
            m_data = new OrderLineData();
        }

        public OrderLine(int orderID, int lineID)
        {
            m_data = OrderLineDataAccess.Select(orderID, lineID);
            if (m_data == null)
                m_data = new OrderLineData();
        }

        public static IList<OrderLine> GetList(int orderID)
        {
            IList<OrderLineData> dataList = OrderLineDataAccess.SelectList(orderID);
            IList<OrderLine> orderLineList = new List<OrderLine>();
            foreach (OrderLineData data in dataList)
            {
                OrderLine orderLine = new OrderLine();
                orderLine.m_data = data;
                orderLineList.Add(orderLine);
            }
            return orderLineList;
        }

        public void Save()
        {
           // using (TransactionScope scope = new TransactionScope())
            {
                try
                {
                    OrderLineDataAccess.Save(m_data);                    
             //       scope.Complete();
                }
                catch (Exception ex)
                {
                    string err = ex.Message;
                }
            }
        }

        public static IList<OrderLine> Query(string strCondition)
        {
            IList<OrderLineData> dataList = OrderLineDataAccess.SelectWithCondition(strCondition);
            IList<OrderLine> orderLineList = new List<OrderLine>();
            foreach (OrderLineData data in dataList)
            {
                OrderLine orderLine = new OrderLine();
                orderLine.m_data = data;
                orderLineList.Add(orderLine);
            }
            return orderLineList;
        }

        public int OrderID
        {
            get { return m_data.OrderID; }
            set
            {
                m_data.OrderID = value;
            }
        }

        public int LineID
        {
            get { return m_data.LineID; }
            set
            { 
               m_data.LineID = value;
            }
        }

        public string Product
        {
            get { return m_data.Product; }
            set
            { 
               m_data.Product = value;
            }
        }

        public decimal Price
        {
            get { return m_data.Price; }
            set
            {
                m_Changing["Price"] = true;
                m_data.Price = value;
                OnPriceChanged();
            }
        }

        public int Quantity
        {
            get { return m_data.Quantity; }
            set
            {
                m_Changing["Quantity"] = true;
                m_data.Quantity = value;
                OnQuantityChanged();
            }
        }        

        public decimal LineTotal
        {
            get { return m_data.LineTotal; }
            set
            {
                m_Changing["LineTotal"] = true;
                m_data.LineTotal = value;
                OnLineTotalChanged();
            }
        }

        public bool IsChanging(string propertyName)
        {
            if (m_Changing.ContainsKey(propertyName))
            {
                return m_Changing[propertyName];
            }
            else
            {
                return false;
            }

        }

        #endregion

        protected void OnPriceChanged()
        {
            RecalcLineTotal();
            m_Changing["Price"] = false;
            NotifyPropertyChanged("Price");
        }

        protected void OnQuantityChanged()
        {
            RecalcLineTotal();
            m_Changing["Quantity"] = false;
            NotifyPropertyChanged("Quantity");
        }

        protected void OnLineTotalChanged()
        {
            // recalculate price
            if (!IsChanging("Quantity") && Quantity != 0)
            {
                Price = LineTotal / Quantity;
            } 
            m_Changing["LineTotal"] = false;
            NotifyPropertyChanged("LineTotal");
        }

        protected virtual void RecalcLineTotal()
        {
            if (!IsChanging("LineTotal"))
            {
                LineTotal = Quantity * Price;                
            }            
        }        

    }
}
