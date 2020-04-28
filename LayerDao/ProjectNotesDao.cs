using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class ProjectNotesDao
    {
        public static List<ProjectNotes> GetAll()
        {
            string sql = $"SELECT * FROM dbo.ProjectNotes;";
            return QueryExecutor.List<ProjectNotes>(sql);
        }
        public static ProjectNotes GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectNotes WHERE ProjectNotesId = {Id};";
            return QueryExecutor.FirstOrDefault<ProjectNotes>(sql);
        }
        public static bool Insert(ProjectNotes c)
        {
            string sql = $"Insert Into dbo.ProjectNotes (Message,NoteTypeId,IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectNotesId as Result VALUES " +
                $"('{c.Message}',{c.NoteTypeId},'{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";

            long data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result;
            return data == 0 ? true : false;
        }
        public static bool Update(ProjectNotes c)
        {
            string sql = $"UPDATE dbo.ProjectNotes Set Message='{c.Message}',ProjectNotesId={c.ProjectNotesId}" +
                $",IsActive='{c.IsActive}',ModifiedBy='{c.ModifiedBy}',OnModified='{c.OnModified}' output inserted.ProjectNotesId as Result where (ProjectNotesId={c.ProjectNotesId})";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.ProjectNotes output deleted.ProjectNotesId as Result WHERE ProjectNotesId = {Id};";
            var data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
            return data;
        }
    }
}
