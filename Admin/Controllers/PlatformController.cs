using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class PlatformController : Controller
    {
        ImageUploader i;
        public IActionResult Index()
        {
            return View(PlatformBao.GetAll());
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = PlatformBao.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                Platforms p = new Platforms();
                p.PlatformName = ""; p.PlatformId = 0; p.IconUrl = ""; p.IsActive=false;
                return View(p);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(Platforms platform ,IFormFile file)
        {
            try
            {

                if (platform.PlatformId == 0)
                {
                    if (file != null)
                    {
                        platform.OnCreated = DateTime.Now;
                        platform.IconUrl= i.SaveImage(file);
                    }
                    PlatformBao.Insert(platform);
                    return RedirectToAction("Index");
                }
                else
                {
                    
                    platform.OnModified = DateTime.Now;
                    if (file != null)
                    {
                        i.DeleteImage(platform.IconUrl);
                        platform.IconUrl = i.SaveImage(file);
                    }
                    
                    PlatformBao.Update(platform);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(platform);
        }
        
        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(PlatformBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                PlatformBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(PlatformBao.GetById(id));
            }
            return View();
        }
    }
}