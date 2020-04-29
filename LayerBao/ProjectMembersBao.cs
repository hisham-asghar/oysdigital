using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectMembersBao
    {
        public static List<ProjectMembers> GetAll()
        {
            return ProjectMembersDao.GetAll();
        }
        public static ProjectMembers GetById(long id)
        {
            return ProjectMembersDao.GetById(id);
        }
        //public static List<ProjectMembers> GetByProjectId(long id)
        //{
        //    return ProjectMembersDao.GetByProjectId(id);
        //}
        public static bool Insert(ProjectMembers projectmember)
        {
            return ProjectMembersDao.Insert(projectmember);
        }
        public static bool Update(ProjectMembers projectmember)
        {
            return ProjectMembersDao.Update(projectmember);
        }
        public static bool Delete(long id)
        {
            return ProjectMembersDao.Delete(id);
        }
    }
}
