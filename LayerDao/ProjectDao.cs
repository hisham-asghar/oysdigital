using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectDao
    {
        public static List<Project> GetAll()
        {
            return TableConstants.Project.SelectAll<Project>();
        }
        public static Project GetById(long id)
        {
            return TableConstants.Project.Select<Project>((int)id);
        }
        public static List<Project> GetByCustomerId(long id)
        {
            var where = $"CustomerId = {id}";
            return TableConstants.Project.SelectList<Project>(where);
        }
        public static bool Insert(Project project)
        {
            return project.Insert(TableConstants.Project) > 0;
        }
        public static bool Update(Project project)
        {
            return project.Update(TableConstants.Project, (int)project.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.Project.Delete((int)id);
        }
    }
}
