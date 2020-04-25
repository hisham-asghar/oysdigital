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
            string sql = $"SELECT * FROM dbo.Project;";
            return QueryExecutor.List<Project>(sql);
        }
        public static Project GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.Project WHERE ProjectId = {Id};";
            return QueryExecutor.FirstOrDefault<Project>(sql);
        }
        public static bool Insert(Project c)
        {
            string sql = $"Insert Into dbo.Project (Name,Guid,ProjectStatusId,CustomerId,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectId as Result VALUES " +
                $"('{c.Name}','{c.Guid}',{c.ProjectStatusId},{c.CustomerId},'{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";

            long data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result;
            return data == 0 ? true : false;
        }
        public static bool Update(Project c)
        {
            string sql = $"UPDATE dbo.Project Set Name='{c.Name}',ProjectStatusId={c.ProjectStatusId},CustomerId={c.CustomerId}" +
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
