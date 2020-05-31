using Admin.Models;
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
            var roles = AspNetUserRolesBao.GetByUserId(myId);

            if (!User.HaveAnyRole()) return View("RoleRequestView");

            var statsModel = TaskHelper.GetUserStats(myId);

            var user = ProjectMembersBao.GetByUserIdList(User.GetUserId());
            var userProjectIds = user.Select(s => s.ProjectId).ToList();
            if (User.IsInRole(UserRoles.Admin) || User.IsInRole(UserRoles.Hr))
            {
                userProjectIds = ProjectBao.GetAll().Select(p => p.Id).ToList();
            }
            var workTask = TaskHelper.GetWorkTask(userProjectIds, myId, time, status);


            var projectTask = TaskHelper.GetProjectTask(userProjectIds);
            ViewBag.GenerateToday = !TaskHelper.WorkTaskStatus(projectTask, DateTime.Now.Date);
            ViewBag.GenerateTomorrow = !TaskHelper.WorkTaskStatus(projectTask, DateTime.Now.AddDays(1).Date);

            var tuple = new Tuple<List<WorkTask>, StatsModel>(workTask, statsModel);
            ViewBag.Member = user ?? null;

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
