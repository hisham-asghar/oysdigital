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

namespace Admin.Controllers
{
    public class JsonController : Controller
    {
        [Route("/Json/Getplatforms/{id}")]
        [HttpGet]
        public JsonResult Getplatforms(long id)
        {
            var list = PlatformBao.GetAll();
            return Json(list);
        }
        [Route("/Json/GetMobileSpaces")]
        [HttpGet]
        public JsonResult GetMobileSpaces()
        {
            var list = MobileSpacesBao.GetAll();
            return Json(list);
        }
        [Route("/Json/GenerateTask")]
        [HttpGet]
        public JsonResult GenerateTask()
        {
            var data = WorkTaskBao.CheckTaskCreated(DateTime.Now.Date);
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
                        workTask.OnCreated = DateTime.Now.Date;
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
                //JsonSerializer JsonConvert = new JsonSerializer(); 
                //string result = JsonConvert.Serialize(airport.getListItems());
                workTaskPlatforms.IsDesigned = status;
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
        [Route("/Json/MultiPlatform")]
        [HttpPost]
        public JsonResult MultiPlatform(string[] id)
        {
            if (id.Length > 0)
            {
                foreach (var item in id)
                {
                    var workTask = WorkTaskPlatformsBao.GetById(item.ToLong());
                    if (workTask != null)
                    {
                        if (workTask.IsDesigned != true) {
                            workTask.IsDesigned = true;
                            WorkTaskPlatformsBao.Update(workTask);
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
    }
}