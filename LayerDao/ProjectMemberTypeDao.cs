using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class ProjectMemberTypeDao
    {
        public static List<ProjectMemberTypes> GetAll()
        {
            string sql = $"SELECT * FROM dbo.ProjectMemberTypes;";
            return QueryExecutor.List<ProjectMemberTypes>(sql);
        }
        public static ProjectMemberTypes GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectMemberTypes WHERE ProjectMemberTypesId = {Id};";
            return QueryExecutor.FirstOrDefault<ProjectMemberTypes>(sql);
        }
        public static bool Insert(ProjectMemberTypes p)
        {
            string sql = $"Insert Into dbo.ProjectMemberTypes (ProjectMemberTypeName,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectMemberTypesId as Result VALUES " +
                $"('{p.ProjectMemberTypeName}','{p.IsActive}','{p.CreatedBy}','{p.ModifiedBy}','{p.OnCreated}','{p.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(ProjectMemberTypes p)
        {
            string sql = $"UPDATE dbo.ProjectMemberTypes Set ProjectMemberTypeName='{p.ProjectMemberTypeName}',IsActive='{p.IsActive}',ModifiedBy='{p.ModifiedBy}',OnModified='{p.OnModified}' output INSERTED.ProjectMemberTypesId as Result where (ProjectMemberTypesId={p.ProjectMemberTypesId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.ProjectMemberTypes output deleted.ProjectMemberTypesId as Result WHERE ProjectMemberTypesId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
    }
}
