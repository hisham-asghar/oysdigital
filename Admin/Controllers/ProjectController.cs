using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class ProjectController : Controller
    {
        [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr + "," + UserRoles.Designer + "," + UserRoles.Scheduler)]

        public IActionResult Index()
        {
            var projects = new List<Project>();
            if (User.IsInRole(UserRoles.Designer) || User.IsInRole(UserRoles.Scheduler))
            {
                var usermember = ProjectMembersBao.GetByUserId(User.GetUserId());
                if (usermember != null)
                {
                    var data = ProjectBao.GetByMemberTypeId(usermember.ProjectMemberTypeId) ?? new List<Project>();
                    return View(data);
                }
            }
            if (User.IsInRole(UserRoles.Admin) || User.IsInRole(UserRoles.Hr))
            {
                projects = ProjectBao.GetAll();
            }
            else
            {
                return View(projects);
            }
            return View(projects);
        }
        [Route("/Project/Create")]
        [Route("/Project/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0, long customerId = 0, string returnUrl = null)
        {
            Project project = id <= 0 ? new Project() : ProjectBao.GetById(id);
            if (id > 0 && project == null)
            {
                // Dont Exist
            }
            else
            {
                var customer = CustomerBao.GetById(customerId);
                if (customer == null)
                {
                    ViewBag.CustomerDictionary = CustomerBao.GetAll().CreateDictionaryFromModelList();
                }
                else
                {
                    var dictionary = new Dictionary<int, string>();
                    dictionary.Add((int)customer.Id, customer.Name);
                    ViewBag.CustomerDictionary = dictionary;
                }

            }
            ViewBag.MobileSpaceDictionary = MobileSpacesBao.GetAll().CreateDictionaryFromModelList("Id", "DetailedName");
            ViewBag.IsEdit = id > 0;
            return View(project);
        }
        [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
        [Route("/Project/Create")]
        [Route("/Project/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(Project project, int id = 0, long customerId = 0, string returnUrl = null)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
            project.IsActive = IsActive;
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
                ProjectBao.Insert(project);
            }
            else
            {
                project.SetOnUpdate(userId);
                ProjectBao.Update(project);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
        public IActionResult Delete(long id)
        {
            Project project = ProjectBao.GetById(id);
            if (id > 0 && project == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectDictionary = Functions.CreateDictionaryFromModel(project);
            }
            return View(project);
        }
        [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
        public IActionResult Detail(long id)
        {
            if (id > 0)
            {
                Project project = ProjectBao.GetById(id);

                if (id > 0 && project == null)
                {
                    return RedirectToAction("Error", "Home");
                }
                else
                {
                    //   ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModelList(PlatformBao.GetAll());
                    //  ViewBag.ProjectDictionary = Functions.CreateDictionaryFromModel(project);
                }
                project.ProjectNotes = (project.ProjectNotes ?? new List<ProjectNotes>()).OrderByDescending(u => u.OnCreated).ToList();
                project.ProjectAlertMessages = (project.ProjectAlertMessages ?? new List<ProjectAlertMessage>()).OrderByDescending(u => u.OnCreated).ToList();
                return View(project);
            }
            else
            {
                return View(new Project());
            }
        }
    }
}