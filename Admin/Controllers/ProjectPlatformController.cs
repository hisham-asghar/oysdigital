using System;
using System.Collections.Generic;
using System.Linq;
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

        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = ProjectPlatformsBao.GetById(Id);
                if (data != null)
                {
                    ViewData["MobileSpacesId"] = new SelectList(MobileSpacesBao.GetAll(), "MobileSpacesId", "SpaceName",data.MobileSpacesId);
                    ViewData["PlatformId"] = new SelectList(PlatformBao.GetAll(), "PlatformId", "PlatformName",data.PlatformId);
                    return View(data);
                }

                ViewData["MobileSpacesId"] = new SelectList(MobileSpacesBao.GetAll(), "MobileSpacesId", "SpaceName");
                ViewData["PlatformId"] = new SelectList(PlatformBao.GetAll(), "PlatformId", "PlatformName");

                ProjectPlatforms m = new ProjectPlatforms();
                m.ProjectPlatformsId = 0; m.ProjectId = Id; m.IsActive = false;m.PostsQuantity = 0;m.StoriesQuantity = 0;
                return View(m);
            }
            else
            {
                return RedirectToAction("Index");
            }
           // return View();
        }
        [HttpPost]
        public IActionResult Create(ProjectPlatforms projectplatform)
        {
            try
            {
                if (projectplatform.PostPerDay == 0)
                {
                    projectplatform.PostPerDay = projectplatform.PostsQuantity;
                    projectplatform.PostPerWeek = 0; projectplatform.PostPerMonth = 0;
                }
                if (projectplatform.PostPerDay == 1)
                {
                    projectplatform.PostPerWeek = projectplatform.PostsQuantity;
                    projectplatform.PostPerDay = 0; projectplatform.PostPerMonth = 0;
                }
                if (projectplatform.PostPerDay == 2)
                {
                    projectplatform.PostPerMonth = projectplatform.PostsQuantity;
                    projectplatform.PostPerWeek = 0; projectplatform.PostPerDay = 0;
                }
                if (projectplatform.StoriesPerDay == 0)
                {
                    projectplatform.StoriesPerDay = projectplatform.StoriesQuantity;
                    projectplatform.StoriesPerWeek = 0; projectplatform.StoriesPerMonth = 0;
                }
                if (projectplatform.StoriesPerDay == 1)
                {
                    projectplatform.StoriesPerWeek = projectplatform.StoriesQuantity;
                    projectplatform.StoriesPerDay = 0; projectplatform.StoriesPerMonth = 0;
                }
                if (projectplatform.StoriesPerDay == 2)
                {
                    projectplatform.StoriesPerMonth = projectplatform.StoriesQuantity;
                    projectplatform.StoriesPerWeek = 0; projectplatform.StoriesPerDay = 0;
                }
                if (projectplatform.ProjectPlatformsId == 0)
                {
                    projectplatform.OnCreated = DateTime.Now;
                    ProjectPlatformsBao.Insert(projectplatform);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectplatform.OnModified = DateTime.Now;
                    ProjectPlatformsBao.Update(projectplatform);
                    return RedirectToAction("Index");
                }
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