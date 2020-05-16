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
    public class LabelTypeController : Controller
    {
        public IActionResult Index()
        {
            return View(LabelTypeBao.GetAll());
        }
        [Route("/LabelType/Create")]
        [Route("/LabelType/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0, long projectId = 0, string returnUrl = null)
        {
            LabelType labeltype = id <= 0 ? new LabelType() : LabelTypeBao.GetById(id);
            if (id > 0 && labeltype == null)
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
            }
            ViewBag.IsEdit = id > 0;
            return View(labeltype);
        }
        [Route("/LabelType/Create")]
        [Route("/LabelType/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(LabelType labeltype, int id = 0, long projectId = 0, string returnUrl = null)
        {
            LabelType labeltypeDb = LabelTypeBao.GetById(id);
            if (id > 0 && labeltypeDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (labeltype == null)
            {
                labeltypeDb = labeltypeDb ?? new LabelType();
                ViewBag.IsEdit = id > 0;
                return View(labeltypeDb);
            }
            if (id == 0)
            {
                labeltype.SetOnCreate(userId);
                LabelTypeBao.Insert(labeltype);
            }
            else
            {
                labeltype.SetOnUpdate(userId);
                LabelTypeBao.Update(labeltype);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        public IActionResult Delete(long id)
        {
            LabelType labeltype = LabelTypeBao.GetById(id);
            if (id > 0 && labeltype == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.LabelTypeDictionary = Functions.CreateDictionaryFromModel(labeltype);
            }
            return View(labeltype);
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                LabelTypeBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            LabelType labeltype = LabelTypeBao.GetById(id);
            if (id > 0 && labeltype == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.LabelTypeDictionary = Functions.CreateDictionaryFromModel(labeltype);
            }
            return View(labeltype);
        }
    }
}