using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerBao
{
    public class UserBao
    {
        public partial class CustomerBao
        {
            public static List<Customer> GetAll()
            {
                string sql = $"SELECT * FROM dbo.Customer;";
                return QueryExecutor.List<Customer>(sql);
            }
            public static Customer GetById(long Id)
            {
                string sql = $"SELECT * FROM dbo.Customer WHERE CustomerId = '{Id}';";
                return QueryExecutor.FirstOrDefault<TemplateClass<Customer>>(sql).Result;
            }
            public static bool Insert(Customer c)
            {
                string sql = $"Insert Into dbo.Customer (CustomerId,Guid,Email,PhoneNumber,Address,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                    $" output INSERTED.CustomerId as Result VALUES " +
                    $"('{c.CustomerId}','{c.Guid}','{c.Email}','{c.PhoneNumber}','{c.Address}','{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";

               long data=QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result;
                return data == 0 ? true : false;
            }
            //public static bool Update(Customer c)
            //{
            //    string sql = $"UPDATE dbo.Customer (Guid='{c.Guid}',Email'{c.Email}',PhoneNumber'{c.PhoneNumber}" +
            //        $",Address'{c.Address}',IsActive='{c.IsActive}',CreatedBy='{c.CreatedBy}',ModifiedBy'{c.ModifiedBy}',OnCreated'{c.OnCreated}',OnModified='{c.OnModified}') where CustomerId='{c.CustomerId}'";

            //    return QueryExecutor.FirstOrDefault<TemplateClass<Customer>>(sql).Result;
            //}
            //public static bool Delete(long Id)
            //{
            //    string sql = $"DELETE FROM dbo.Customer WHERE CustomerId = '{Id}';";
            //    return QueryExecutor.FirstOrDefault<TemplateClass<Customer>>(sql).Result;
            //}
        }
        //public partial class MobileBao
        //{
        //    public static List<Mobile> GetAll()
        //    {
        //        string sql = $"SELECT * FROM dbo.Mobile;";
        //        return QueryExecutor.List<Mobile>(sql);
        //    }
        //    public static Mobile GetById(long Id)
        //    {
        //        string sql = $"SELECT * FROM dbo.Mobile WHERE MobileId = '{Id}';";
        //        return QueryExecutor.FirstOrDefault<TemplateClass<Mobile>>(sql).Result;
        //    }
        //    public static bool Insert(Mobile c)
        //    {
        //        string sql = $"Insert Into dbo.Mobile (Name,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
        //            $" output INSERTED.Id as Result VALUES " +
        //            $"('{c.Name}','{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";
        //        return QueryExecutor.FirstOrDefault<TemplateClass<Mobile>>(sql).Result;
        //    }
        //    public static bool Update(Mobile c)
        //    {
        //        string sql = $"UPDATE dbo.Mobile (Name='{c.Name}',IsActive='{c.IsActive}',CreatedBy='{c.CreatedBy}',ModifiedBy'{c.ModifiedBy}',OnCreated'{c.OnCreated}',OnModified='{c.OnModified}') where MobileId='{c.MobileId}'";

        //        return QueryExecutor.FirstOrDefault<TemplateClass<Mobile>>(sql).Result;
        //    }
        //    public static bool Delete(long Id)
        //    {
        //        string sql = $"DELETE FROM dbo.Mobile WHERE MobileId = '{Id}';";
        //        return QueryExecutor.FirstOrDefault<TemplateClass<Mobile>>(sql).Result;
        //    }
        //}
        //public partial class PlatformBao
        //{
        //    public static List<Platforms> GetAll()
        //    {
        //        string sql = $"SELECT * FROM dbo.Platforms;";
        //        return QueryExecutor.List<Platforms>(sql);
        //    }
        //    public static Platforms GetById(long Id)
        //    {
        //        string sql = $"SELECT * FROM dbo.Platforms WHERE PlatformId = '{Id}';";
        //        return QueryExecutor.FirstOrDefault<TemplateClass<Platforms>>(sql).Result;
        //    }
        //    public static bool Insert(Platforms p)
        //    {
        //        string sql = $"Insert Into dbo.Platforms (Name,IconeUrl)" +
        //            $" output INSERTED.Name as Result VALUES " +
        //            $"('{p.Name}','{p.IconUrl}');";
        //        return QueryExecutor.FirstOrDefault<TemplateClass<Platforms>>(sql).Result;
        //    }
        //    public static bool Update(Platforms p)
        //    {
        //        string sql = $"UPDATE dbo.Platforms (Name='{p.Name}',IconUrl='{p.IconUrl}') where PlatformId='{p.PlatformId}'";

        //        return QueryExecutor.FirstOrDefault<TemplateClass<Platforms>>(sql).Result;
        //    }
        //    public static bool Delete(long Id)
        //    {
        //        string sql = $"DELETE FROM dbo.Platforms WHERE PlatformId = '{Id}';";
        //        return QueryExecutor.FirstOrDefault<TemplateClass<Platforms>>(sql).Result;
        //    }
        //}
    }
}
