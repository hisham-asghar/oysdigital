﻿using System;
using System.Collections;
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
    public class MobileSpacesController : Controller
    {
        public IActionResult Index()
        {
            var data = MobileSpacesBao.GetAll();
            
            return View(data);
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            
            if (Id != 0)
            {
                var data = MobileSpacesBao.GetById(Id);
                ViewData["MobileId"] = new SelectList(MobileBao.GetAll(), "MobileId", "MobileName", data.MobileId);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                MobileSpaces m = new MobileSpaces();
                m.Name = ""; m.MobileId = 0; m.Id = 0; m.IsActive = false;
                ViewData["MobileId"] = new SelectList(MobileBao.GetAll(), "MobileId", "MobileName");
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(MobileSpaces mobilespaces)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try
            {

                if (mobilespaces.Id == 0)
                {
                    mobilespaces.OnCreated = DateTime.Now;
                    mobilespaces.CreatedBy = userId;
                    MobileSpacesBao.Insert(mobilespaces);
                    return RedirectToAction("Index");
                }
                else
                {
                    mobilespaces.OnModified = DateTime.Now;
                    mobilespaces.ModifiedBy = userId;
                    MobileSpacesBao.Update(mobilespaces);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(mobilespaces);
        }

        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(MobileSpacesBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                MobileSpacesBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(MobileSpacesBao.GetById(id));
            }
            return View();
        }
    }
}