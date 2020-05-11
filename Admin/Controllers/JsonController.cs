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
            var user = ProjectMembersBao.GetByUserId(User.GetUserId());
            if (user != null)
            {
                var data = WorkTaskBao.CheckTaskCreated(DateTime.Now.Date);
                if (data.Count == 0)
                {
                    List<ProjectTask> p = new List<ProjectTask>();
                    var projecttask = ProjectTaskBao.GetByProjectId(user.ProjectId);
                    if (projecttask != null)
                    {
                        foreach (var item in projecttask)
                        {
                            p.Add(ProjectTaskBao.GetById(item.Id));
                        }
                    }

                    var userId = User.GetUserId();
                    foreach (var work in p)
                    {

                        foreach (var item in work.ProjectTaskScheduling)
                        {
                            WorkTask workTask = new WorkTask();
                            workTask.SetOnCreate(userId);
                            workTask.OnCreated = DateTime.Now.Date;
                            workTask.OnModified = DateTime.Now.Date;
                            workTask.ProjectId = work.ProjectId;
                            workTask.ProjectSchedulingTime = item.Time;
                            var worktaskId = WorkTaskBao.Insert(workTask);

                            foreach (var pl in work.ProjectPlatforms)
                            {
                                WorkTaskPlatforms workTaskPlatforms = new WorkTaskPlatforms();
                                workTaskPlatforms.PlatformId = pl.PlatformId;
                                workTaskPlatforms.WorkTaskId = worktaskId;
                                workTaskPlatforms.Link = pl.Link;
                                WorkTaskPlatformsBao.Insert(workTaskPlatforms);

                            }

                        }
                    }
                    return Json(p);
                }
            }
            return Json(null);
        }
        [Route("/Json/GenerateTomorrowTask")]
        [HttpGet]
        public JsonResult GenerateTomorrowTask()
        {
            var dateTimetomorrow = DateTime.Now.AddDays(1);
            var data=WorkTaskBao.CheckTaskCreated(dateTimetomorrow.Date);
            if (data.Count == 0)
            {
                List<ProjectTask> p = new List<ProjectTask>();
                var projecttask = ProjectTaskBao.GetAll();
                if (projecttask != null)
                {
                    foreach (var item in projecttask)
                    {
                        p.Add(ProjectTaskBao.GetById(item.Id));
                    }
                }

                var userId = User.GetUserId();
                foreach (var work in p)
                {

                    foreach (var item in work.ProjectTaskScheduling)
                    {
                        WorkTask workTask = new WorkTask();
                        workTask.SetOnCreate(userId);
                        workTask.OnCreated = dateTimetomorrow.Date;
                        workTask.OnModified = dateTimetomorrow.Date;
                        workTask.ProjectId = work.ProjectId;
                        workTask.ProjectSchedulingTime = item.Time;
                        var worktaskId = WorkTaskBao.Insert(workTask);

                        foreach (var pl in work.ProjectPlatforms)
                        {
                            WorkTaskPlatforms workTaskPlatforms = new WorkTaskPlatforms();
                            workTaskPlatforms.PlatformId = pl.PlatformId;
                            workTaskPlatforms.WorkTaskId = worktaskId;
                            workTaskPlatforms.Link = pl.Link;
                            WorkTaskPlatformsBao.Insert(workTaskPlatforms);

                        }

                    }
                }
                return Json(p);
            }
                return Json(null);
           
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
                    }
                    if (user.MemberType == UserRoles.Scheduler)
                    {
                        workTaskPlatforms.IsScheduled = status;
                    }
                    if (WorkTaskPlatformsBao.Update(workTaskPlatforms))
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
            return Json(null);
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
                            }
                               
                        }
                        if (user.MemberType == UserRoles.Scheduler)
                        {
                            if (workTask.IsScheduled != true)
                            {
                                workTask.IsScheduled = true;
                                WorkTaskPlatformsBao.Update(workTask);
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
            if (ProjectTaskBao.GetById(id) != null)
            {
                return Json(ProjectTaskBao.Delete(id));
            }
            return Json(null);
        }
    }
}