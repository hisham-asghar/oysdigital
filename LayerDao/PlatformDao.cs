using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class PlatformDao
    {
        public static List<Platform> GetAll()
        {
            string sql = $"SELECT * FROM dbo.Platform;";
            return QueryExecutor.List<Platform>(sql);
        }
        public static Platform GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.Platform WHERE PlatformId = {Id};";
            return QueryExecutor.FirstOrDefault<Platform>(sql);
        }
        public static List<Platform> GetByProjectId(long id)
        {
            var where = $"ProjectId = {id}";
            return TableConstants.Platform.SelectList<Platform>(where);
        }
        public static bool Insert(Platform p)
        {
            string sql = $"Insert Into dbo.Platform (PlatformName,IconUrl,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.PlatformId as Result VALUES " +
                $"('{p.PlatformName}','{p.IconUrl}','{p.IsActive}','{p.CreatedBy}','{p.ModifiedBy}','{p.OnCreated}','{p.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(Platform p)
        {
            string sql = $"UPDATE dbo.Platform Set PlatformName='{p.PlatformName}',IconUrl='{p.IconUrl}',IsActive='{p.IsActive}',ModifiedBy='{p.ModifiedBy}',OnModified='{p.OnModified}' output INSERTED.PlatformId as Result where (PlatformId={p.PlatformId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.Platform output deleted.PlatformId as Result WHERE PlatformId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
    }
}
