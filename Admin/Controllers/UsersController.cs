using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.DataModels.Enums;
using LayerBao;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.Controllers
{
    public class UsersController : Controller
    {
        UserManager<ApplicationUser> _userManager;
        public UsersController(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }
        public IActionResult Index(ProjectFilter status = ProjectFilter.All)
        {
            ViewBag.Status = status;
           // var userWithRolesDictionary = (AspNetUserRolesBao.GetAll() ?? new List<AspNetUserRoles>()).ToDictionary(k => k.UserId, v => v.Roles);
            var data = AspNetUserRolesBao.GetAll() ?? new List<AspNetUserRoles>();
            var users = new List<AspNetUserRoles>();
            foreach (var c in data)
            {
                if (status == ProjectFilter.Active)
                {
                    if (c.LockoutEnabled == true)
                    {
                        users.Add(c);
                    }
                }
                if (status == ProjectFilter.InActive)
                {
                    if (c.LockoutEnabled == false)
                    {
                        users.Add(c);
                    }
                }
                if (status == ProjectFilter.HaveDesigner)
                {
                    if (c.RoleName == UserRoles.Designer)
                    {
                        users.Add(c);
                    }
                }
                if (status == ProjectFilter.HaveScheduler)
                {
                    if (c.RoleName == UserRoles.Designer)
                    {
                        users.Add(c);
                    }
                }
                if (status == ProjectFilter.All)
                {
                    users = data;
                }
            }
           // var userRoles = users.Select(u => new KeyValuePair<ApplicationUser, List<string>>(u, userWithRolesDictionary.Get(u.Id))).ToList();
            return View(users);
        }

        [Route("/Users/Create")]
        [Route("/Users/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(string id = null)
        {
            var user = id != null ? AspNetUserBao.GetById(id) : new ApplicationUser();
            ViewBag.IsEdit = id != null;

            if (id != null && user == null)
            {
                return RedirectToAction("Error", "Home");
            }

            ViewBag.AspNetRoles = (AspNetRolesBao.GetAll() ?? new List<AspNetRoles>()).ToDictionary(k => k.Id, v => v.Name);

            return View(user);
        }
        [Route("/Users/Create")]
        [Route("/Users/Edit/{id}")]
        [HttpPost]
        public async Task<IActionResult> CreateAsync(ApplicationUser applicationUser, List<string> Roles, string id = null)
        {
            var userDb = AspNetUserBao.GetById(id);
            ViewBag.IsEdit = id != null;
            if (id != null && userDb == null)
            {
                return RedirectToAction("Error", "Home");
            }
            if (id != null && applicationUser != null)
            {

            }
            if (id == null)
            {
                applicationUser.UserName = applicationUser.Email;
                var result = await _userManager.CreateAsync(applicationUser, applicationUser.PasswordHash);
                if (result.Succeeded)
                {
                    return RedirectToAction("Edit", new { id = applicationUser.Id });
                }
                else
                {

                }
            }
            else
            {
                var user = await _userManager.FindByIdAsync(id);
                if (user != null)
                {
                    user.Name = applicationUser.Name;
                    user.UserName = user.Email = applicationUser.Email;
                    user.NormalizedUserName = user.NormalizedEmail = applicationUser.Email.ToUpper();
                    var updateResult = await _userManager.UpdateAsync(user);
                    if (updateResult.Succeeded)
                    {
                        if (!string.IsNullOrWhiteSpace(applicationUser.PasswordHash))
                        {
                            var code = await _userManager.GeneratePasswordResetTokenAsync(user);
                            var setPasswordResult = await _userManager.ResetPasswordAsync(user, code, applicationUser.PasswordHash);
                            System.Console.WriteLine(setPasswordResult.Succeeded);
                        }
                        AspNetUserRolesBao.Delete(id);
                        foreach (var item in Roles)
                        {
                            var role = new AspNetUserRoles
                            {
                                UserId = id,
                                RoleId = item
                            };
                            AspNetUserRolesBao.Insert(role);
                        }
                        return RedirectToAction("Index");
                    }
                }
                else
                {
                    return View(userDb);
                }
            }


            if (id != null && userDb == null)
            {
                return RedirectToAction("Error", "Home");
            }

            ViewBag.AspNetRoles = (AspNetRolesBao.GetAll() ?? new List<AspNetRoles>()).ToDictionary(k => k.Id, v => v.Name);

            return View(userDb);

        }
        [Route("/Users/Delete/{id}")]
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
                var user = AspNetUserBao.GetById(id);
                if (user != null)
                {
                    await _userManager.DeleteAsync(user);
                }
            }
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> UpdateUserStatus(string id, bool status)
        {

            if (id != null)
            {
               // var user = AspNetUserBao.GetById(id);
                var user=_userManager.FindByIdAsync(id);
                if (user != null)
                {
                    user.Result.LockoutEnabled = status;
                    await _userManager.UpdateAsync(user.Result);
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