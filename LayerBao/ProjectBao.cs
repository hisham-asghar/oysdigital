using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectBao
    {
        public static List<Project> GetAll()
        {
            return ProjectDao.GetAll();
        }
        public static Project GetById(long id)
        {
            return ProjectDao.GetById(id);
        }
        public static bool Insert(Project c)
        {
            return ProjectDao.Insert(c);
        }
        public static bool Update(Project c)
        {
            return ProjectDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return ProjectDao.Delete(id);
        }
    }
}
