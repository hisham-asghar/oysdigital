using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class ProjectAlertMessageDao
    {
        public static List<ProjectAlertMessage> GetAll()
        {
            string sql = $"SELECT * FROM dbo.ProjectAlertMessages;";
            var data= QueryExecutor.List<ProjectAlertMessage>(sql);
            return data;
        }
        public static ProjectAlertMessage GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectAlertMessages WHERE ProjectAlertMessageId = {Id};";
            return QueryExecutor.FirstOrDefault<ProjectAlertMessage>(sql);
        }
        public static bool Insert(ProjectAlertMessage p)
        {
            string sql = $"Insert Into dbo.ProjectAlertMessages (Message,ProjectMessageTypeId,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectAlertMessageId as Result VALUES " +
                $"('{p.Message}',{p.ProjectMessageTypeId},'{p.IsActive}','{p.CreatedBy}','{p.ModifiedBy}','{p.OnCreated}','{p.OnModified}');";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Update(ProjectAlertMessage p)
        {
            string sql = $"UPDATE dbo.ProjectAlertMessages Set Message = '{p.Message}',ProjectAlertMessageId = {p.ProjectAlertMessageId},IsActive='{p.IsActive}',ModifiedBy='{p.ModifiedBy}',OnModified='{p.OnModified}' output INSERTED.ProjectAlertMessageId as Result where (ProjectAlertMessageId={p.ProjectAlertMessageId})";

            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.ProjectAlertMessages output deleted.ProjectAlertMessageId as Result WHERE ProjectAlertMessageId = {Id};";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true; ;
        }
    }
}
