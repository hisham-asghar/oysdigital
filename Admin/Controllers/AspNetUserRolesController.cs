using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class AspNetUserRolesController : Controller
    {
        public IActionResult Index()
        {
            return View(AspNetUserRolesBao.GetAll() ?? new List<AspNetUserRoles>());
        }

        [Route("/AspNetUserRoles/Create")]
        [Route("/AspNetUserRoles/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(string id = null)
        {
            AspNetUserRoles aspNetUserRoles = id == null ? new AspNetUserRoles() : AspNetUserRolesBao.GetByUserId(id);
            if (id != null && aspNetUserRoles == null)
            {
                return View(aspNetUserRoles);
            }
            var dictionary = new Dictionary<string , string>();
            foreach(var item in RoleManagerBao.GetAll())
            {
                dictionary.Add(item.Id, item.Name);
            }
            ViewBag.AspNetUsers = dictionary;
            var dictionary1 = new Dictionary<string, string>();
            foreach (var item in AspNetRolesBao.GetAll())
            {
                dictionary1.Add(item.Id, item.Name);
            }
            ViewBag.AspNetRoles = dictionary1;
            ViewBag.IsEdit = (id == null) ? false : true;
            return View(aspNetUserRoles);
        }
        [Route("/AspNetUserRoles/Create")]
        [Route("/AspNetUserRoles/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(AspNetUserRoles aspNetUserRoles,List<string> Roles, string id = null)
        {
            AspNetUserRoles aspNetUserRolesDb = AspNetUserRolesBao.GetByUserId(id);
            if (id != null && aspNetUserRolesDb == null)
            {
                // Not Exists
            }

            if (aspNetUserRoles == null)
            {
                aspNetUserRolesDb = aspNetUserRolesDb ?? new AspNetUserRoles();
                ViewBag.IsEdit = id != null;
                return View(aspNetUserRolesDb);
            }

            if (id == null)
            {
                foreach(var item in Roles)
                {
                    var role = new AspNetUserRoles();
                    role.UserId = aspNetUserRoles.UserId;
                    role.RoleId = item;
                    if(AspNetUserRolesBao.IsExist(role.UserId, role.RoleId)==null)
                    {
                        AspNetUserRolesBao.Insert(role);
                    }
                }
                
            }
            else
            {
                // aspNetUserRoles.NormalizedName = aspNetUserRoles.Name.ToUpper();
                AspNetUserRolesBao.Update(aspNetUserRoles);
            }

            return RedirectToAction("Index");

        }
        [Route("/AspNetUserRoles/Delete/{id}")]
        public IActionResult Delete(string id)
        {
            AspNetUserRoles aspNetUserRoles = AspNetUserRolesBao.GetByUserId(id);
            if (id != null && aspNetUserRoles == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.AspNetUserRolesDictionary = Functions.CreateDictionaryFromModel(aspNetUserRoles);
            }
            return View(aspNetUserRoles);
        }

        public IActionResult ConfirmDelete(string id)
        {
            if (id != null)
            {
                AspNetUserRolesBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(string id)
        {
            AspNetUserRoles aspNetUserRoles = AspNetUserRolesBao.GetByUserId(id);
            if (id != null && aspNetUserRoles == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.AspNetRolesDictionary = Functions.CreateDictionaryFromModel(aspNetUserRoles);
            }
            return View(aspNetUserRoles);
        }
    }
}