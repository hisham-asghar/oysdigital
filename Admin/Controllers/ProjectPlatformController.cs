﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
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
        [Route("/ProjectPlatform/Create")]
        [Route("/ProjectPlatform/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            ProjectPlatforms projectplatform = id <= 0 ? new ProjectPlatforms() : ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectDictionary = Functions.CreateDictionaryFromModelList(ProjectBao.GetAll());
                ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModelList(PlatformBao.GetAll());
                ViewBag.MobileSpacesDictionary = Functions.CreateDictionaryFromModelList(MobileSpacesBao.GetAll());
            }
            ProjectPlaformCreateView p = new ProjectPlaformCreateView();
            ViewBag.IsEdit = id > 0;
            if (projectplatform != null)
            {
                p = ProjectPlatformHelper.ProjectPlatformCreateViewParser(projectplatform);
                return View(p);
            }
            else
            {
                return View(p);
            }
        }
        [Route("/ProjectPlatform/Create")]
        [Route("/ProjectPlatform/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectPlaformCreateView projectplatform, int id = 0)
        {
            ProjectPlatforms projectplatformDb = ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatformDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectplatform == null)
            {
                projectplatformDb = projectplatformDb ?? new ProjectPlatforms();
                ViewBag.IsEdit = id > 0;
                return View(projectplatformDb);
            }
            if (id == 0)
            {
                ProjectPlatforms project=ProjectPlatformHelper.ProjectPlatformParser(projectplatform);
                project.SetOnCreate(userId);
                ProjectPlatformsBao.Insert(project);
            }
            else
            {
                ProjectPlatforms project = ProjectPlatformHelper.ProjectPlatformParser(projectplatform);
                project.SetOnUpdate(userId);
                ProjectPlatformsBao.Update(project);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            ProjectPlatforms projectplatform = ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.projectplatformDictionary = Functions.CreateDictionaryFromModel(projectplatform);
            }
            return View(projectplatform);
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
            ProjectPlatforms projectplatform = ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.projectplatformDictionary = Functions.CreateDictionaryFromModel(projectplatform);
            }
            return View(projectplatform);
        }
    }
}