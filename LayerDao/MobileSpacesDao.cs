using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class MobileSpacesDao
    {
        public static List<MobileSpaces> GetAll()
        {
            string sql = $"SELECT * FROM dbo.MobileSpaces JOIN dbo.Mobile ON MobileSpaces.MobileId = Mobile.MobileId; ";
            var data=QueryExecutor.List<MobileSpaces>(sql);
            return data;
        }
        public static MobileSpaces GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.MobileSpaces JOIN dbo.Mobile ON MobileSpaces.MobileId = Mobile.MobileId WHERE MobileSpacesId = {Id};";
            return QueryExecutor.FirstOrDefault<MobileSpaces>(sql);
        }
        public static bool Insert(MobileSpaces p)
        {
            string sql = $"Insert Into dbo.MobileSpaces (SpaceName,MobileId,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.MobileSpacesId as Result VALUES " +
                $"('{p.SpaceName}',{p.MobileId},'{p.IsActive}','{p.CreatedBy}','{p.ModifiedBy}','{p.OnCreated}','{p.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(MobileSpaces p)
        {
            string sql = $"UPDATE dbo.MobileSpaces Set SpaceName='{p.SpaceName}',MobileId='{p.MobileId}',IsActive='{p.IsActive}',ModifiedBy='{p.ModifiedBy}',OnModified='{p.OnModified}' output INSERTED.MobileSpacesId as Result where (MobileSpacesId={p.MobileSpacesId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.MobileSpaces output deleted.MobileSpacesId as Result WHERE MobileSpacesId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
    }
}
