using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.DataModels.Enums;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
   // [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class UserRolesController : Controller
    {
        public IActionResult Index(ProjectFilter status=ProjectFilter.All)
        {
            ViewBag.Status = status;
            var user = new List<AspNetUserRoles>();
            var data = AspNetUserRolesBao.GetAll() ?? new List<AspNetUserRoles>();
            foreach (var item in data)
            {
                if (status == ProjectFilter.HaveDesigner)
                {
                    if (item.RoleName == UserRoles.Designer)
                    {
                        user.Add(item);
                    }
                }
                if (status == ProjectFilter.HaveScheduler)
                {
                    if (item.RoleName == UserRoles.Designer)
                    {
                        user.Add(item);
                    }
                }
                if (status == ProjectFilter.All)
                {
                    user = data;
                }
            }
            return View(user);
        }

        [Route("/UserRoles/Create")]
        [Route("/UserRoles/Edit/{id}")]
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
        [Route("/UserRoles/Create")]
        [Route("/UserRoles/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(AspNetUserRoles aspNetUserRoles, string id = null)
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
                if (AspNetUserRolesBao.GetByUserId(aspNetUserRoles.UserId) == null)
                {
                    AspNetUserRolesBao.Insert(aspNetUserRoles);
                }
            }
            else
            {
                if (aspNetUserRolesDb.RoleName == "")
                {
                    AspNetUserRolesBao.Insert(aspNetUserRoles);
                }
                else
                {
                    // aspNetUserRoles.NormalizedName = aspNetUserRoles.Name.ToUpper();
                    if (aspNetUserRolesDb.RoleName != aspNetUserRoles.RoleName)
                    {
                        AspNetUserRolesBao.Update(aspNetUserRoles);
                    }
                }
            }

            return RedirectToAction("Index");

        }
        [Route("/UserRoles/Delete/{id}")]
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
                AspNetUserBao.Delete(id);
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