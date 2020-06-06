﻿using Admin.Models;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.DataModels.Enums;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
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

            var statsModel = TaskHelper.GetUserStats(myId);

            var workTask = TaskHelper.GetWorkTask(myId, time, status);

            var counts = WorkTaskBao.GetGenerateTasksCount(myId);

            var today = DateTime.UtcNow.AddHours(5);
            ViewBag.GenerateTomorrow = ViewBag.GenerateToday = false;
            foreach(var c in counts)
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
