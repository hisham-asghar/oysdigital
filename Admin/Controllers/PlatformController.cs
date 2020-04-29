using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Claims;
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
        public ImageUploader i;
        private readonly IHostingEnvironment _environment;
        public PlatformController(IHostingEnvironment environment)
        {
            _environment = environment ?? throw new ArgumentNullException(nameof(environment));
        }
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
                Platform p = new Platform();
                p.PlatformName = ""; p.PlatformId = 0; p.IconUrl = ""; p.IsActive=false;
                return View(p);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(Platform platform ,IFormFile file)
        {
            
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try
            {

                if (platform.PlatformId == 0)
                {
                    if (file != null)
                    {
                        platform.OnCreated = DateTime.Now;
                        platform.IconUrl= SaveImage(file);
                        platform.CreatedBy = userId;
                    }
                    PlatformBao.Insert(platform);
                    return RedirectToAction("Index");
                }
                else
                {
                    
                    platform.OnModified = DateTime.Now;
                    if (file != null)
                    {
                        DeleteImage(platform.IconUrl);
                        platform.IconUrl = SaveImage(file);
                        platform.ModifiedBy = userId;
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
        public string SaveImage(IFormFile file)
        {
            // do other validations on your model as needed
            var uploads = Path.Combine(_environment.WebRootPath, "uploads");
            var uniquefileName = GetUniqueFileName(file.FileName);
            if (file.Length > 0)
            {
                using (var fileStream = new FileStream(Path.Combine(uploads, uniquefileName), FileMode.Create))
                {
                    file.CopyToAsync(fileStream);
                }
                return uniquefileName;
            }
            return null;
            // to do  : Return something
        }
        private string GetUniqueFileName(string fileName)
        {
            fileName = Path.GetFileName(fileName);
            return Path.GetFileNameWithoutExtension(fileName)
                      + "_"
                      + Guid.NewGuid().ToString().Substring(0, 4)
                      + Path.GetExtension(fileName);
        }
        public bool DeleteImage(string file)
        {
            var uploads = Path.Combine(_environment.WebRootPath, "uploads");
            string fileName = Path.Combine(uploads, file);

            if (fileName != null || fileName != string.Empty)
            {
                if ((System.IO.File.Exists(fileName)))
                {
                    System.IO.File.Delete(fileName);
                    return true;
                }

            }
            return false;
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