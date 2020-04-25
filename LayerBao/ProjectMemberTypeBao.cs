using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectMemberTypeBao
    {
        public static List<ProjectMemberTypes> GetAll()
        {
            return ProjectMemberTypeDao.GetAll();
        }
        public static ProjectMemberTypes GetById(long id)
        {
            return ProjectMemberTypeDao.GetById(id);
        }
        public static bool Insert(ProjectMemberTypes c)
        {
            return ProjectMemberTypeDao.Insert(c);
        }
        public static bool Update(ProjectMemberTypes c)
        {
            return ProjectMemberTypeDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return ProjectMemberTypeDao.Delete(id);
        }
    }
}
