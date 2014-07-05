using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace ThreeLayerDemo.Core
{
    /// <summary>
    /// Summary description for ProductBUS
    /// </summary>
    public class ProductBUS
    {
        private UserDAO _userDAO;

        /// <constructor>
        /// Constructor ProductBUS
        /// </constructor>
        public ProductBUS()
        {
            _userDAO  = new UserDAO();
        }

        /// <method>
        /// Get User Email By Firstname or Lastname and return VO
        /// </method>
        public ProductVO getProductByName(string name)
        {
            ProductVO ProductVO = new ProductVO();
            DataTable dataTable = new DataTable();

            dataTable = _userDAO.searchByName(name);

            foreach (DataRow dr in dataTable.Rows)
            {
                ProductVO.LineID = Int32.Parse(dr["LineID"].ToString());
                ProductVO.Product = dr["Product"].ToString();
                ProductVO.Price = Convert.ToDouble(dr["Price"].ToString());
                ProductVO.Quantity = Convert.ToDouble(dr["Quantity"].ToString());
                ProductVO.LineTotal = Convert.ToDouble(dr["LineTotal"].ToString());
            }
            return ProductVO;
        }

    }
}
