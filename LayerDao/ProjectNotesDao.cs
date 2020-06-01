using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectNotesDao
    {
        public static List<ProjectNotes> GetAll()
        {
            var query = $"SELECT ProjectNotes.*, LabelType.Name as LabelName,LabelType.ColorCode as LabelColor FROM [dbo].ProjectNotes Join dbo.LabelType on ProjectNotes.LabelTypeId=LabelType.Id;";
            return QueryExecutor.List<ProjectNotes>(query);
        }
        public static ProjectNotes GetById(long id)
        {
            var query = $"SELECT ProjectNotes.*, LabelType.Name as LabelName,LabelType.ColorCode as LabelColor FROM [dbo].ProjectNotes Join dbo.LabelType on ProjectNotes.LabelTypeId=LabelType.Id where ProjectNotes.Id={id};";
            return QueryExecutor.FirstOrDefault<ProjectNotes>(query);
        }
        public static List<ProjectNotes> GetByProjectId(long id)
        {
            var query = $"SELECT ProjectNotes.*, LabelType.Name as LabelName,LabelType.ColorCode as LabelColor FROM [dbo].ProjectNotes Join dbo.LabelType on ProjectNotes.LabelTypeId=LabelType.Id where ProjectId={id};";
            return QueryExecutor.List<ProjectNotes>(query);
        }
        public static long Insert(ProjectNotes projectnotes)
        {
            return projectnotes.Insert(TableConstants.ProjectNotes);
        }
        public static bool Update(ProjectNotes projectnotes)
        {
            return projectnotes.Update(TableConstants.ProjectNotes, (int)projectnotes.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectNotes.Delete((int)id);
        }
    }
}
