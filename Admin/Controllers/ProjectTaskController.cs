using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class ProjectTaskController : Controller
    {
        public IActionResult Index()
        {
            var projects = ProjectTaskBao.GetAll();
            return View(projects);
        }
        [Route("/ProjectTask/Create")]
        [Route("/ProjectTask/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0, long projectId = 0, string returnUrl = null)
        {
            ProjectTask projecttask = id <= 0 ? new ProjectTask() : ProjectTaskBao.GetById(id);
            if (id > 0 && projecttask == null)
            {
                // Dont Exist
            }
            else
            {
                var project = ProjectBao.GetById(projectId);
                if (project == null)
                {
                    ViewBag.CustomerDictionary = ProjectBao.GetAll().CreateDictionaryFromModelList();
                }
                else
                {
                    var dictionary = new Dictionary<int, string>();
                    dictionary.Add((int)project.Id, project.Name);
                    ViewBag.CustomerDictionary = dictionary;
                }

            }
            ViewBag.MobileSpaceDictionary = MobileSpacesBao.GetAll().CreateDictionaryFromModelList();
            ViewBag.IsEdit = id > 0;
            return View(projecttask);
        }
        [Route("/ProjectTask/Create")]
        [Route("/ProjectTask/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectView projectView, int id = 0, long projectId = 0, string returnUrl = null)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
           // projectplatforms.IsActive = IsActive;
            ProjectTask projecttaskDb = ProjectTaskBao.GetById(id);
            if (id > 0 && projecttaskDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectView == null)
            {
                projecttaskDb = projecttaskDb ?? new ProjectTask();
                ViewBag.IsEdit = id > 0;
                return View(projecttaskDb);
            }
            if (id == 0)
            {
                
            }
            else
            {
                //projecttask.SetOnUpdate(userId);
                //ProjectTaskBao.Update(projecttask);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        public IActionResult Delete(long id)
        {
            ProjectTask projecttask = ProjectTaskBao.GetById(id);
            if (id > 0 && projecttask == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectDictionary = Functions.CreateDictionaryFromModel(projecttask);
            }
            return View(projecttask);
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectTaskBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            ProjectTask projecttask = ProjectTaskBao.GetById(id);

            if (id > 0 && projecttask == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModelList(PlatformBao.GetAll());
                ViewBag.ProjectDictionary = Functions.CreateDictionaryFromModel(projecttask);
            }
            return View(projecttask);
        }
    }
}