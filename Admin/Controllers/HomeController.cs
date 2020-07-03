using Admin.Models;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.DataModels.Enums;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace Admin.Controllers
{
    [Authorize]
    public class HomeController : BaseController
    {
        public HomeController(ILogger<HomeController> logger) : base(logger)
        {
        }

        public IActionResult Index(TaskTimeFilter time = TaskTimeFilter.Today, TaskStatusFilter status = TaskStatusFilter.Pending)
        {
            ViewBag.TimeFilter = time;
            ViewBag.StatusFilter = status;

            var myId = User.GetUserId();
            //var roles = AspNetUserRolesBao.GetByUserId(myId);

            if (!User.HaveAnyRole()) return View("RoleRequestView");
            var statsModel = new StatsModel();
            statsModel = TaskHelper.GetUserStats(myId);
            var workTask = TaskHelper.GetWorkTask(myId, time, status);
            var projectAlerts = ProjectAlertMessageBao.GetAll()?? new List<ProjectAlertMessage>();
            var li = new List<long>();
            foreach(var item in workTask)
            {
                if (!li.Contains(item.ProjectId))
                {
                    foreach(var alert in projectAlerts.Where(s=>s.ProjectId==item.ProjectId).ToList())
                    {
                        if (alert.AlertTypeId == 2) {
                            item.AlertCount += 1;
                        }
                    }
                    
                    li.Add(item.ProjectId);
                }
            }
            var counts = WorkTaskBao.GetGenerateTasksCount(myId);

            var today = DataConstants.LocalNow;
            ViewBag.GenerateTomorrow = ViewBag.GenerateToday = false;
            foreach (var c in counts)
            {
                var todayStr = today.ToString("MM-dd-yyyy");
                var tomStr = today.AddDays(1).ToString("MM-dd-yyyy");
                if (c.Date == todayStr)
                    ViewBag.GenerateToday = c.TaskCount > 0;
                if (c.Date == tomStr)
                    ViewBag.GenerateTomorrow = c.TaskCount > 0;
            }

            var tuple = new Tuple<List<WorkTask>, StatsModel>(workTask, statsModel);

            if (User.IsDesigner())
                return View("DesignerView", tuple);

            if (User.IsScheduler())
                return View("SchedulerView", tuple);

            else if (User.IsAdminOrHr())
                return View("AdminView", tuple);

            return View("RoleRequestView");
        }
        [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
        [Route("UserStats")]
        public IActionResult UserStats(TaskTimeFilter time = TaskTimeFilter.Today, ProjectFilter status = ProjectFilter.Active)
        {
            ViewBag.TimeFilter = time;
            ViewBag.Status = status;
            var Users = AspNetUserRolesBao.GetAll();
            var stats = TaskHelper.GetUserStats(Users.Select(s => s.Id).ToList());
            var Userlist = new List<StatsView>();
            foreach (var item in stats)
            {
                var list = new StatsView();
                var u = Users.SingleOrDefault(s => s.Id == item.Key && s.RoleName != UserRoles.Admin && s.RoleName != UserRoles.Hr);
                if (u != null)
                {
                    list.User = u;
                    list.Stats = item.Value;
                    Userlist.Add(list);
                }
            }

            var statuslist = new List<StatsView>();
            foreach (var c in Userlist)
            {
                if (status == ProjectFilter.Active)
                {
                    if (c.User.LockoutEnabled == true)
                    {
                        statuslist.Add(c);
                    }
                }
                if (status == ProjectFilter.InActive)
                {
                    if (c.User.LockoutEnabled == false)
                    {
                        statuslist.Add(c);
                    }
                }
                if (status == ProjectFilter.HaveDesigner)
                {
                    if (c.User.RoleName == UserRoles.Designer)
                    {
                        statuslist.Add(c);
                    }
                }
                if (status == ProjectFilter.HaveScheduler)
                {
                    if (c.User.RoleName == UserRoles.Scheduler)
                    {
                        statuslist.Add(c);
                    }
                }
                if (status == ProjectFilter.All)
                {
                    statuslist = Userlist;
                }
            }
            

            return View(statuslist);
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
