using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class MobileDao
    {
        public static List<Mobile> GetAll()
        {
            string sql = $"SELECT * FROM dbo.Mobile;";
            return QueryExecutor.List<Mobile>(sql);
        }
        public static Mobile GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.Mobile WHERE MobileId = {Id};";
            return QueryExecutor.FirstOrDefault<Mobile>(sql);
        }
        public static bool Insert(Mobile c)
        {
            string sql = $"Insert Into dbo.Mobile (Name,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.MobileId as Result VALUES " +
                $"('{c.Name}','{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(Mobile c)
        {
            string sql = $"UPDATE dbo.Mobile Set Name='{c.Name}',IsActive='{c.IsActive}',ModifiedBy='{c.ModifiedBy}',OnModified='{c.OnModified}' output INSERTED.MobileId as Result where (MobileId = {c.MobileId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.Mobile output deleted.MobileId as Result WHERE MobileId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
    }
}
