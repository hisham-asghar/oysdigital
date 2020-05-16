using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
    public class MobileController : Controller
    {
        public IActionResult Index()
        {
            return View(MobileBao.GetAll());
        }

        [Route("/Mobile/Create")]
        [Route("/Mobile/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            Mobile mobile = id <= 0 ? new Mobile() : MobileBao.GetById(id);
            if (id > 0 && mobile == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            return View(mobile);
        }
        [Route("/Mobile/Create")]
        [Route("/Mobile/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(Mobile mobile, int id = 0)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
            mobile.IsActive = IsActive;
            Mobile mobileDb = MobileBao.GetById(id);
            if(id > 0 && mobileDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if(mobile == null)
            {
                mobileDb = mobileDb ?? new Mobile(); 
                ViewBag.IsEdit = id > 0;
                return View(mobileDb);
            }


            if (id == 0)
            {
                mobile.SetOnCreate(userId);
                MobileBao.Insert(mobile);
            }
            else
            {
                mobile.SetOnUpdate(userId);
                MobileBao.Update(mobile);
            }

            return RedirectToAction("Index");

        }

        public IActionResult Delete(long id)
        {
            Mobile mobile = MobileBao.GetById(id);
            if (id > 0 && mobile == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.MobileDictionary = Functions.CreateDictionaryFromModel(mobile);
            }
            return View(mobile);
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                MobileBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            Mobile mobile = MobileBao.GetById(id);
            if (id > 0 && mobile == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.MobileDictionary = Functions.CreateDictionaryFromModel(mobile);
            }
            return View(mobile);
        }
    }
}