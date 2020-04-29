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
            return TableConstants.ProjectMembers.SelectAll<ProjectMembers>();
        }
        public static ProjectMembers GetById(long id)
        {
            return TableConstants.ProjectMembers.Select<ProjectMembers>((int)id);
        }
        public static bool Insert(ProjectMembers projectmembers)
        {
            return projectmembers.Insert(TableConstants.ProjectMembers) > 0;
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
