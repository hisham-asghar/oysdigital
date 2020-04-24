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
        public readonly IHostingEnvironment _currentEnvironment;
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
                p.Name = ""; p.PlatformId = 0; p.IconUrl = ""; p.IsActive=false;
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
                        
                        platform.IconUrl= UploadedFile(file);
                    }
                    PlatformBao.Insert(platform);
                    return RedirectToAction("Index");
                }
                else
                {
                   
                    PlatformBao.Update(platform);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(platform);
        }
        private string UploadedFile(IFormFile file)
        {
            string uniqueFileName = null;

            if (file != null)
            {
                string uploadsFolder = Path.Combine(_currentEnvironment.WebRootPath, "uploads");
                uniqueFileName = Guid.NewGuid().ToString() + "_" + file.FileName;
                string filePath = Path.Combine(uploadsFolder, uniqueFileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    file.CopyTo(fileStream);
                }
            }
            return uniqueFileName;
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