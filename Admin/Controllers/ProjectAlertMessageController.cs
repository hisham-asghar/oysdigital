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
    public class ProjectAlertMessageController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectAlertMessageBao.GetAll());
        }
        [Route("/ProjectAlertMessage/Create")]
        [Route("/ProjectAlertMessage/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0,long projectId=0,string returnUrl=null)
        {
            ProjectAlertMessage projectalertmessage = id <= 0 ? new ProjectAlertMessage() : ProjectAlertMessageBao.GetById(id);
            if (id > 0 && projectalertmessage == null)
            {
                // Dont Exist
            }
            else
            {
                var project = ProjectBao.GetById(projectId);
                if (project == null)
                    ViewBag.ProjectDictionary = ProjectBao.GetAll().CreateDictionaryFromModelList();
                else
                {
                    var dictionary = new Dictionary<int, string>();
                    dictionary.Add((int)project.Id, project.Name);
                    ViewBag.ProjectDictionary = dictionary;
                }
                ViewBag.LabelTypeDictionary = LabelTypeBao.GetAll().CreateDictionaryFromModelList();
            }
            ViewBag.IsEdit = id > 0;
            return View(projectalertmessage);
        }
        [Route("/ProjectAlertMessage/Create")]
        [Route("/ProjectAlertMessage/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectAlertMessage projectalertmessage, int id = 0, long projectId = 0, string returnUrl = null)
        {
            ProjectAlertMessage projectalertmessageDb = ProjectAlertMessageBao.GetById(id);
            if (id > 0 && projectalertmessageDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectalertmessage == null)
            {
                projectalertmessageDb = projectalertmessageDb ?? new ProjectAlertMessage();
                ViewBag.IsEdit = id > 0;
                return View(projectalertmessageDb);
            }
            if (id == 0)
            {
                projectalertmessage.SetOnCreate(userId);
                ProjectAlertMessageBao.Insert(projectalertmessage);
            }
            else
            {
                projectalertmessage.SetOnUpdate(userId);
                ProjectAlertMessageBao.Update(projectalertmessage);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        public IActionResult Delete(long id)
        {
            ProjectAlertMessage projectalertmessage = ProjectAlertMessageBao.GetById(id);
            if (id > 0 && projectalertmessage == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectAlertMessageDictionary = Functions.CreateDictionaryFromModel(projectalertmessage);
            }
            return View(projectalertmessage);
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectAlertMessageBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            ProjectAlertMessage projectalertmessage = ProjectAlertMessageBao.GetById(id);
            if (id > 0 && projectalertmessage == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectAlertMessageDictionary = Functions.CreateDictionaryFromModel(projectalertmessage);
            }
            return View(projectalertmessage);
        }
    }
}