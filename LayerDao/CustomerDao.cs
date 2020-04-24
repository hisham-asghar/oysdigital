using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class CustomerDao
    {
        public static List<Customer> GetAll()
        {
            string sql = $"SELECT * FROM dbo.Customer;";
            return QueryExecutor.List<Customer>(sql);
        }
        public static Customer GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.Customer WHERE CustomerId = {Id};";
            return QueryExecutor.FirstOrDefault<Customer>(sql);
        }
        public static bool Insert(Customer c)
        {
            string sql = $"Insert Into dbo.Customer (Name,Guid,Email,PhoneNumber,Address,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.CustomerId as Result VALUES " +
                $"('{c.Name}','{c.Guid}','{c.Email}','{c.PhoneNumber}','{c.Address}','{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";

            long data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result;
            return data == 0 ? true : false;
        }
        public static bool Update(Customer c)
        {
            string sql = $"UPDATE dbo.Customer Set Name='{c.Name}',Email='{c.Email}',PhoneNumber='{c.PhoneNumber}'" +
                $",Address='{c.Address}',IsActive='{c.IsActive}',ModifiedBy='{c.ModifiedBy}',OnModified='{c.OnModified}' output inserted.CustomerId as Result where (CustomerId={c.CustomerId})";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.Customer output deleted.CustomerId as Result WHERE CustomerId = {Id};";
            var data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
            return data;
        }
    }
}
