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
    public class ProjectNotesController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectNotesBao.GetAll());
        }
        [Route("/ProjectNotes/Create")]
        [Route("/ProjectNotes/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            ProjectNotes projectnotes = id <= 0 ? new ProjectNotes() : ProjectNotesBao.GetById(id);
            if (id > 0 && projectnotes == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            return View(projectnotes);
        }
        [Route("/ProjectNotes/Create")]
        [Route("/ProjectNotes/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectNotes projectnotes, int id = 0)
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
                if (ProjectNotesBao.Insert(projectnotes))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    return View(projectnotes);
                }
            }
            else
            {
                projectnotes.SetOnUpdate(userId);
                ProjectNotesBao.Update(projectnotes);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectNotesBao.GetById(id));
            }
            return View();
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
            if (id != 0)
            {
                return View(ProjectNotesBao.GetById(id));
            }
            return View();
        }
    }
}