using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectAlertMessageBao
    {
        public static List<ProjectAlertMessage> GetAll()
        {
            return ProjectAlertMessageDao.GetAll();
        }
        public static ProjectAlertMessage GetById(long id)
        {
            return ProjectAlertMessageDao.GetById(id);
        }
        public static bool Insert(ProjectAlertMessage c)
        {
            return ProjectAlertMessageDao.Insert(c);
        }
        public static bool Update(ProjectAlertMessage c)
        {
            return ProjectAlertMessageDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return ProjectAlertMessageDao.Delete(id);
        }
    }
}
