﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Admin.Models;
using Microsoft.AspNetCore.Authorization;
using LayerBao;
using Generics.WebHelper.Extensions;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;

namespace Admin.Controllers
{
    [Authorize]
    public class HomeController : BaseController
    {

        public HomeController(ILogger<HomeController> logger) : base(logger)
        {
        }

        public IActionResult Index()
        {
            var roles = AspNetUserRolesBao.GetByUserId(User.GetUserId());
            if (roles == null)
            {
                return View("RoleRequestView");
            }
            var usermember = ProjectMembersBao.GetByUserId(User.GetUserId());
            var data = new List<WorkTaskMembers>();
            if (usermember != null)
            {
                data = TaskHelper.GetTaskCount(usermember.AspNetUserId, usermember.ProjectMemberTypeId);
            }
            ViewBag.OverAll = data.Count();
           // ViewBag.Pending = data.Select(s =>  == DateTime.Now.DayOfWeek).Count();
            ViewBag.Week = data.Select(s => s.OnCreated.DayOfWeek == DateTime.Now.DayOfWeek).Count();
            ViewBag.Month = data.Select(s => s.OnCreated.Month == DateTime.Now.Month).Count();
            ViewBag.Today = data.Select(s => s.OnCreated.Date == DateTime.Now.Date).Count();
            var user =ProjectMembersBao.GetByUserIdList(User.GetUserId());
            var worktask= TaskHelper.GetWorkTask(user.Select(s => s.ProjectId).ToList());
            var projecttask = TaskHelper.GetProjectTask(user.Select(s => s.ProjectId).ToList());
            ViewBag.GenerateToday = !TaskHelper.WorkTaskStatus(projecttask, DateTime.Now.Date);
            ViewBag.GenerateTomorrow = !TaskHelper.WorkTaskStatus(projecttask, DateTime.Now.AddDays(1).Date);
            if (usermember != null)
            {
                ViewBag.Member = user??null;
                if (usermember.MemberType == UserRoles.Designer)
                {
                    return View("DesignerView", worktask);
                }
                if (usermember.MemberType == UserRoles.Scheduler)
                {
                    return View("SchedulerView", worktask);
                }
                else
                {
                    return View("AdminView", worktask);
                }
            }
            if(User.IsInRole(UserRoles.Admin) || User.IsInRole(UserRoles.Hr))
            {
               var count = TaskHelper.GetAllTask();
                return View("AdminView",WorkTaskBao.GetAll()??new List<WorkTask>());
            }
            return View(new List<WorkTask>());
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
