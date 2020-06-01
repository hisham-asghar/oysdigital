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
            var query = $"SELECT ProjectAlertMessage.*, LabelType.Name as LabelName,LabelType.ColorCode as LabelColor FROM [dbo].[ProjectAlertMessage] Join dbo.LabelType on ProjectAlertMessage.LabelTypeId=LabelType.Id;";
            return QueryExecutor.List<ProjectAlertMessage>(query);
        }
        public static ProjectAlertMessage GetById(long id)
        {
            var query = $"SELECT ProjectAlertMessage.*, LabelType.Name as LabelName,LabelType.ColorCode as LabelColor FROM [dbo].[ProjectAlertMessage] Join dbo.LabelType on ProjectAlertMessage.LabelTypeId=LabelType.Id where ProjectAlertMessage.Id={id};";
            return QueryExecutor.FirstOrDefault<ProjectAlertMessage>(query);
        }
        public static List<ProjectAlertMessage> GetByProjectId(long id)
        {
            var query = $"SELECT ProjectAlertMessage.*, LabelType.Name as LabelName,LabelType.ColorCode as LabelColor FROM [dbo].[ProjectAlertMessage] Join dbo.LabelType on ProjectAlertMessage.LabelTypeId=LabelType.Id where ProjectId={id};";
            return QueryExecutor.List<ProjectAlertMessage>(query);
        }
        public static long Insert(ProjectAlertMessage projectalertmessage)
        {
            return projectalertmessage.Insert(TableConstants.ProjectAlertMessage);
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
