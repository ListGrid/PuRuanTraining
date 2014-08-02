using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace KS201008.DataAccess
{
    class Utility
    {
        public static void AddNullableParameter(DbConnection.Database db, DbCommand cmd, string name, System.Data.DbType dbType, object value)
        {
            if (value == null)
            {
                db.AddInParameter(cmd, name, dbType, System.DBNull.Value);
            }
            else
            {
                db.AddInParameter(cmd, name, dbType, value);
            }
        }

        public static void Fill(object obj, System.Data.IDataReader dr)
        {
            System.ComponentModel.PropertyDescriptorCollection props = System.ComponentModel.TypeDescriptor.GetProperties(obj);
            for (int i = 0; i < props.Count; i++)
            {
                System.ComponentModel.PropertyDescriptor prop = props[i];
                if (!prop.IsReadOnly)
                {
                    try
                    {
                        if (!(dr[prop.Name].Equals(System.DBNull.Value)))
                        {
                            if (!(prop.PropertyType.Equals(dr[prop.Name].GetType())))
                            {
                                prop.SetValue(obj, prop.Converter.ConvertFrom(dr[prop.Name]));
                            }
                            else
                            {
                                prop.SetValue(obj, dr[prop.Name]);
                            }
                        }
                    }
                    catch (System.Exception)
                    {
                    }
                }
            }
        }
    }
}
