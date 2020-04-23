using System;
using System.Collections.Generic;
using System.Text;

namespace LayerBao
{
    public class UserBao
    {
        public static List<Customer> GetAllCustomer()
        {
            string sql = $"SELECT * FROM dbo.Customer;";
            return QueryExecutor.List<Customer>(sql);
        }
        public static Customer GetCustomer(long Id)
        {
            string sql = $"SELECT * FROM dbo.Customer WHERE CustomerId = '{Id}';";
            return QueryExecutor.FirstOrDefault<TemplateClass<Customer>>(sql).Result;
        }
        public static bool InsertCustomer(long Id)
        {
            string sql = $"Insert Into FROM dbo.Customer WHERE LoginProvider = '{Id}';";
            return QueryExecutor.FirstOrDefault<TemplateClass<AspNetUsers>>(sql).Result;
        }
        public static Customer GetCustomer(long Id)
        {
            string sql = $"SELECT * FROM dbo.Customer WHERE LoginProvider = '{Id}';";
            return QueryExecutor.FirstOrDefault<TemplateClass<AspNetUsers>>(sql).Result;
        }
        public static Customer GetCustomer(long Id)
        {
            string sql = $"SELECT * FROM dbo.AspNetUserLogins WHERE LoginProvider = '{Id}';";
            return QueryExecutor.FirstOrDefault<TemplateClass<AspNetUsers>>(sql).Result;
        }
    }
}
