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
        public static ProjectMemberTypes GetByName(string name)
        {
            return ProjectMemberTypeDao.GetByName(name);
        }
        public static bool Insert(ProjectMemberTypes projectmembertypes)
        {
            return ProjectMemberTypeDao.Insert(projectmembertypes);
        }
        public static bool Update(ProjectMemberTypes projectmembertypes)
        {
            return ProjectMemberTypeDao.Update(projectmembertypes);
        }
        public static bool Delete(long id)
        {
            return ProjectMemberTypeDao.Delete(id);
        }
    }
}
