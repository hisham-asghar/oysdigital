using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectPlatformsBao
    {
        public static List<ProjectPlatforms> GetAll()
        {
            return ProjectPlatformsDao.GetAll();
        }
        public static ProjectPlatforms GetById(long id)
        {
            return ProjectPlatformsDao.GetById(id);
        }
        public static List<Project> GetByProjectId(long id)
        {
            return ProjectPlatformsDao.GetByProjectId(id);
        }
        public static bool Insert(ProjectPlatforms projectplatforms)
        {
            return ProjectPlatformsDao.Insert(projectplatforms);
        }
        public static bool Update(ProjectPlatforms projectplatforms)
        {
            return ProjectPlatformsDao.Update(projectplatforms);
        }
        public static bool Delete(long id)
        {
            return ProjectPlatformsDao.Delete(id);
        }
    }
}
