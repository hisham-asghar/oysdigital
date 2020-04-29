using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class ProjectDao
    {
        public static List<Project> GetAll()
        {
            string sql = $"SELECT * FROM dbo.Project JOIN dbo.Customer ON Project.CustomerId = Customer.CustomerId;";
            return QueryExecutor.List<Project>(sql);
        }
        public static Project GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.Project JOIN dbo.Customer ON Project.CustomerId = Customer.CustomerId WHERE ProjectId = {Id};";
            return QueryExecutor.FirstOrDefault<Project>(sql);
        }
        public static List<Project> GetByCustomerId(long Id)
        {
            string sql = $"SELECT * FROM dbo.Project JOIN dbo.Customer ON Project.CustomerId = {Id};";
            return QueryExecutor.List<Project>(sql);
        }
        public static bool Insert(Project c)
        {
            string sql = $"Insert Into dbo.Project (ProjectName,Guid,CustomerId,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectId as Result VALUES " +
                $"('{c.ProjectName}','{c.Guid}',{c.CustomerId},'{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";

            long data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result;
            return data == 0 ? true : false;
        }
        public static bool Update(Project c)
        {
            string sql = $"UPDATE dbo.Project Set ProjectName='{c.ProjectName}',CustomerId={c.CustomerId}" +
                $",IsActive='{c.IsActive}',ModifiedBy='{c.ModifiedBy}',OnModified='{c.OnModified}' output inserted.ProjectId as Result where (ProjectId={c.ProjectId})";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.Project output deleted.ProjectId as Result WHERE ProjectId = {Id};";
            var data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
            return data;
        }
    }
}
