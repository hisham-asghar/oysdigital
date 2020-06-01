using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectMembersDao
    {
        public static List<ProjectMembers> GetAll()
        {
            var query = $"SELECT  ProjectMembers.*,ProjectMemberTypes.Name as MemberType,AspNetUsers.Name as MemberName  FROM [dbo].[ProjectMembers] Join dbo.ProjectMemberTypes on ProjectMemberTypes.Id=ProjectMembers.ProjectMemberTypeId Join dbo.AspNetUsers on AspNetUsers.Id=ProjectMembers.AspNetUserId;";
            return QueryExecutor.List<ProjectMembers>(query);
        }
        public static ProjectMembers GetById(long id)
        {
            var query = $"SELECT  ProjectMembers.*,ProjectMemberTypes.Name as MemberType,AspNetUsers.Name as MemberName  FROM [dbo].[ProjectMembers] Join dbo.ProjectMemberTypes on ProjectMemberTypes.Id=ProjectMembers.ProjectMemberTypeId Join dbo.AspNetUsers on AspNetUsers.Id=ProjectMembers.AspNetUserId where ProjectMembers.Id={id};";
            return QueryExecutor.FirstOrDefault<ProjectMembers>(query);
        }
        public static List<ProjectMembers> GetByUserIdList(string id)
        {
            var query = $"SELECT  ProjectMembers.*,ProjectMemberTypes.Name as MemberType,AspNetUsers.Name as MemberName  FROM [dbo].[ProjectMembers] Join dbo.ProjectMemberTypes on ProjectMemberTypes.Id=ProjectMembers.ProjectMemberTypeId Join dbo.AspNetUsers on AspNetUsers.Id=ProjectMembers.AspNetUserId where ProjectMembers.AspnetUserId='{id}';";
            return QueryExecutor.List<ProjectMembers>(query);
        }
        public static ProjectMembers GetByUserId(string id)
        {
            var query = $"SELECT  ProjectMembers.*,ProjectMemberTypes.Name as MemberType,AspNetUsers.Name as MemberName  FROM [dbo].[ProjectMembers] Join dbo.ProjectMemberTypes on ProjectMemberTypes.Id=ProjectMembers.ProjectMemberTypeId Join dbo.AspNetUsers on AspNetUsers.Id=ProjectMembers.AspNetUserId where ProjectMembers.AspnetUserId='{id}';";
            return QueryExecutor.FirstOrDefault<ProjectMembers>(query);
        }
        public static List<ProjectMembers> GetByProjectId(long id)
        {
            var query = $"SELECT  ProjectMembers.*,ProjectMemberTypes.Name as MemberType,AspNetUsers.Name as MemberName  FROM [dbo].[ProjectMembers] Join dbo.ProjectMemberTypes on ProjectMemberTypes.Id=ProjectMembers.ProjectMemberTypeId Join dbo.AspNetUsers on AspNetUsers.Id=ProjectMembers.AspNetUserId where ProjectId={id};";
            return QueryExecutor.List<ProjectMembers>(query);
        }
        public static long Insert(ProjectMembers projectmembers)
        {
            return projectmembers.Insert(TableConstants.ProjectMembers);
        }
        public static bool Update(ProjectMembers projectmembers)
        {
            return projectmembers.Update(TableConstants.ProjectMembers, (int)projectmembers.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectMembers.Delete((int)id);
        }
    }
}
