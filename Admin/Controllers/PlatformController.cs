using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class PlatformController : Controller
    {
        public ImageUploader i;
        [Obsolete]
        private readonly IHostingEnvironment _environment;

        [Obsolete]
        public PlatformController(IHostingEnvironment environment)
        {
            _environment = environment ?? throw new ArgumentNullException(nameof(environment));
        }
        public IActionResult Index()
        {
            return View(PlatformBao.GetAll());
        }
        [HttpGet]
         [Route("/Platform/Create")]
        [Route("/Platform/Edit/{id}")]
        [HttpPost]
        [Obsolete]
        public IActionResult Create(Platform platform,IFormFile file,int id = 0)
        {
            Platform platformDb = PlatformBao.GetById(id);
            if (id > 0 && platformDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (platform == null)
            {
                platformDb = platformDb ?? new Platform();
                ViewBag.IsEdit = id > 0;
                return View(platformDb);
            }
            if (id == 0)
            {
                platform.SetOnCreate(userId);
                platform.IconUrl = SaveImage(file);
                if (PlatformBao.Insert(platform))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    return View(platform);
                }
            }
            else
            {
                platform.SetOnUpdate(userId);
                DeleteImage(platform.IconUrl);
                platform.IconUrl = SaveImage(file);
                PlatformBao.Update(platform);
            }

            return RedirectToAction("Index");

        }

        [Obsolete]
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

        [Obsolete]
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