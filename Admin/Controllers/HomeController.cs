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
            var user=ProjectMembersBao.GetByUserId(User.GetUserId());
            var worktask=new List<WorkTask>();
            if (user != null)
            {
                 worktask = WorkTaskBao.GetByProjectId(user.ProjectId);
                ViewBag.Member = user;
            }

            return View(worktask);
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
