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
    public class ProjectNotesController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectNotesBao.GetAll());
        }
        [Route("/ProjectNotes/Create")]
        [Route("/ProjectNotes/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0, long projectId = 0, string returnUrl = null)
        {
            ProjectNotes projectnotes = id <= 0 ? new ProjectNotes() : ProjectNotesBao.GetById(id);
            if (id > 0 && projectnotes == null)
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
            return View(projectnotes);
        }
        [Route("/ProjectNotes/Create")]
        [Route("/ProjectNotes/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectNotes projectnotes, int id = 0, long projectId = 0, string returnUrl = null)
        {
            ProjectNotes projectnotesDb = ProjectNotesBao.GetById(id);
            if (id > 0 && projectnotesDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectnotes == null)
            {
                projectnotesDb = projectnotesDb ?? new ProjectNotes();
                ViewBag.IsEdit = id > 0;
                return View(projectnotesDb);
            }
            if (id == 0)
            {
                projectnotes.SetOnCreate(userId);
                ProjectNotesBao.Insert(projectnotes);
            }
            else
            {
                projectnotes.SetOnUpdate(userId);
                ProjectNotesBao.Update(projectnotes);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        public IActionResult Delete(long id)
        {
            ProjectNotes projectnotes = ProjectNotesBao.GetById(id);
            if (id > 0 && projectnotes == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectNotesDictionary = Functions.CreateDictionaryFromModel(projectnotes);
            }
            return View(projectnotes);
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectNotesBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            ProjectNotes projectnotes = ProjectNotesBao.GetById(id);
            if (id > 0 && projectnotes == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectNotesDictionary = Functions.CreateDictionaryFromModel(projectnotes);
            }
            return View(projectnotes);
        }
    }
}