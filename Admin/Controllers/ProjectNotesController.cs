using System;
using System.Collections.Generic;
using System.Linq;
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
            Dictionary<string, int> noteTypeList = new Dictionary<string, int>();
            noteTypeList.Add("Admin",0);
            noteTypeList.Add("Manager",1);
            noteTypeList.Add("Member",2);
            if (Id != 0)
            {
                var data = ProjectNotesBao.GetById(Id);
                if (data != null)
                {
                    ViewData["NoteTypeId"] = new SelectList(noteTypeList, "Value", "Key", data.NoteTypeId);
                    return View(data);
                }

            }
            else
            {
                ProjectNotes m = new ProjectNotes();
                m.Message = ""; m.ProjectNotesId = 0; m.IsActive = false;
                ViewData["NoteTypeId"] = new SelectList(noteTypeList, "NoteTypeId", "Name");
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(ProjectNotes projectNotes)
        {
            try
            {

                if (projectNotes.ProjectNotesId == 0)
                {
                    projectNotes.OnCreated = DateTime.Now;
                    ProjectNotesBao.Insert(projectNotes);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectNotes.OnModified = DateTime.Now;
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