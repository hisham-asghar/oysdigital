using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
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
        [Route("/MobileSpaces/Create")]
        [Route("/MobileSpaces/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            MobileSpaces mobilespaces = id <= 0 ? new MobileSpaces() : MobileSpacesBao.GetById(id);
            if (id > 0 && mobilespaces == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            return View(mobilespaces);
        }
        [Route("/MobileSpaces/Create")]
        [Route("/MobileSpaces/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(MobileSpaces mobilespaces, int id = 0)
        {
            MobileSpaces mobilespacesDb = MobileSpacesBao.GetById(id);
            if (id > 0 && mobilespacesDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (mobilespaces == null)
            {
                mobilespacesDb = mobilespacesDb ?? new MobileSpaces();
                ViewBag.IsEdit = id > 0;
                return View(mobilespacesDb);
            }
            if (id == 0)
            {
                mobilespaces.SetOnCreate(userId);
                if (MobileSpacesBao.Insert(mobilespaces))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    return View(mobilespaces);
                }
            }
            else
            {
                mobilespaces.SetOnUpdate(userId);
                MobileSpacesBao.Update(mobilespaces);
            }

            return RedirectToAction("Index");

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