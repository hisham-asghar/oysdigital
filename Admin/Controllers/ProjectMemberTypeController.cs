using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Admin.Controllers
{
    public class ProjectMemberTypeController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectMemberTypeBao.GetAll());
        }
        [Route("/ProjectMemberType/Create")]
        [Route("/ProjectMemberType/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            ProjectMemberTypes projectmembertypes = id <= 0 ? new ProjectMemberTypes() : ProjectMemberTypeBao.GetById(id);
            if (id > 0 && projectmembertypes == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            return View(projectmembertypes);
        }
        [Route("/ProjectMemberType/Create")]
        [Route("/ProjectMemberType/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectMemberTypes projectmembertypes, int id = 0)
        {
            ProjectMemberTypes projectmembertypeDb = ProjectMemberTypeBao.GetById(id);
            if (id > 0 && projectmembertypeDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectmembertypes == null)
            {
                projectmembertypeDb = projectmembertypeDb ?? new ProjectMemberTypes();
                ViewBag.IsEdit = id > 0;
                return View(projectmembertypeDb);
            }
            if (id == 0)
            {
                projectmembertypes.SetOnCreate(userId);
                if (ProjectMemberTypeBao.Insert(projectmembertypes))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    return View(projectmembertypes);
                }
            }
            else
            {
                projectmembertypes.SetOnUpdate(userId);
                ProjectMemberTypeBao.Update(projectmembertypes);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectMemberTypeBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectMemberTypeBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(ProjectMemberTypeBao.GetById(id));
            }
            return View();
        }
    }
}