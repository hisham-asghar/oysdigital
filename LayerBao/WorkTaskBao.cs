using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class WorkTaskBao
    {
        public static List<WorkTask> GetAll()
        {
            var data= WorkTaskDao.GetAll();
            if (data != null)
            {
                foreach(var item in data)
                {
                    item.WorkTaskPlatforms = WorkTaskPlatformsDao.GetByWorkTaskId(item.Id);
                }
            }
            return data;
        }
        public static WorkTask GetById(long id)
        {
            var worktask = WorkTaskDao.GetById(id);
            if (worktask != null) worktask.WorkTaskPlatforms = WorkTaskPlatformsDao.GetByWorkTaskId(id);
            return worktask;
        }
        public static List<WorkTask> GetByProjectId(long id)
        {
            var data = WorkTaskDao.GetByProjectId(id);
            if (data != null)
            {
                foreach (var item in data)
                {
                    item.WorkTaskPlatforms = WorkTaskPlatformsDao.GetByWorkTaskId(item.Id);
                }
            }
            return data;
        }
        public static long Insert(WorkTask worktask)
        {
            return WorkTaskDao.Insert(worktask);
        }
        public static bool Update(WorkTask worktask)
        {
            return WorkTaskDao.Update(worktask);
        }
        public static bool Delete(long id)
        {
            return WorkTaskDao.Delete(id);
        }
        public static List<WorkTask> CheckTaskCreated(DateTime date)
        {
            return WorkTaskDao.CheckTaskCreated(date);
        }

        public static WorkTask CheckSchedulingTaskExist(ProjectTaskScheduling scheduling, DateTime date)
        {
           return WorkTaskDao.CheckSchedulingTaskExist(scheduling,date);
        }
        
    }
}
