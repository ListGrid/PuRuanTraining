using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ThreeLayerDemo.Core
{
    public class ProductVO
    {
        private int _LineID;
        private string _Product;
        private double _Price;
        private double _Quantity;
        private double _LineTotal;

        /// <constructor>
        /// Constructor UserVO
        /// </constructor>
        public ProductVO()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int LineID
        {
            get
            {
                return _LineID;
            }

            set
            {
                _LineID = value;
            }
        }
        public string Product
        {
            get
            {
                return _Product;
            }

            set
            {
                _Product = value;
            }
        }
        public double Price
        {
            get
            {
                return _Price;
            }

            set
            {
                _Price = value;
            }
        }
        public double Quantity
        {
            get
            {
                return _Quantity;
            }

            set
            {
                _Quantity = value;
            }
        }
        public double LineTotal
        {
            get
            {
                return _LineTotal;
            }

            set
            {
                _LineTotal = value;
            }
        } 
    }
}
