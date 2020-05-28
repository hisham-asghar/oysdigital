using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class UserController : Controller
    {
        UserManager<ApplicationUser> _userManager;
        public UserController(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }
        public IActionResult Index()
        {
            return View(AspNetUserBao.GetAll() ?? new List<ApplicationUser>());
        }

        [Route("/User/Create")]
        [Route("/User/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(string id = null)
        {
            ApplicationUser aspNetUserRoles = id == null ? new ApplicationUser() : AspNetUserBao.GetById(id);
            if (id != null && aspNetUserRoles == null)
            {
                return View(aspNetUserRoles);
            }
            var dictionary1 = new Dictionary<string, string>();
            foreach (var item in AspNetRolesBao.GetAll())
            {
                dictionary1.Add(item.Id, item.Name);
            }
            ViewBag.AspNetRoles = dictionary1;
            ViewBag.IsEdit = (id == null) ? false : true;
            return View(aspNetUserRoles);
        }
        [Route("/User/Create")]
        [Route("/User/Edit/{id}")]
        [HttpPost]
        public async Task<IActionResult> CreateAsync(ApplicationUser applicationUser, List<string> Roles, string id = null)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
            ApplicationUser applicationUserDb = AspNetUserBao.GetById(id);
            if (id != null && applicationUserDb == null)
            {
                // Not Exists
            }
            if (applicationUser == null)
            {
                applicationUserDb = applicationUserDb ?? new ApplicationUser();
                ViewBag.IsEdit = id != null;
                return View(applicationUserDb);
            }
            if (id == null)
            {
                applicationUser.UserName = applicationUser.Email;
                var result =await _userManager.CreateAsync(applicationUser,applicationUser.PasswordHash);
                if (result.Succeeded)
                {
                    return RedirectToAction("Index");
                }
            }
            else
            {
                applicationUser.UserName = applicationUser.Email;
                var result = await _userManager.UpdateAsync(applicationUser);
                if (result.Succeeded)
                {
                    return RedirectToAction("Index");
                }
            }

            return RedirectToAction("Index");

        }
        [Route("/User/Delete/{id}")]
        public IActionResult Delete(string id)
        {
            ApplicationUser aspNetUserRoles = AspNetUserBao.GetById(id);
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

        public async Task<IActionResult> ConfirmDeleteAsync(string id)
        {
            
            if (id != null)
            {
               var user= AspNetUserBao.GetById(id);
                if (user != null)
                {
                  await  _userManager.DeleteAsync(user);
                }
            }
            return RedirectToAction("Index");
        }
        public async Task<IActionResult> DeactivateUserAsync(string id)
        {

            if (id != null)
            {
                var user = AspNetUserBao.GetById(id);
                if (user != null)
                {
                   // user.IsActive = (user.IsActive) ? false : true;
                    await _userManager.UpdateAsync(user);
                }
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(string id)
        {
            ApplicationUser aspNetUserRoles = AspNetUserBao.GetById(id);
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