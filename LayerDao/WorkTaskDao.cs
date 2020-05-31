﻿using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System;
using System.Collections.Generic;
using System.Linq;

namespace LayerDao
{
    public class WorkTaskDao
    {
        public static List<WorkTask> GetAll()
        {
            var query = $"select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId;";
            return QueryExecutor.List<WorkTask>(query);
        }
        public static WorkTask GetById(long id)
        {
            var query = $"select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where WorkTask.Id={id};";
            return QueryExecutor.FirstOrDefault<WorkTask>(query);
        }
        public static List<WorkTask> GetByProjectId(long id)
        {
            var today = DateTime.Now.Date;
            var tomorrow = DateTime.Now.AddDays(1).Date;
            var query = $"select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where WorkTask.ProjectId={id} AND WorkTask.OnCreated BETWEEN '{today}' AND '{tomorrow}' OR IsCompleted='false';";
            return QueryExecutor.List<WorkTask>(query);
        }


        public static List<WorkTask> GetByProjectIds(List<long> ids)
        {
            if (ids == null || ids.Count == 0) return new List<WorkTask>();
            string idStr;
            if (ids.Count == 1)
                idStr = ids.FirstOrDefault() + "";
            else idStr = ids.Select(id => id + "").Aggregate((c, n) => $"{c},{n}");
            return ViewConstants.WORK_TASK_VIEW.SelectList<WorkTask>($" ProjectId IN ({idStr}) ");
        }

        public static long Insert(WorkTask worktask)
        {
            return worktask.Insert(TableConstants.WorkTask);
        }
        public static bool Update(WorkTask worktask)
        {
            return worktask.Update(TableConstants.WorkTask, (int)worktask.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.WorkTask.Delete((int)id);
        }
        public static List<WorkTask> CheckTaskCreated(DateTime date)
        {
            var query = $"Select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where WorkTask.OnCreated='{date}';";
            return QueryExecutor.List<WorkTask>(query);
        }

        public static WorkTask CheckSchedulingTaskExist(ProjectTaskScheduling scheduling, DateTime date)
        {
            var query = $"Select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where ProjectSchedulingTime='{scheduling.Time}' AND WorkTask.OnCreated='{date}';";
            return QueryExecutor.FirstOrDefault<WorkTask>(query);
        }
    }
}
