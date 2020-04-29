using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class ProjectMembersDao
    {
        public static List<ProjectMembers> GetAll()
        {
            string sql = $"SELECT * FROM dbo.ProjectMembers JOIN dbo.ProjectMemberTypes ON ProjectMembers.ProjectMemberTypesId = ProjectMemberTypes.ProjectMemberTypesId Join dbo.Project On Project.ProjectId=ProjectMembers.ProjectId;";
            return QueryExecutor.List<ProjectMembers>(sql);
        }
        public static ProjectMembers GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectMembers JOIN dbo.ProjectMemberTypes ON ProjectMembers.ProjectMemberTypesId = ProjectMemberTypes.ProjectMemberTypesId Join dbo.Project On Project.ProjectId=ProjectMembers.ProjectId WHERE ProjectMembersId = {Id};";
            return QueryExecutor.FirstOrDefault<ProjectMembers>(sql);
        }
        public static List<ProjectMembers> GetByProjectId(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectMembers JOIN dbo.ProjectMemberTypes ON ProjectMembers.ProjectMemberTypesId = ProjectMemberTypes.ProjectMemberTypesId Join dbo.Project On ProjectMembers.ProjectId={Id};";
            return QueryExecutor.List<ProjectMembers>(sql);
        }
        public static bool Insert(ProjectMembers p)
        {
            string sql = $"Insert Into dbo.ProjectMembers (ProjectMemberTypesId,ProjectId,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectMembersId as Result VALUES " +
                $"({p.ProjectMemberTypesId},{p.ProjectId},'{p.IsActive}','{p.CreatedBy}','{p.ModifiedBy}','{p.OnCreated}','{p.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(ProjectMembers p)
        {
            string sql = $"UPDATE dbo.ProjectMembers Set ProjectMemberTypesId={p.ProjectMemberTypesId},ProjectId={p.ProjectId},IsActive='{p.IsActive}',ModifiedBy='{p.ModifiedBy}',OnModified='{p.OnModified}' output INSERTED.ProjectMembersId as Result where (ProjectMembersId={p.ProjectMembersId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.ProjectMembers output deleted.ProjectMembersId as Result WHERE ProjectMembersId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
    }
}
