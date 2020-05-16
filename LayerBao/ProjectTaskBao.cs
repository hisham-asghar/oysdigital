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
            var data= ProjectTaskDao.GetAll();
            if (data.Count > 0)
            {
                foreach (var item in data)
                {
                    if (item != null)
                    {
                        item.ProjectTaskScheduling = ProjectTaskSchedulingDao.GetByProjectTaskId(item.TaskTypeId);
                        item.ProjectPlatforms = ProjectPlatformsDao.GetByProjectId(item.ProjectId);
                    }

                }
            }
            return data;
        }
        public static ProjectTask GetById(long id)
        {
            var projectTask = ProjectTaskDao.GetById(id);
            if (projectTask != null)
            {
                projectTask.ProjectTaskScheduling = ProjectTaskSchedulingDao.GetByProjectTaskId(projectTask.Id);
                projectTask.ProjectPlatforms = ProjectPlatformsDao.GetByProjectId(projectTask.ProjectId);
            }
            return projectTask;
        }
        public static List<ProjectTask> GetByProjectId(long id)
        {
            var data= ProjectTaskDao.GetByProjectId(id);
            foreach(var item in data)
            {
                if (item != null)
                {
                    item.ProjectTaskScheduling = ProjectTaskSchedulingDao.GetByProjectTaskId(item.TaskTypeId);
                    item.ProjectPlatforms = ProjectPlatformsDao.GetByProjectId(item.ProjectId);
                }
                
            }
            return data;
        }
        public static long Insert(ProjectTask projecttask)
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
