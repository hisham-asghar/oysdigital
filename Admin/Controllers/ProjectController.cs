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
    public class ProjectController : Controller
    {
        public IActionResult Index()
        {
            var data = ProjectBao.GetAll();

            return View(data);
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = ProjectBao.GetById((long)Id);
                if (data != null)
                {
                    return View(data);
                }
                Project m = new Project();
                m.Id = 0; m.Id = Id; m.IsActive = false;
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(Project project)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try
            {

                if (project.Id == 0)
                {
                    project.OnCreated = DateTime.Now;
                    project.Guid = Guid.NewGuid().ToString();
                    project.CreatedBy = userId;
                    ProjectBao.Insert(project);
                    return RedirectToAction("Index");
                }
                else
                {
                    project.OnModified = DateTime.Now;
                    project.ModifiedBy = userId;
                    ProjectBao.Update(project);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(project);
        }

        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(ProjectBao.GetById(id));
            }
            return View();
        }
    }
}