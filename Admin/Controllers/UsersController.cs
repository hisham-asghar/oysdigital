﻿using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
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
        public IActionResult Index()
        {
            var userWithRolesDictionary = (AspNetUserRolesBao.GetAll() ?? new List<AspNetUserRoles>()).ToDictionary(k => k.UserId, v => v.Roles);
            var users = AspNetUserBao.GetAll() ?? new List<ApplicationUser>();
            var userRoles = users.Select(u => new KeyValuePair<ApplicationUser, List<string>>(u, userWithRolesDictionary.Get(u.Id))).ToList();
            return View(userRoles);
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
                applicationUser.UserName = applicationUser.Email;
                userDb.UserName = userDb.Email = applicationUser.Email;
                userDb.Name = applicationUser.Name;
                if (!string.IsNullOrWhiteSpace(applicationUser.PasswordHash) && applicationUser.PasswordHash.Length > 5)
                {
                    userDb.PasswordHash = applicationUser.PasswordHash;
                }
                var result = AspNetUserBao.Update(userDb);
                if (result)
                {
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
                var user = AspNetUserBao.GetById(id);
                if (user != null)
                {
                    user.LockoutEnabled = status;
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