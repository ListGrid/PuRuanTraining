﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Data.EntityClient;
using System.ComponentModel;
using System.Xml.Serialization;
using System.Runtime.Serialization;

[assembly: EdmSchemaAttribute()]

namespace ProductManager
{
    #region Contexts
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    public partial class bbsDB_dataEntities : ObjectContext
    {
        #region Constructors
    
        /// <summary>
        /// Initializes a new bbsDB_dataEntities object using the connection string found in the 'bbsDB_dataEntities' section of the application configuration file.
        /// </summary>
        public bbsDB_dataEntities() : base("name=bbsDB_dataEntities", "bbsDB_dataEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new bbsDB_dataEntities object.
        /// </summary>
        public bbsDB_dataEntities(string connectionString) : base(connectionString, "bbsDB_dataEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// Initialize a new bbsDB_dataEntities object.
        /// </summary>
        public bbsDB_dataEntities(EntityConnection connection) : base(connection, "bbsDB_dataEntities")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region Partial Methods
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        public ObjectSet<Product> Product
        {
            get
            {
                if ((_Product == null))
                {
                    _Product = base.CreateObjectSet<Product>("Product");
                }
                return _Product;
            }
        }
        private ObjectSet<Product> _Product;

        #endregion
        #region AddTo Methods
    
        /// <summary>
        /// Deprecated Method for adding a new object to the Product EntitySet. Consider using the .Add method of the associated ObjectSet&lt;T&gt; property instead.
        /// </summary>
        public void AddToProduct(Product product)
        {
            base.AddObject("Product", product);
        }

        #endregion
    }
    

    #endregion
    
    #region Entities
    
    /// <summary>
    /// No Metadata Documentation available.
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="bbsDB_dataModel", Name="Product")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class Product : EntityObject
    {
        #region Factory Method
    
        /// <summary>
        /// Create a new Product object.
        /// </summary>
        /// <param name="lineID">Initial value of the LineID property.</param>
        /// <param name="product1">Initial value of the Product1 property.</param>
        /// <param name="price">Initial value of the Price property.</param>
        /// <param name="quantity">Initial value of the Quantity property.</param>
        /// <param name="lineTotal">Initial value of the LineTotal property.</param>
        public static Product CreateProduct(global::System.Int32 lineID, global::System.String product1, global::System.Single price, global::System.Single quantity, global::System.Single lineTotal)
        {
            Product product = new Product();
            product.LineID = lineID;
            product.Product1 = product1;
            product.Price = price;
            product.Quantity = quantity;
            product.LineTotal = lineTotal;
            return product;
        }

        #endregion
        #region Primitive Properties
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Int32 LineID
        {
            get
            {
                return _LineID;
            }
            set
            {
                if (_LineID != value)
                {
                    OnLineIDChanging(value);
                    ReportPropertyChanging("LineID");
                    _LineID = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("LineID");
                    OnLineIDChanged();
                }
            }
        }
        private global::System.Int32 _LineID;
        partial void OnLineIDChanging(global::System.Int32 value);
        partial void OnLineIDChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String Product1
        {
            get
            {
                return _Product1;
            }
            set
            {
                if (_Product1 != value)
                {
                    OnProduct1Changing(value);
                    ReportPropertyChanging("Product1");
                    _Product1 = StructuralObject.SetValidValue(value, false);
                    ReportPropertyChanged("Product1");
                    OnProduct1Changed();
                }
            }
        }
        private global::System.String _Product1;
        partial void OnProduct1Changing(global::System.String value);
        partial void OnProduct1Changed();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Single Price
        {
            get
            {
                return _Price;
            }
            set
            {
                if (_Price != value)
                {
                    OnPriceChanging(value);
                    ReportPropertyChanging("Price");
                    _Price = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("Price");
                    OnPriceChanged();
                }
            }
        }
        private global::System.Single _Price;
        partial void OnPriceChanging(global::System.Single value);
        partial void OnPriceChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Single Quantity
        {
            get
            {
                return _Quantity;
            }
            set
            {
                if (_Quantity != value)
                {
                    OnQuantityChanging(value);
                    ReportPropertyChanging("Quantity");
                    _Quantity = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("Quantity");
                    OnQuantityChanged();
                }
            }
        }
        private global::System.Single _Quantity;
        partial void OnQuantityChanging(global::System.Single value);
        partial void OnQuantityChanged();
    
        /// <summary>
        /// No Metadata Documentation available.
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.Single LineTotal
        {
            get
            {
                return _LineTotal;
            }
            set
            {
                if (_LineTotal != value)
                {
                    OnLineTotalChanging(value);
                    ReportPropertyChanging("LineTotal");
                    _LineTotal = StructuralObject.SetValidValue(value);
                    ReportPropertyChanged("LineTotal");
                    OnLineTotalChanged();
                }
            }
        }
        private global::System.Single _LineTotal;
        partial void OnLineTotalChanging(global::System.Single value);
        partial void OnLineTotalChanged();

        #endregion
    
    }

    #endregion
    
}
