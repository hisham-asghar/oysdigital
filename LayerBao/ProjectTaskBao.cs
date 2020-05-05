using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public static class ProjectTaskBao
    {
        public static List<ProjectTask> GetAll()
        {
            return ProjectTaskDao.GetAll();
        }
        public static ProjectTask GetById(long id)
        {
            var projectTask = ProjectTaskDao.GetById(id);
            if (projectTask != null)
            {
                projectTask.ProjectTaskScheduling = ProjectTaskSchedulingDao.GetByProjectId(id);
            }
            return projectTask;
        }
        public static List<ProjectTask> GetByProjectId(long id)
        {
            return ProjectTaskDao.GetByProjectId(id);
        }
        public static bool Insert(ProjectTask projecttask)
        {
            return ProjectTaskDao.Insert(projecttask);
        }
        public static bool Update(ProjectTask projecttask)
        {
            return ProjectTaskDao.Update(projecttask);
        }
        public static bool Delete(long id)
        {
            return ProjectTaskDao.Delete(id);
        }
    }
}
