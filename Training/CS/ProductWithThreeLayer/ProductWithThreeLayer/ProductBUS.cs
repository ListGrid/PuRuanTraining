using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace ProductManager
{
    /// <summary>
    /// Summary description for ProductBUS
    /// </summary>
    public class ProductBUS
    {
        private ProductDAO _ProductDAO;

        /// <constructor>
        /// Constructor ProductBUS
        /// </constructor>
        public ProductBUS()
        {
            _ProductDAO  = new ProductDAO();
        }

        /// <method>
        /// Get Product Email By Firstname or Lastname and return VO
        /// </method>
        public ProductVO getProductById(int Id)
        {
            ProductVO ProductVO;
            DataTable dataTable = new DataTable();

            ProductVO = ProductDAO.Select(Id);

            //foreach (DataRow dr in dataTable.Rows)
            //{
            //    ProductVO.LineID = Int32.Parse(dr["LineID"].ToString());
            //    ProductVO.Product = dr["Product"].ToString();
            //    ProductVO.Price = Convert.ToDouble(dr["Price"].ToString());
            //    ProductVO.Quantity = Convert.ToDouble(dr["Quantity"].ToString());
            //    ProductVO.LineTotal = Convert.ToDouble(dr["LineTotal"].ToString());
            //}
            return ProductVO;
        }

    }
}
