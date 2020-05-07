using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public static class ProjectTaskDao
    {
        public static List<ProjectTask> GetAll()
        {
            return TableConstants.ProjectTask.SelectAll<ProjectTask>();
        }
        public static ProjectTask GetById(long id)
        {
            return TableConstants.ProjectTask.Select<ProjectTask>((int)id);
        }
        public static List<ProjectTask> GetByProjectId(long id)
        {
            var where = $"ProjectId={id}";
            return TableConstants.ProjectTask.SelectList<ProjectTask>(where);
        }
        public static long Insert(ProjectTask projecttask)
        {
            return projecttask.Insert(TableConstants.ProjectTask);
        }
        public static bool Update(ProjectTask projecttask)
        {
            return projecttask.Update(TableConstants.ProjectTask, (int)projecttask.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectTask.Delete((int)id);
        }
    }
}
