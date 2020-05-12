using System;
using System.Collections.Generic;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

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
            ViewBag.MobileSpaceDictionary = MobileSpacesBao.GetAll().CreateDictionaryFromModelList();
            ViewBag.IsEdit = id > 0;
            return View(project);
        }
        [Route("/Project/Create")]
        [Route("/Project/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(Project project, int id = 0, long customerId = 0, string returnUrl = null)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
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
                project.IsActive = IsActive;
                project.Guid = Guid.NewGuid().ToString();
                ProjectBao.Insert(project);
            }
            else
            {
                project.SetOnUpdate(userId);
                project.IsActive = IsActive;
                ProjectBao.Update(project);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
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
            Project project = ProjectBao.GetById(id);
            
            if (id > 0 && project == null)
            {
                // Dont Exist
            }
            else
            {
            //   ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModelList(PlatformBao.GetAll());
              //  ViewBag.ProjectDictionary = Functions.CreateDictionaryFromModel(project);
            }
            return View(project);
        }
    }
}