using Generics.Common;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Admin.Controllers
{
    // [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class RolesController : Controller
    {
        private RoleManager<IdentityRole> _roleManager;

        public RolesController(RoleManager<IdentityRole> roleManager)
        {
            _roleManager = roleManager;
        }
        public IActionResult Index()
        {
            return View(AspNetRolesBao.GetAll() ?? new List<AspNetRoles>());
        }

        [Route("/Roles/Create")]
        [Route("/Roles/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(string id = null)
        {
            AspNetRoles aspNetRoles = id == null ? new AspNetRoles() : AspNetRolesBao.GetById(id);
            if (id != null && aspNetRoles == null)
            {
                return View(aspNetRoles);
            }

            ViewBag.IsEdit = (id == null) ? false : true;
            return View(aspNetRoles);
        }
        [Route("/Roles/Create")]
        [Route("/Roles/Edit/{id}")]
        [HttpPost]
        public async Task<IActionResult> CreateAsync(AspNetRoles aspNetRoles, string id = null)
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
                await _roleManager.CreateAsync(new IdentityRole(aspNetRoles.Name));
            }
            else
            {
                var role = await _roleManager.FindByIdAsync(id);
                if (role != null)
                {
                    role.Name = aspNetRoles.Name;
                    await _roleManager.UpdateAsync(role);
                }

            }

            return RedirectToAction("Index");

        }
        [Route("/Roles/Delete/{id}")]
        public IActionResult Delete(string id)
        {
            AspNetRoles aspNetRoles = AspNetRolesBao.GetById(id);
            if (id != null && aspNetRoles == null)
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
            if (id != null && aspNetRoles == null)
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