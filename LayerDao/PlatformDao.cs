using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class PlatformDao
    {
        public static List<Platforms> GetAll()
        {
            string sql = $"SELECT * FROM dbo.Platforms;";
            return QueryExecutor.List<Platforms>(sql);
        }
        public static Platforms GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.Platforms WHERE PlatformId = {Id};";
            return QueryExecutor.FirstOrDefault<Platforms>(sql);
        }
        public static bool Insert(Platforms p)
        {
            string sql = $"Insert Into dbo.Platforms (Name,IconUrl,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.PlatformId as Result VALUES " +
                $"('{p.Name}','{p.IconUrl}','{p.IsActive}','{p.CreatedBy}','{p.ModifiedBy}','{p.OnCreated}','{p.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(Platforms p)
        {
            string sql = $"UPDATE dbo.Platforms Set Name='{p.Name}',IconUrl='{p.IconUrl}',IsActive='{p.IsActive}',ModifiedBy='{p.ModifiedBy}',OnModified='{p.OnModified}' output INSERTED.PlatformId as Result where (PlatformId={p.PlatformId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.Platforms output deleted.PlatformId as Result WHERE PlatformId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
    }
}
