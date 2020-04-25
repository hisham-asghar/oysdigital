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
        public static bool Insert(ProjectPlatforms c)
        {
            return ProjectPlatformsDao.Insert(c);
        }
        public static bool Update(ProjectPlatforms c)
        {
            return ProjectPlatformsDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return ProjectPlatformsDao.Delete(id);
        }
    }
}
