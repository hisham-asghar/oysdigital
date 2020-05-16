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
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class AspNetRolesController : Controller
    {
        public IActionResult Index()
        {
            return View(AspNetRolesBao.GetAll()??new List<AspNetRoles>());
        }

        [Route("/AspNetRoles/Create")]
        [Route("/AspNetRoles/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(string id = null)
        {
            AspNetRoles aspNetRoles = id == null ? new AspNetRoles() : AspNetRolesBao.GetById(id);
            if (id != null && aspNetRoles == null)
            {
                return View(aspNetRoles);
            }

            ViewBag.IsEdit = (id == null) ? false:true ;
            return View(aspNetRoles);
        }
        [Route("/AspNetRoles/Create")]
        [Route("/AspNetRoles/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(AspNetRoles aspNetRoles, string id = null)
        {
            AspNetRoles aspNetRolesDb = AspNetRolesBao.GetById(id);
            if (id != null && aspNetRolesDb == null)
            {
                // Not Exists
            }

            if (aspNetRoles == null)
            {
                aspNetRolesDb = aspNetRolesDb ?? new AspNetRoles();
                ViewBag.IsEdit = id != null;
                return View(aspNetRolesDb);
            }

            if (id == null)
            {
                aspNetRoles.NormalizedName = aspNetRoles.Name.ToUpper();
                AspNetRolesBao.Insert(aspNetRoles);
            }
            else
            {
                aspNetRoles.NormalizedName = aspNetRoles.Name.ToUpper();
                AspNetRolesBao.Update(aspNetRoles);
            }

            return RedirectToAction("Index");

        }
        [Route("/AspNetRoles/Delete/{id}")]
        public IActionResult Delete(string id)
        {
            AspNetRoles aspNetRoles = AspNetRolesBao.GetById(id);
            if (id !=null && aspNetRoles == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.AspNetRolesDictionary = Functions.CreateDictionaryFromModel(aspNetRoles);
            }
            return View(aspNetRoles);
        }

        public IActionResult ConfirmDelete(string id)
        {
            if (id != null)
            {
                AspNetRolesBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(string id)
        {
            AspNetRoles aspNetRoles = AspNetRolesBao.GetById(id);
            if (id !=null  && aspNetRoles == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.AspNetRolesDictionary = Functions.CreateDictionaryFromModel(aspNetRoles);
            }
            return View(aspNetRoles);
        }
    }
}