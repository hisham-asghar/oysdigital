using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectPlatformsDao
    {
        public static List<ProjectPlatforms> GetAll()
        {
            return TableConstants.ProjectPlatforms.SelectAll<ProjectPlatforms>();
        }
        public static ProjectPlatforms GetById(long id)
        {
            return TableConstants.ProjectPlatforms.Select<ProjectPlatforms>((int)id);
        }
        public static List<ProjectPlatforms> GetByProjectId(long id)
        {
            var where = $"ProjectId = {id}";
            return TableConstants.ProjectPlatforms.SelectList<ProjectPlatforms>(where);
        }
        public static bool Insert(ProjectPlatforms projectplatforms)
        {
            return projectplatforms.Insert(TableConstants.ProjectPlatforms) > 0;
        }
        public static bool Update(ProjectPlatforms projectplatforms)
        {
            return projectplatforms.Update(TableConstants.ProjectPlatforms, (int)projectplatforms.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectPlatforms.Delete((int)id);
        }
    }
}
