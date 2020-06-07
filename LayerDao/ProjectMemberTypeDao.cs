using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;

namespace LayerDao
{
    public class ProjectMemberTypeDao
    {
        public static List<ProjectMemberTypes> GetAll()
        {
            return TableConstants.ProjectMemberTypes.SelectAll<ProjectMemberTypes>();
        }
        public static ProjectMemberTypes GetById(long id)
        {
            return TableConstants.ProjectMemberTypes.Select<ProjectMemberTypes>((int)id);
        }

        public static ProjectMemberTypes GetByName(string name)
        {
            var query = $"Select * From dbo.ProjectMemberTypes where Name='{name}'";
            return QueryExecutor.FirstOrDefault<ProjectMemberTypes>(query);
        }

        public static List<ProjectMemberTypes> GetByProjectId(long id)
        {
            var where = $"ProjectId={id}";
            return TableConstants.ProjectMemberTypes.SelectList<ProjectMemberTypes>(where);
        }
        public static bool Insert(ProjectMemberTypes projectmembertype)
        {
            return projectmembertype.Insert(TableConstants.ProjectMemberTypes) > 0;
        }
        public static bool Update(ProjectMemberTypes projectmembertype)
        {
            return projectmembertype.Update(TableConstants.ProjectMemberTypes, (int)projectmembertype.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectMemberTypes.Delete((int)id);
        }
    }
}
