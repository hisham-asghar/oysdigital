using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public static class ProjectTaskSchedulingBao
    {
        public static List<ProjectTaskScheduling> GetAll()
        {
            return ProjectTaskSchedulingDao.GetAll();
        }
        public static ProjectTaskScheduling GetById(long id)
        {
            return ProjectTaskSchedulingDao.GetById(id);
        }
        public static List<ProjectTaskScheduling> GetByProjectId(long id)
        {
            return ProjectTaskSchedulingDao.GetByProjectTaskId(id);
        }
        public static bool Insert(ProjectTaskScheduling projecttaskscheduling)
        {
            return ProjectTaskSchedulingDao.Insert(projecttaskscheduling);
        }
        public static bool Update(ProjectTaskScheduling projecttaskscheduling)
        {
            return ProjectTaskSchedulingDao.Update(projecttaskscheduling);
        }
        public static bool Delete(long id)
        {
            return ProjectTaskSchedulingDao.Delete(id);
        }
    }
}
