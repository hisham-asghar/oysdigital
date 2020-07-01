using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class ProjectMemberTypeController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectMemberTypeBao.GetAll());
        }
        [Route("/ProjectMemberTypes/Create")]
        [Route("/ProjectMemberTypes/Edit/{id}")]
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
        [Route("/ProjectMemberTypes/Create")]
        [Route("/ProjectMemberTypes/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectMemberTypes projectmembertypes, int id = 0)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
            projectmembertypes.IsActive = IsActive;
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
                projectmembertypes.OnCreated = projectmembertypeDb.OnCreated;
                projectmembertypes.CreatedBy = projectmembertypeDb.CreatedBy;
                projectmembertypes.SetOnUpdate(userId);
                ProjectMemberTypeBao.Update(projectmembertypes);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            ProjectMemberTypes projectmembertype = ProjectMemberTypeBao.GetById(id);
            if (id > 0 && projectmembertype == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectMemberTypeDictionary = Functions.CreateDictionaryFromModel(projectmembertype);
            }
            return View(projectmembertype);
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
            ProjectMemberTypes projectmembertype = ProjectMemberTypeBao.GetById(id);
            if (id > 0 && projectmembertype == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectMemberTypeDictionary = Functions.CreateDictionaryFromModel(projectmembertype);
            }
            return View(projectmembertype);
        }
    }
}