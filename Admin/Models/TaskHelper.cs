using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using LayerBao;
using Generics.WebHelper.Extensions;
using Microsoft.AspNetCore.Razor.Language;
using System.Reflection.Metadata.Ecma335;

namespace Admin.Models
{
    public static class TaskHelper
    {
        public static List<WorkTaskMembers> GetTaskCount(string userId,long memberTypeId)
        {
            if(userId!=null && memberTypeId > 0)
            {
               return WorkTaskMembersBao.GetByUserId(userId,memberTypeId);
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
            if (item.Count > 0)
            {
                var workTaskList = new List<WorkTask>();
                foreach (var id in item)
                {

                    var projectTask = WorkTaskBao.GetByProjectId(id);
                    if (projectTask != null)
                    {
                        foreach (var task in projectTask)
                        {
                            var List = new List<WorkTask>();
                            List.Add(WorkTaskBao.GetById(task.Id));
                            if (List != null)
                            {
                                workTaskList.AddRange(List);
                            }
                        }
                    }
                }
                return workTaskList;
            }
            else
            {
                return new List<WorkTask>();
            }
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
        public static bool WorkTaskToGenerate(List<ProjectTask> projectTask,DateTime date,string userId)
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
                            workTask.ProjectSchedulingTime = scheduling.Time;
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
        public static bool WorkTaskMembersCreate(WorkTask workTask ,string userId)
        {
            if(workTask != null)
            {
               var data = ProjectMembersBao.GetByProjectId(workTask.ProjectId);
                    if (data != null)
                    {
                        foreach(var member in data)
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
