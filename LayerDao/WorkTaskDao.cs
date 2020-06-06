using Generics.DataModels.AdminModels;
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
        public static List<WorkTask> GetByProjectIdAll(long id)
        {
            var today = DateTime.Now.Date;
            var query = $"select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where WorkTask.ProjectId={id} AND WorkTask.OnCreated='{today}';";
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

        public static bool MarkDesignDone(int projectId, string userId, DateTime date)
        {
            if (date < DateTime.UtcNow.AddHours(5).Date) return false;
            var query = $"EXEC dbo.MarkDesignDone {projectId},'{userId}', '{(date.ToString("MM-dd-yyyy"))}'";
            return QueryExecutor.ExecuteDml(query);
        }
        public static bool MarkPlatformScheduleDone(int projectId, string userId, DateTime date, string platformIds)
        {
            if (date < DateTime.UtcNow.AddHours(5).Date) return false;
            var query = $"EXEC [dbo].[MarkScheduleDone] {projectId},'{userId}', '{(date.ToString("MM-dd-yyyy"))}', '{platformIds}'";
            return QueryExecutor.ExecuteDml(query);
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
            var taskTime = new DateTime(date.Year, date.Month, date.Day, scheduling.Time.Hour, scheduling.Time.Minute, scheduling.Time.Second);
            var query = $"Select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where ProjectSchedulingTime='{taskTime}';";
            return QueryExecutor.FirstOrDefault<WorkTask>(query);
        }


        public static bool GenerateTasks(DateTime date, string userId)
        {
            var query = $"EXEC dbo.GetGenerateableTasks '{(date.ToString("MM-dd-yyyy"))}'";
            var projectTasks = QueryExecutor.List<WorkTask>(query) ?? new List<WorkTask>();
            projectTasks.ForEach(w =>
            {
                w.SetOnCreate(userId);
            });
            var taskIds = projectTasks.Insert("WorkTask") ?? new List<int>();
            var workTaskMembersQuery = $"EXEC dbo.GetGenerateableTaskMembers '{(date.ToString("MM-dd-yyyy"))}'";
            var workTaskMembers = (QueryExecutor.List<WorkTaskMembers>(workTaskMembersQuery) ?? new List<WorkTaskMembers>());
            //.Where(w => taskIds.Contains((int)w.WorkTaskId)).ToList();

            workTaskMembers.ForEach(w =>
            {
                w.SetOnCreate(userId);
            });

            var workTaskMembersIds = workTaskMembers.Insert("WorkTaskMembers") ?? new List<int>();

            var workTaskPlatformsQuery = $"EXEC dbo.GetGenerateableTaskPlatforms '{(date.ToString("MM-dd-yyyy"))}'";
            var workTaskPlatforms = (QueryExecutor.List<WorkTaskPlatforms>(workTaskPlatformsQuery) ?? new List<WorkTaskPlatforms>());
            //.Where(w => taskIds.Contains((int)w.WorkTaskId)).ToList();

            workTaskPlatforms.ForEach(w =>
            {
                w.IsCompleted = w.IsDesigned = w.IsScheduled = false;
            });

            var workTaskPlatformsIds = workTaskPlatforms.Insert("WorkTaskPlatforms") ?? new List<int>();

            return true;
            return QueryExecutor.FirstOrDefault<WorkTaskPlatforms>(query) == null ? false : true;
        }
    }
}
