﻿using System;
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
    public class ProjectPlatformController : Controller
    {
        public IActionResult Index()
        {
            var data = ProjectPlatformsBao.GetAll();

            return View(data);
        }
        public IActionResult Create()
        {
            return View();
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = ProjectPlatformsBao.GetById(Id);
                if (data != null)
                {
                    ViewData["Id"] = new SelectList(GetMobileSpacesSortedList(data.Id), "Id", "Name",data.Id);
                    ViewData["Id"] = new SelectList(GetPlatformSortedList(data.Id), "Id", "Name",data.Id);
                    
                    return View(data);
                }

                ViewData["Id"] = new SelectList(MobileSpacesBao.GetAll(), "Id", "Name");
                ViewData["Id"] = new SelectList(PlatformBao.GetAll(), "Id", "Name");

                ProjectPlatforms m = new ProjectPlatforms();
                m.Id = 0; m.ProjectId = Id; m.IsActive = false;
                return View(m);
            }
            else
            {
                return RedirectToAction("Index");
            }
           // return View();
        }
        public List<Platform> GetPlatformSortedList(long id)
        {
            List<Platform> pal = new List<Platform>();
            var platform = PlatformBao.GetAll();
            foreach (var item in platform)
            {
                if (id != item.Id)
                {
                    pal.Add(item);
                }
            }
            return pal;
        }
        public List<MobileSpaces> GetMobileSpacesSortedList(long id)
        {
            List<MobileSpaces> mob = new List<MobileSpaces>();
            var mobile = MobileSpacesBao.GetAll();
            foreach (var item in mobile)
            {
                if (id != item.Id)
                {
                    mob.Add(item);
                }
            }
            return mob;
        }
        [HttpPost]
        public IActionResult Save(ProjectPlatforms projectplatform)
        {
            try
            {
                //var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
                //if (projectplatform.PostPerDay == 0)
                //{
                //    projectplatform.PostPerDay = projectplatform.PostsQuantity;
                //    projectplatform.PostPerWeek = 0; projectplatform.PostPerMonth = 0;
                //}
                //if (projectplatform.PostPerDay == 1)
                //{
                //    projectplatform.PostPerWeek = projectplatform.PostsQuantity;
                //    projectplatform.PostPerDay = 0; projectplatform.PostPerMonth = 0;
                //}
                //if (projectplatform.PostPerDay == 2)
                //{
                //    projectplatform.PostPerMonth = projectplatform.PostsQuantity;
                //    projectplatform.PostPerWeek = 0; projectplatform.PostPerDay = 0;
                //}
                //if (projectplatform.StoriesPerDay == 0)
                //{
                //    projectplatform.StoriesPerDay = projectplatform.StoriesQuantity;
                //    projectplatform.StoriesPerWeek = 0; projectplatform.StoriesPerMonth = 0;
                //}
                //if (projectplatform.StoriesPerDay == 1)
                //{
                //    projectplatform.StoriesPerWeek = projectplatform.StoriesQuantity;
                //    projectplatform.StoriesPerDay = 0; projectplatform.StoriesPerMonth = 0;
                //}
                //if (projectplatform.StoriesPerDay == 2)
                //{
                //    projectplatform.StoriesPerMonth = projectplatform.StoriesQuantity;
                //    projectplatform.StoriesPerWeek = 0; projectplatform.StoriesPerDay = 0;
                //}
                //if (projectplatform.ProjectPlatformsId == 0)
                //{
                //    projectplatform.OnCreated = DateTime.Now;
                //    projectplatform.CreatedBy = userId;
                //    ProjectPlatformsBao.Insert(projectplatform);
                //    return RedirectToAction("Index");
                //}
                //else
                //{
                //    projectplatform.OnModified = DateTime.Now;
                //    projectplatform.ModifiedBy = userId;
                //    ProjectPlatformsBao.Update(projectplatform);
                //    return RedirectToAction("Index");
                //}
            }
            catch (Exception)
            {

            }
            return View(projectplatform);
        }

        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectPlatformsBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectPlatformsBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(ProjectPlatformsBao.GetById(id));
            }
            return View();
        }
    }
}