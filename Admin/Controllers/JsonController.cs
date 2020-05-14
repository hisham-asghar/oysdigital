using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Web;
using Nancy.Json;
using Generics.Common;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Generics.DataModels.Constants;
using Admin.Models;
using Org.BouncyCastle.Bcpg;

namespace Admin.Controllers
{
    public class JsonController : Controller
    {
        [Route("/Json/Getplatforms/{id}")]
        [HttpGet]
        public JsonResult Getplatforms(long id)
        {
            var list = ProjectPlatformsBao.GetByProjectId(id);
            return Json(list);
        }
        [Route("/Json/GetMobileSpaces/{id}")]
        [HttpGet]
        public JsonResult GetMobileSpaces(long id)
        {
            var mob = MobileSpacesBao.GetAll();
            var list = ProjectTaskBao.GetByProjectId(id);
            return Json(mob);
        }
        [Route("/Json/GenerateTask")]
        [HttpGet]
        public JsonResult GenerateTask()
        {
            var  userId = User.GetUserId();
            var users = ProjectMembersBao.GetByUserIdList(User.GetUserId());
            var projecttasks = TaskHelper.GetProjectTask(users.Select(s => s.ProjectId).ToList());
            return Json(TaskHelper.WorkTaskToGenerate(projecttasks, DateTime.Now.Date, userId));
         
        }
        public List<ProjectTask> GetProjectTask(long id)
        {
            var List = new List<ProjectTask>();
            var projecttask = ProjectTaskBao.GetByProjectId(id);
            if (projecttask != null)
            {
                foreach (var item in projecttask)
                {
                    List.Add(ProjectTaskBao.GetById(item.Id));
                }
            }
            return List;
        }


        [Route("/Json/GenerateTomorrowTask")]
        [HttpGet]
        public JsonResult GenerateTomorrowTask()
        {
            var userId = User.GetUserId();
            var users = ProjectMembersBao.GetByUserIdList(User.GetUserId());
            var projecttasks = TaskHelper.GetProjectTask(users.Select(s => s.ProjectId).ToList());
            return Json(TaskHelper.WorkTaskToGenerate(projecttasks, DateTime.Now.AddDays(1).Date, userId));

        }

        [Route("/Json/SinglePlatform")]
        [HttpPost]
        public JsonResult SinglePlatform(long id,bool status)
        {

            var workTaskPlatforms = WorkTaskPlatformsBao.GetById(id);
            if (workTaskPlatforms != null)
            {
                
                var user = ProjectMembersBao.GetByUserId(User.GetUserId());
                if (user != null)
                {
                    if (user.MemberType==UserRoles.Designer)
                    {
                        workTaskPlatforms.IsDesigned = status;
                        WorkTaskPlatformsBao.Update(workTaskPlatforms);
                        if (showstatus(workTaskPlatforms.WorkTaskId, user.MemberType))
                        {
                            var worktask=WorkTaskBao.GetById(workTaskPlatforms.WorkTaskId);
                            worktask.IsDesigned = true;
                            WorkTaskBao.Update(worktask);
                        }
                    }
                    if (user.MemberType == UserRoles.Scheduler)
                    {
                        if (status == false)
                        {
                            workTaskPlatforms.IsCompleted = status;
                        }
                        workTaskPlatforms.IsScheduled = status;
                        WorkTaskPlatformsBao.Update(workTaskPlatforms);
                        if (showstatus(workTaskPlatforms.WorkTaskId, user.MemberType))
                        {
                            workTaskPlatforms.IsCompleted = true;
                            WorkTaskPlatformsBao.Update(workTaskPlatforms);
                            var worktask = WorkTaskBao.GetById(workTaskPlatforms.WorkTaskId);
                            worktask.IsScheduled = true;
                            worktask.IsCompleted = true;
                            WorkTaskBao.Update(worktask);
                        }
                    }
                        
                    
                        return Json(true);
                  
                    
                }
                return Json(null);
            }
            return Json(null);
        }
        public bool showstatus(long worktaskId,string role)
        {
            var data = WorkTaskPlatformsBao.GetByWorkTaskId(worktaskId);
            var count = 0;
            if (data.Count > 0)
            {
                foreach(var item in data)
                {
                    if (role == UserRoles.Designer)
                    {
                        if (item.IsDesigned == false)
                        {
                            count++;
                        }
                    }
                    if (role == UserRoles.Scheduler)
                    {
                        if (item.IsScheduled == false)
                        {
                            count++;
                        }
                    }

                }
              return  (count > 0) ? false : true;
            }
            else
            {
                return false;
            }
        }
        [Route("/Json/MultiPlatform")]
        [HttpPost]
        public JsonResult MultiPlatform(string[] id)
        {
            if (id.Length > 0)
            {
                var user = ProjectMembersBao.GetByUserId(User.GetUserId());
                foreach (var item in id)
                {
                    var workTask = WorkTaskPlatformsBao.GetById(item.ToLong());
                    if (workTask != null)
                    {
                        if (user.MemberType==UserRoles.Designer)
                        {
                            if (workTask.IsDesigned != true)
                            {
                                workTask.IsDesigned = true;
                                WorkTaskPlatformsBao.Update(workTask);
                                if (showstatus(workTask.WorkTaskId, user.MemberType))
                                {
                                    var worktask = WorkTaskBao.GetById(workTask.WorkTaskId);
                                    worktask.IsDesigned = true;
                                    WorkTaskBao.Update(worktask);
                                }
                            }
                               
                        }
                        if (user.MemberType == UserRoles.Scheduler)
                        {
                            if (workTask.IsScheduled != true)
                            {
                                workTask.IsScheduled = true;
                                WorkTaskPlatformsBao.Update(workTask);
                                if (showstatus(workTask.WorkTaskId, user.MemberType))
                                {
                                    workTask.IsCompleted = true;
                                    WorkTaskPlatformsBao.Update(workTask);
                                    var worktask = WorkTaskBao.GetById(workTask.WorkTaskId);
                                    worktask.IsScheduled = true;
                                    worktask.IsCompleted = true;
                                    WorkTaskBao.Update(worktask);
                                }
                            }
                        }
                        if (user.MemberType == UserRoles.Admin)
                        {
                            if (workTask.IsCompleted != true)
                            {
                                workTask.IsCompleted = true;
                                WorkTaskPlatformsBao.Update(workTask);
                            }

                        }

                    }

                }
                return Json(true);
            }
            return Json(null);
        }

        [Route("/Json/ReportTask/{id}")]
        [HttpGet]
        public JsonResult ReportTask(long id)
        {
            var workTasks = WorkTaskBao.GetById(id);
            if (workTasks != null)
            {
                workTasks.IsReported = true;
                workTasks.ReportedBy = User.GetUserId();
                if (WorkTaskBao.Update(workTasks))
                {
                    return Json(true);
                }
                else
                {
                    return Json(false);
                }
            }
            return Json(null);
        }

        [Route("/Json/ProjectTaskCreate")]
        [HttpPost]
        public JsonResult ProjectTaskCreate(ProjectView projectView)
        {
            if (projectView != null)
            {
                ProjectTask projectTask = new ProjectTask();
                projectTask.ProjectId = projectView.ProjectId;
                projectTask.TaskTypeId = TaskType.CheckTaskTypeByName(projectView.PlatformType);
                projectTask.Frequency = projectView.Quantity;
                if (projectView.PlatformType == "Stories")
                {
                    projectTask.FrequencyTypeId = projectView.StoryType;
                }
                else
                {
                    projectTask.FrequencyTypeId = 0;
                }
                var userId = User.GetUserId();
                projectTask.SetOnCreate(userId);
                long projecttaskId = ProjectTaskBao.Insert(projectTask);
                if (projecttaskId > 0)
                {
                    for (int x = 0; x < projectView.Quantity; x++)
                    {
                        ProjectTaskScheduling projectTaskScheduling = new ProjectTaskScheduling();
                        projectTaskScheduling.ProjectTaskId = projecttaskId;
                        projectTaskScheduling.Time = projectView.PlatformSchedulers[x];
                        ProjectTaskSchedulingBao.Insert(projectTaskScheduling);
                    }
                }
                else
                {
                    return Json(false);
                }
                return Json(true);
            }
            return Json(null);
        }
        [Route("/Json/DeletePlatformTask/{id}")]
        [HttpGet]
        public JsonResult DeletePlatformTask(long id)
        {
            var data = ProjectTaskBao.GetById(id);
            if (data != null)
            {
                var schedulars=ProjectTaskSchedulingBao.GetByProjectId(data.ProjectId);
                if (schedulars != null)
                {
                    foreach(var item in schedulars)
                    {
                       var check= ProjectTaskSchedulingBao.Delete(item.Id);
                    }
                }
                return Json(ProjectTaskBao.Delete(id));
            }
            return Json(null);
        }
        [Route("/Json/DeleteMember/{id}")]
        [HttpGet]
        public JsonResult DeleteMember(long id)
        {
            if (id != 0)
            {
                ProjectMembersBao.Delete(id);
                return Json(true);
            }
            return Json(false);

        }
        [Route("/Json/DashBoardFilter")]
        [HttpGet]
        public JsonResult DashBoardFilter(string startDate,string endDate,string userId)
        {
            if (startDate != null && endDate != null && userId != null)
            {
                var user = ProjectMembersBao.GetByUserIdList(User.GetUserId());
                var worktask = TaskHelper.GetWorkTask(user.Select(s => s.ProjectId).ToList());
               // return worktask.Where(s => ).;
            }
            return Json(false);
        }
    }
}