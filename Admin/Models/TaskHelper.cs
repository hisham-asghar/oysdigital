using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Enums;
using LayerBao;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Admin.Models
{
    public static class TaskHelper
    {
        public static List<UserTask> GetUserTasks(string userId)
        {
            if (userId == null) return new List<UserTask>();

            return WorkTaskMembersBao.GetUserTasks(userId);
        }
        public static StatsModel GetUserStats(string userId)
        {
            var data = GetUserTasks(userId);
            if (data == null) return null;

            var groupedData = data.GroupBy(d => new
            {
                d.ProjectId,
                d.ProjectSchedulingTime.Date,
            }).ToDictionary(k => k.Key, v => v.ToList());


            var today = DateTime.UtcNow.AddHours(5);
            var statsModel = new StatsModel();
            statsModel.OverallTotal = groupedData.Count();
            statsModel.OverallDone = groupedData.Count(d => d.Value.All(t => t.IsDone()));
            statsModel.OverallDonePercent = statsModel.OverallTotal == 0 ? 0 : ((int)((statsModel.OverallDone * 100 * 100) / statsModel.OverallTotal)) / 100.0;
            statsModel.OverallPending = statsModel.OverallTotal - statsModel.OverallDone;


            var currentMonthData = groupedData.Where(g => g.Key.Date.ToString("yyyyMM") == today.ToString("yyyyMM"));
            statsModel.CurrentMonthTotal = currentMonthData.Count();
            statsModel.CurrentMonthDone = currentMonthData.Count(d => d.Value.All(t => t.IsDone()));
            statsModel.CurrentMonthDonePercent = statsModel.CurrentMonthTotal == 0 ? 0 : ((int)((statsModel.CurrentMonthDone * 100 * 100) / statsModel.CurrentMonthTotal)) / 100.0;
            statsModel.CurrentMonthPending = statsModel.CurrentMonthTotal - statsModel.CurrentMonthDone;

            var currentWeekData = groupedData.Where(d => d.Key.Date.DateInsideOneWeek(today));
            statsModel.CurrentWeekTotal = currentWeekData.Count();
            statsModel.CurrentWeekDone = currentWeekData.Count(d => d.Value.All(t => t.IsDone()));
            statsModel.CurrentWeekDonePercent = statsModel.CurrentWeekTotal == 0 ? 0 : ((int)((statsModel.CurrentWeekDone * 100 * 100) / statsModel.CurrentWeekTotal)) / 100.0;
            statsModel.CurrentWeekPending = statsModel.CurrentWeekTotal - statsModel.CurrentWeekDone;

            var todayData = groupedData.Where(d => d.Key.Date == today.Date);
            statsModel.TodayTotal = todayData.Count();
            statsModel.TodayDone = todayData.Count(d => d.Value.All(t => t.IsDone()));
            statsModel.TodayDonePercent = statsModel.TodayTotal == 0 ? 0 : ((int)((statsModel.TodayDone * 100 * 100) / statsModel.TodayTotal)) / 100.0;
            statsModel.TodayPending = statsModel.TodayTotal - statsModel.TodayDone;


            var tomorrowData = groupedData.Where(d => d.Key.Date == today.Date.AddDays(1));
            statsModel.TomorrowTotal = tomorrowData.Count();
            statsModel.TomorrowDone = tomorrowData.Count(d => d.Value.All(t => t.IsDone()));
            statsModel.TomorrowDonePercent = statsModel.TomorrowTotal == 0 ? 0 : ((int)((statsModel.TomorrowDone * 100 * 100) / statsModel.TomorrowTotal)) / 100.0;
            statsModel.TomorrowPending = statsModel.TomorrowTotal - statsModel.TomorrowDone;

            return statsModel;
        }
        public static List<WorkTaskMembers> GetAllTask()
        {
            return WorkTaskMembersBao.GetAllTask();
        }
        public static List<WorkTaskMembers> GetTaskCount(string userId)
        {
            if (userId != null)
            {
                return WorkTaskMembersBao.GetByUserId(userId);
            }
            return new List<WorkTaskMembers>();
        }
        public static List<ProjectTask> GetProjectTask(List<long> item)
        {
            if (item.Count > 0)
            {
                var projectTaskList = new List<ProjectTask>();
                foreach (var id in item)
                {

                    var projectTask = ProjectTaskBao.GetByProjectId(id);
                    if (projectTask != null)
                    {
                        foreach (var task in projectTask)
                        {
                            var List = new List<ProjectTask>();
                            List.Add(ProjectTaskBao.GetById(task.Id));
                            if (List != null)
                            {
                                projectTaskList.AddRange(List);
                            }
                        }
                    }
                }
                return projectTaskList;
            }
            else
            {
                return new List<ProjectTask>();
            }
        }
        public static List<WorkTask> GetWorkTask(List<long> item)
        {
            if (item.Count <= 0)
                return new List<WorkTask>();

            var workTaskList = new List<WorkTask>();
            foreach (var id in item)
            {
                var projectTask = WorkTaskBao.GetByProjectId(id);
                if (projectTask != null)
                {
                    foreach (var task in projectTask)
                    {
                        var list = new List<WorkTask>
                            {
                                WorkTaskBao.GetById(task.Id)
                            };
                        workTaskList.AddRange(list);
                    }
                }
            }
            return workTaskList;
        }
        public static List<WorkTask> GetWorkTasksByProjectIds(List<long> item, string userId)
        {
            if (item.Count <= 0)
                return new List<WorkTask>();

            return WorkTaskBao.GetByProjectIds(item, userId);
        }

        public static List<WorkTask> GetWorkTasksByUserId(string userId)
        {
            if (string.IsNullOrWhiteSpace(userId))
                return new List<WorkTask>();

            return WorkTaskBao.GetByUserId(userId);
        }
        public static List<WorkTask> GetWorkTask(string userId, TaskTimeFilter time, TaskStatusFilter status)
        {
            var workTasks = GetWorkTasksByUserId(userId);
            var today = DateTime.Now;
            switch (time)
            {
                case TaskTimeFilter.Today:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.Date == today.Date).ToList();
                        break;
                    }

                case TaskTimeFilter.Tomorrow:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.Date == today.Date.AddDays(1)).ToList();
                        break;
                    }

                case TaskTimeFilter.CurrentWeek:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.DateInsideOneWeek(today)).ToList();
                        break;
                    }
                case TaskTimeFilter.CurrentMonth:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.Month == today.Month && w.OnCreated.Year == today.Year).ToList();
                        break;
                    }
            }

            switch (status)
            {
                case TaskStatusFilter.Done:
                    {
                        workTasks = workTasks.Where(w => w.IsDone()).ToList();
                        break;
                    }

                case TaskStatusFilter.Pending:
                    {
                        workTasks = workTasks.Where(w => w.IsPending()).ToList();
                        break;
                    }
            }


            return workTasks;
        }

        public static List<WorkTask> GetWorkTask(List<long> item, string userId, TaskTimeFilter time, TaskStatusFilter status)
        {
            var workTasks = GetWorkTasksByProjectIds(item, userId);
            var today = DateTime.Now;
            switch (time)
            {
                case TaskTimeFilter.Today:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.Date == today.Date).ToList();
                        break;
                    }

                case TaskTimeFilter.Tomorrow:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.Date == today.Date.AddDays(1)).ToList();
                        break;
                    }

                case TaskTimeFilter.CurrentWeek:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.DateInsideOneWeek(today)).ToList();
                        break;
                    }
                case TaskTimeFilter.CurrentMonth:
                    {
                        workTasks = workTasks.Where(w => w.ProjectSchedulingTime.Month == today.Month && w.OnCreated.Year == today.Year).ToList();
                        break;
                    }
            }

            switch (status)
            {
                case TaskStatusFilter.Done:
                    {
                        workTasks = workTasks.Where(w => w.IsDone()).ToList();
                        break;
                    }

                case TaskStatusFilter.Pending:
                    {
                        workTasks = workTasks.Where(w => w.IsPending()).ToList();
                        break;
                    }
            }


            return workTasks;
        }
        public static bool WorkTaskStatus(List<ProjectTask> projectTask, DateTime date)
        {
            if (projectTask.Count > 0)
            {
                var list = new List<WorkTask>();
                foreach (var item in projectTask)
                {
                    foreach (var scheduling in item.ProjectTaskScheduling)
                    {
                        var workTask1 = WorkTaskBao.CheckSchedulingTaskExist(scheduling, date);
                        if (workTask1 != null)
                        {
                            foreach (var workTaskPlatforms in item.ProjectPlatforms)
                            {
                                if (!WorkTaskPlatformsBao.CheckWorkTaskPlatformExist(workTask1.Id, workTaskPlatforms.PlatformId))
                                {
                                    return true;
                                }
                            }
                        }
                        else
                        {
                            return true;
                        }
                    }
                    return false;
                }
            }
            else
            {
                return false;
            }
            return false;
        }
        public static bool WorkTaskToGenerate(List<ProjectTask> projectTask, DateTime date, string userId)
        {
            if (projectTask.Count > 0)
            {
                var list = new List<WorkTask>();
                foreach (var item in projectTask)
                {
                    foreach (var scheduling in item.ProjectTaskScheduling)
                    {
                        var workTask1 = WorkTaskBao.CheckSchedulingTaskExist(scheduling, date);
                        if (workTask1 != null)
                        {
                            foreach (var workTaskPlatforms in item.ProjectPlatforms)
                            {
                                if (!WorkTaskPlatformsBao.CheckWorkTaskPlatformExist(workTask1.Id, workTaskPlatforms.PlatformId))
                                {
                                    WorkTaskPlatforms workTaskPlatform = new WorkTaskPlatforms();
                                    workTaskPlatform.PlatformId = workTaskPlatforms.PlatformId;
                                    workTaskPlatform.WorkTaskId = workTask1.Id;
                                    workTaskPlatform.Link = workTaskPlatforms.Link;
                                    var data = WorkTaskPlatformsBao.Insert(workTaskPlatform);
                                }
                            }
                        }
                        else
                        {
                            WorkTask workTask = new WorkTask();
                            workTask.SetOnCreate(userId);
                            workTask.OnCreated = date;
                            workTask.OnModified = date;
                            workTask.ProjectId = item.ProjectId;
                            workTask.ProjectSchedulingTime = new DateTime(date.Year, date.Month, date.Day, scheduling.Time.Hour, scheduling.Time.Minute, scheduling.Time.Second);
                            var worktaskId = WorkTaskBao.Insert(workTask);
                            workTask.Id = worktaskId;
                            WorkTaskMembersCreate(workTask, userId);
                            foreach (var sch in item.ProjectPlatforms)
                            {
                                WorkTaskPlatforms workTaskPlatforms = new WorkTaskPlatforms();
                                workTaskPlatforms.PlatformId = sch.PlatformId;
                                workTaskPlatforms.WorkTaskId = worktaskId;
                                workTaskPlatforms.Link = sch.Link;
                                WorkTaskPlatformsBao.Insert(workTaskPlatforms);
                            }
                        }
                    }
                    return false;
                }
            }
            else
            {
                return false;
            }
            return true;
        }
        public static bool WorkTaskMembersCreate(WorkTask workTask, string userId)
        {
            if (workTask != null)
            {
                var data = ProjectMembersBao.GetByProjectId(workTask.ProjectId);
                if (data != null)
                {
                    foreach (var member in data)
                    {
                        if (!WorkTaskMembersBao.CheckMemberExists(member.AspNetUserId, member.ProjectMemberTypeId, workTask.Id))
                        {
                            var workTaskMembers = new WorkTaskMembers();
                            workTaskMembers.AspNetUserId = member.AspNetUserId;
                            workTaskMembers.MemberTypeId = member.ProjectMemberTypeId;
                            workTaskMembers.IsActive = true;
                            workTaskMembers.WorkTaskId = workTask.Id;
                            workTaskMembers.SetOnCreate(userId);
                            WorkTaskMembersBao.Insert(workTaskMembers);
                        }
                    }
                }

            }
            return false;
        }
    }
}
