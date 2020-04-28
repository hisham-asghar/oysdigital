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
    public class ProjectAlertMessageController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectAlertMessageBao.GetAll());
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            Dictionary<string, int> noteTypeList = new Dictionary<string, int>();
            noteTypeList.Add("Admin", 0);
            noteTypeList.Add("Manager", 1);
            noteTypeList.Add("Member", 2);
            if (Id != 0)
            {
                var data = ProjectAlertMessageBao.GetById(Id);
                if (data != null)
                {
                    ViewData["NoteTypeId"] = new SelectList(noteTypeList, "Value", "Key", data.ProjectAlertMessageId);
                    return View(data);
                }

            }
            else
            {
                ProjectAlertMessage m = new ProjectAlertMessage();
                m.Message = ""; m.ProjectAlertMessageId = 0; m.IsActive = false;
                ViewData["NoteTypeId"] = new SelectList(noteTypeList, "NoteTypeId", "Name");
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(ProjectAlertMessage projectAlertMessage)
        {
            try
            {

                if (projectAlertMessage.ProjectAlertMessageId == 0)
                {
                    projectAlertMessage.OnCreated = DateTime.Now;
                    ProjectAlertMessageBao.Insert(projectAlertMessage);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectAlertMessage.OnModified = DateTime.Now;
                    ProjectAlertMessageBao.Update(projectAlertMessage);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(projectAlertMessage);
        }

        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectAlertMessageBao.GetById(id));
            }
            return View();
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
            if (id != 0)
            {
                return View(ProjectAlertMessageBao.GetById(id));
            }
            return View();
        }
    }
}