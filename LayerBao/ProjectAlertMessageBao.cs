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
        public static bool Insert(ProjectAlertMessage projectalertmessage)
        {
            return ProjectAlertMessageDao.Insert(projectalertmessage);
        }
        public static bool Update(ProjectAlertMessage projectalertmessage)
        {
            return ProjectAlertMessageDao.Update(projectalertmessage);
        }
        public static bool Delete(long id)
        {
            return ProjectAlertMessageDao.Delete(id);
        }
    }
}
