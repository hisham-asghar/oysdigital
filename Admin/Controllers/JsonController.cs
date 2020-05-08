using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class JsonController : Controller
    {
        [Route("/Json/Getplatforms")]
        [HttpGet]
        public JsonResult Getplatforms()
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


    }
}