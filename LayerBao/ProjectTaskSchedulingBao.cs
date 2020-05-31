using Generics.DataModels.AdminModels;
using LayerDao;
using System.Collections.Generic;

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
        public static bool Insert(ProjectTaskScheduling projectTaskScheduling)
        {
            return ProjectTaskSchedulingDao.Insert(projectTaskScheduling);
        }
        public static bool Insert(List<ProjectTaskScheduling> projectTaskSchedulings)
        {
            return ProjectTaskSchedulingDao.Insert(projectTaskSchedulings);
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
