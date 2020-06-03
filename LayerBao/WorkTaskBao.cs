using Generics.Common;
using Generics.DataModels.AdminModels;
using LayerDao;
using System;
using System.Collections.Generic;
using System.Linq;

namespace LayerBao
{
    public class WorkTaskBao
    {
        public static List<WorkTask> GetAll()
        {
            var data = WorkTaskDao.GetAll();
            if (data != null)
            {
                foreach (var item in data)
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
        public static List<WorkTask> GetByProjectIdAll(long id)
        {
            var data = WorkTaskDao.GetByProjectIdAll(id);
            return data;
        }
        public static List<WorkTask> GetByProjectIds(List<long> ids, string userId)
        {
            var data = WorkTaskDao.GetByProjectIds(ids);
            if (data != null)
            {
                var platforms = (WorkTaskPlatformsDao.GetByProjectIds(ids) ?? new List<WorkTaskPlatforms>())
                    .GroupBy(p => p.WorkTaskId).ToDictionary(p => p.Key, v => v.ToList());
                var members = (WorkTaskMembersDao.GetWorkTaskMemberTypeByUserId(userId) ?? new List<WorkTaskMemberCompact>());
                foreach (var item in data)
                {
                    item.WorkTaskPlatforms = platforms.Get(item.Id);
                    item.MemberType = members.FirstOrDefault(m => m.WorkTaskId == item.Id)?.MemberType;
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
            return WorkTaskDao.CheckSchedulingTaskExist(scheduling, date);
        }

    }
}
