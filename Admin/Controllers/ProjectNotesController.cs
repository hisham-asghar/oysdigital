using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
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
        [HttpGet]
        public IActionResult Create(long Id)
        {
             if (Id != 0)
            {
                var data = ProjectNotesBao.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                ProjectNotes m = new ProjectNotes();
                m.Message = ""; m.ProjectNotesId = 0; m.IsActive = false;
               return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(ProjectNotes projectNotes)
        {
            try
            {
                var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (projectNotes.ProjectNotesId == 0)
                {
                    projectNotes.OnCreated = DateTime.Now;
                    projectNotes.CreatedBy = userId;
                    ProjectNotesBao.Insert(projectNotes);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectNotes.OnModified = DateTime.Now;
                    projectNotes.ModifiedBy = userId;
                    ProjectNotesBao.Update(projectNotes);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(projectNotes);
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