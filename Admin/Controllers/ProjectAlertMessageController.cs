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
    public class ProjectAlertMessageController : Controller
    {
        public IActionResult Index()
        {
            return View(ProjectAlertMessageBao.GetAll());
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = ProjectAlertMessageBao.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                ProjectAlertMessage m = new ProjectAlertMessage();
                m.Message = ""; m.Id = 0; m.IsActive = false;
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(ProjectAlertMessage projectAlertMessage)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try
            {

                if (projectAlertMessage.Id == 0)
                {
                    projectAlertMessage.OnCreated = DateTime.Now;
                    projectAlertMessage.CreatedBy = userId;
                    ProjectAlertMessageBao.Insert(projectAlertMessage);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectAlertMessage.OnModified = DateTime.Now;
                    projectAlertMessage.ModifiedBy = userId;
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