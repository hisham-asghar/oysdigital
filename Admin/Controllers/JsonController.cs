using Admin.Models;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;

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
        [Route("/Json/AllPlatforms")]
        [HttpGet]
        public JsonResult AllPlatforms()
        {
            var list = PlatformBao.GetAll();
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
            var userId = User.GetUserId();
            var date = DataConstants.LocalNow;
            WorkTaskBao.GenerateTasks(userId, date);

            //var users = ProjectMembersBao.GetByUserIdList(User.GetUserId());
            //var projectIds = users.Select(s => s.ProjectId).ToList();
            //if (User.IsAdminOrHr())
            //{
            //    projectIds = ProjectBao.GetAll().Select(p => p.Id).ToList();
            //}
            //var projecttasks = TaskHelper.GetProjectTask(projectIds);

            return Json(true);

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
            var date = DateTime.UtcNow.AddDays(1).AddHours(5);
            WorkTaskBao.GenerateTasks(userId, date);
            return Json(true);
            //var users = ProjectMembersBao.GetByUserIdList(User.GetUserId());
            //var projecttasks = TaskHelper.GetProjectTask(users.Select(s => s.ProjectId).ToList());
            //return Json(TaskHelper.WorkTaskToGenerate(projecttasks, DateTime.Now.AddDays(1).Date, userId));

        }

        [Route("/Json/ProjectDesignDone/{id}")]
        [HttpPost]
        public JsonResult ProjectDesignDone(int id, string date)
        {
            var parsedDate = DateTime.Parse(date);
            var userId = User.GetUserId();
            var status = WorkTaskBao.MarkDesignDone(id, userId, parsedDate);

            return Json(status);
        }

        [Route("/Json/PlatformScheduleDone")]
        [HttpPost]
        public JsonResult PlatformScheduleDone(int projectId, string platformIds, string date)
        {
            var parsedDate = DateTime.Parse(date);
            var userId = User.GetUserId();
            var status = WorkTaskBao.MarkPlatformScheduleDone(projectId, userId, parsedDate, platformIds);

            return Json(status);
        }


        [Route("/Json/SinglePlatform")]
        [HttpPost]
        public JsonResult SinglePlatform(List<long> projectPlatformList, bool status)
        {
            if (projectPlatformList != null)
            {
                foreach (var item in projectPlatformList)
                {
                    var workTaskPlatforms = WorkTaskPlatformsBao.GetById(item);
                    var user = ProjectMembersBao.GetByUserId(User.GetUserId());
                    if (user != null)
                    {
                        if (user.MemberType == UserRoles.Designer)
                        {
                            workTaskPlatforms.IsDesigned = status;
                            WorkTaskPlatformsBao.Update(workTaskPlatforms);
                            if (showstatus(workTaskPlatforms.WorkTaskId, user.MemberType))
                            {
                                var worktask = WorkTaskBao.GetById(workTaskPlatforms.WorkTaskId);
                                worktask.IsDesigned = true;
                                WorkTaskBao.Update(worktask);
                            }
                        }
                        if (user.MemberType == UserRoles.Scheduler)
                        {
                            workTaskPlatforms.IsScheduled = status;
                            workTaskPlatforms.IsCompleted = status;
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

                    }

                }
                return Json(true);
            }

            return Json(null);
        }
        public bool showstatus(long worktaskId, string role)
        {
            var data = WorkTaskPlatformsBao.GetByWorkTaskId(worktaskId);
            var count = 0;
            if (data.Count > 0)
            {
                foreach (var item in data)
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
                return (count > 0) ? false : true;
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
                    var data = WorkTaskPlatformsBao.GetByWorkTaskId(item.ToLong());
                    foreach (var workTask in data)
                    {
                        if (workTask != null)
                        {
                            if (user.MemberType == UserRoles.Designer)
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
                                    workTask.IsCompleted = true;
                                    WorkTaskPlatformsBao.Update(workTask);
                                    if (showstatus(workTask.WorkTaskId, user.MemberType))
                                    {
                                        workTask.IsCompleted = true;
                                        workTask.IsScheduled = true;
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
                var projectTaskId = ProjectTaskBao.Insert(projectTask);
                if (projectTaskId > 0 && projectView?.PlatformSchedulers != null && projectView.PlatformSchedulers.Count > 0)
                {
                    var tasks = projectView.PlatformSchedulers.Select(s => new ProjectTaskScheduling
                    {
                        ProjectTaskId = projectTaskId,
                        Time = s
                    }).ToList();
                    ProjectTaskSchedulingBao.Insert(tasks);
                }
                else
                {
                    return Json(false);
                }
                var data = ProjectTaskBao.GetById(projectTaskId);
                data.TaskType = TaskType.CheckTaskType(data.TaskTypeId);
                data.FrequencyType = FrequencyType.CheckFrequencyType(data.FrequencyTypeId);
                return Json(data);
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
                var schedulars = ProjectTaskSchedulingBao.GetByProjectId(data.ProjectId);
                if (schedulars != null)
                {
                    foreach (var item in schedulars)
                    {
                        var check = ProjectTaskSchedulingBao.Delete(item.Id);
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
                var member = ProjectMembersBao.GetById(id);
                var userId = User.GetUserId();
                var status = ProjectMembersBao.Delete(id);
                if (status)
                {
                    WorkTaskMembersBao.UpdateExistingWorkTaskMembers(member, userId);
                    return Json(true);
                }
            }
            return Json(false);

        }

        [Route("/Json/DashBoardFilter")]
        [HttpGet]
        public JsonResult DashBoardFilter(string startDate, string endDate, string userId)
        {
            if (startDate != null && endDate != null && userId != null)
            {
                var user = ProjectMembersBao.GetByUserIdList(User.GetUserId());
                var worktask = TaskHelper.GetWorkTask(user.Select(s => s.ProjectId).ToList());
                // return worktask.Where(s => ).;
            }
            return Json(false);
        }
        [Route("/Json/DeletePlatform/{id}")]
        [HttpGet]
        public JsonResult DeletePlatform(long id)
        {
            if (id != 0)
            {
                return Json(ProjectPlatformsBao.Delete(id));
            }
            return Json(false);
        }
        [Route("/Json/PlatformCreate")]
        [HttpPost]
        public JsonResult PlatformCreate(ProjectPlatforms projectPlatform)
        {
            if (projectPlatform != null)
            {
                var userId = User.GetUserId();
                projectPlatform.SetOnCreate(userId);
                var result = ProjectPlatformsBao.Insert(projectPlatform);
                if (result > 0)
                {
                    return Json(ProjectPlatformsBao.GetById(result));
                }
            }
            return Json(null);
        }
        [Route("/Json/DeleteNotes/{id}")]
        [HttpGet]
        public JsonResult DeleteNotes(long id)
        {
            if (id != 0)
            {
                return Json(ProjectNotesBao.Delete(id));
            }
            return Json(false);
        }
        [Route("/Json/CreateNotes")]
        [HttpPost]
        public JsonResult CreateNotes(ProjectNotes projectNotes)
        {
            if (projectNotes != null)
            {
                var userId = User.GetUserId();
                projectNotes.SetOnCreate(userId);
                var result = ProjectNotesBao.Insert(projectNotes);
                if (result > 0)
                {
                    return Json(ProjectNotesBao.GetById(result));
                }
            }
            return Json(null);
        }
        [Route("/Json/AllLabels")]
        [HttpGet]
        public JsonResult AllLabels()
        {
            return Json(LabelTypeBao.GetAll() ?? null);
        }
        [Route("/Json/AllUsers/{memberType}")]
        [HttpGet]
        public JsonResult AllUsers(string memberType)
        {
            return Json(RoleManagerBao.GetUsersByRoleName(memberType) ?? null);
        }
        [Route("/Json/DeleteAlertMessages/{id}")]
        [HttpGet]
        public JsonResult DeleteAlertMessages(long id)
        {
            if (id != 0)
            {
                return Json(ProjectAlertMessageBao.Delete(id));
            }
            return Json(false);
        }
        [Route("/Json/CreateAlertMessages")]
        [HttpPost]
        public JsonResult CreateAlertMessages(ProjectAlertMessage projectAlertMessage)
        {
            if (projectAlertMessage != null)
            {
                var userId = User.GetUserId();
                projectAlertMessage.SetOnCreate(userId);
                projectAlertMessage.AlertTypeId = AlertType.NotDone.ToInt();
                var result = ProjectAlertMessageBao.Insert(projectAlertMessage);
                if (result > 0)
                {
                    return Json(ProjectAlertMessageBao.GetById(result));
                }
            }
            return Json(null);
        }

        [Route("/Json/CreateMember")]
        [HttpPost]
        public JsonResult CreateMember(ProjectMembers projectMembers)
        {
            if (projectMembers != null)
            {
                var data = ProjectMemberTypeBao.GetByName(projectMembers.MemberType);
                projectMembers.ProjectMemberTypeId = data.Id;
                var userId = User.GetUserId();
                projectMembers.SetOnCreate(userId);
                var result = ProjectMembersBao.Insert(projectMembers);
                if (result > 0)
                {
                    bool status = WorkTaskMembersBao.UpdateExistingWorkTaskMembers(projectMembers, userId);
                    WorkTaskBao.GenerateTasks(userId, DataConstants.LocalNow);
                    WorkTaskBao.GenerateTasks(userId, DataConstants.LocalNow.AddDays(1));
                    return Json(ProjectMembersBao.GetById(result));
                }
            }
            return Json(null);
        }
        [Route("/Json/UpdateAlertStatus")]
        [HttpPost]
        public JsonResult UpdateAlertStatus(long id,int status)
        {
            var alert = ProjectAlertMessageBao.GetById(id);
            if (alert != null)
            {
                var userId = User.GetUserId();
                alert.AlertTypeId = status;
                alert.SetOnUpdate(userId);
                ProjectAlertMessageBao.Update(alert);
                return Json(alert);
            }
            return Json(false);
        }
    }
}