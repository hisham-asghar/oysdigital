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
    public class ProjectController : Controller
    {
        public IActionResult Index()
        {
            var projects = ProjectBao.GetAll();
            return View(projects);
        }
        [Route("/Project/Create")]
        [Route("/Project/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            Project project = id <= 0 ? new Project() : ProjectBao.GetById(id);
            if (id > 0 && project == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            ViewBag.IsSave = id > 0;
            return View(project);
        }
        [Route("/Project/Create")]
        [Route("/Project/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(Project project, int id = 0)
        {
            Project projectDb = ProjectBao.GetById(id);
            if (id > 0 && projectDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (project == null)
            {
                projectDb = projectDb ?? new Project();
                ViewBag.IsEdit = id > 0;
                return View(projectDb);
            }
            if (id == 0)
            {
                project.SetOnCreate(userId);
                project.Guid = Guid.NewGuid().ToString();
                if (ProjectBao.Insert(project))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.IsSave = false;
                    return View(project);
                }
            }
            else
            {
                project.SetOnUpdate(userId);
                ProjectBao.Update(project);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            //if (id != 0)
            //{
            //    CustomerDetailView detail = new CustomerDetailView();
            //    var data = ProjectBao.GetById(id);
            //    detail.project = data;
            //    if (data != null)
            //    {
            //        //var pro = ProjectBao.GetByCustomerId(data.Id);
            //        //if (pro != null)
            //        //{
            //        //    foreach (var item in pro)
            //        //    {
            //        //        item.ProjectPlatforms = ProjectPlatformsBao.GetByProjectId(item.ProjectId);
            //        //        item.ProjectMembers = ProjectMembersBao.GetByProjectId(item.ProjectId);
            //        //    }
            //        //}
            //        //detail.Projects = pro;
            //    }
            //    return View(detail);
            //}
            return View();
        }
    }
}