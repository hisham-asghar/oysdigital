using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class ProjectMemberTypeController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectMemberTypeBao.GetAll());
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = ProjectMemberTypeBao.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                ProjectMemberTypes m = new ProjectMemberTypes();
                m.ProjectMemberTypeName = ""; m.ProjectMemberTypesId = 0; m.IsActive = false;
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(ProjectMemberTypes projectMemberType)
        {
            try
            {
                var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

                if (projectMemberType.ProjectMemberTypesId == 0)
                {
                    projectMemberType.OnCreated = DateTime.Now;
                    projectMemberType.CreatedBy = userId;
                    ProjectMemberTypeBao.Insert(projectMemberType);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectMemberType.OnModified = DateTime.Now;
                    projectMemberType.ModifiedBy = userId;
                    ProjectMemberTypeBao.Update(projectMemberType);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(projectMemberType);
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