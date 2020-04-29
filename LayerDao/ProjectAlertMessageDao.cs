using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectAlertMessageDao
    {
        public static List<ProjectAlertMessage> GetAll()
        {
            return TableConstants.ProjectAlertMessage.SelectAll<ProjectAlertMessage>();
        }
        public static ProjectAlertMessage GetById(long id)
        {
            return TableConstants.ProjectAlertMessage.Select<ProjectAlertMessage>((int)id);
        }
        public static bool Insert(ProjectAlertMessage projectalertmessage)
        {
            return projectalertmessage.Insert(TableConstants.ProjectAlertMessage) > 0;
        }
        public static bool Update(ProjectAlertMessage projectalertmessage)
        {
            return projectalertmessage.Update(TableConstants.ProjectAlertMessage, (int)projectalertmessage.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectAlertMessage.Delete((int)id);
        }
    }
}
