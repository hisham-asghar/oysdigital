using System;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin+","+UserRoles.Hr)]
    public class PlatformController : Controller
    {
        [Obsolete]
        private readonly IHostingEnvironment _environment;

        [Obsolete]
        public PlatformController(IHostingEnvironment environment)
        {
            _environment = environment ?? throw new ArgumentNullException(nameof(environment));
        }
        public IActionResult Index()
        {
            return View(PlatformBao.GetAll());
        }
        [Authorize(Roles =UserRoles.Admin)]
        [Route("/Platform/Create")]
        [Route("/Platform/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            Platform platform = id <= 0 ? new Platform() : PlatformBao.GetById(id);
            if (id > 0 && platform == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            return View(platform);
        }

        [Route("/Platform/Create")]
        [Route("/Platform/Edit/{id}")]
        [HttpPost]
        [Obsolete]
        public IActionResult Create(Platform platform,int id = 0)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
            platform.IsActive = IsActive;
            Platform platformDb = PlatformBao.GetById(id);
            if (id > 0 && platformDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (platform == null)
            {
                platformDb = platformDb ?? new Platform();
                ViewBag.IsEdit = id > 0;
                return View(platformDb);
            }
            if (id == 0)
            {
                platform.SetOnCreate(userId);
                PlatformBao.Insert(platform);
                
            }
            else
            {
                platform.OnCreated = platformDb.OnCreated;
                platform.CreatedBy = platformDb.CreatedBy;
                platform.SetOnUpdate(userId);
                PlatformBao.Update(platform);
            }

            return RedirectToAction("Index");

        }
                
        public IActionResult Delete(long id)
        {
            Platform platform = PlatformBao.GetById(id);
            if (id > 0 && platform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModel(platform);
            }
            return View(platform);
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                PlatformBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            Platform platform = PlatformBao.GetById(id);
            if (id > 0 && platform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModel(platform);
            }
            return View(platform);
        }
    }
}