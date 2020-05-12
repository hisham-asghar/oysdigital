using System;
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
            var user=ProjectMembersBao.GetByUserIdList(User.GetUserId());
            var projecttasks = new List<ProjectTask>();
            foreach(var item in user)
            {
                var tasks = new List<ProjectTask>();
                tasks=ProjectTaskBao.GetByProjectId(item.ProjectId);
                projecttasks.AddRange(tasks);
            }
            var work=new List<WorkTask>();
            if (projecttasks != null)
            {
                foreach(var item in projecttasks)
                {
                   var datalist=WorkTaskBao.GetByProjectId(item.ProjectId);
                    if (datalist != null)
                    {
                        work.AddRange(datalist);
                    }
                }
            }
            ViewBag.GenerateTask = (work.Count > 0) ? true : false;
            var usermember = ProjectMembersBao.GetByUserId(User.GetUserId());
            var worktask = new List<WorkTask>();
            foreach (var item in user)
            { 
                var list=new List<WorkTask>();
                if (user != null)
                {
                    list=WorkTaskBao.GetByProjectId(item.ProjectId);
                    worktask.AddRange(list);
                    ViewBag.Member = user;
                }
            }
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
