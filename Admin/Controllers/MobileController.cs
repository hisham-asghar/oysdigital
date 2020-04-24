using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class MobileController : Controller
    {
        public IActionResult Index()
        {
            return View(MobileBao.GetAll());
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = MobileBao.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                Mobile m = new Mobile();
                m.Name = "";m.MobileId = 0;m.IsActive=false;
                return View(m);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(Mobile mobile)
        {
            try
            {

                if (mobile.MobileId == 0)
                {
                    mobile.OnCreated = DateTime.Now;
                    MobileBao.Insert(mobile);
                    return RedirectToAction("Index");
                }
                else
                {
                    mobile.OnModified = DateTime.Now;
                    MobileBao.Update(mobile);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(mobile);
        }

        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(MobileBao.GetById(id));
            }
            return View();
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
            if (id != 0)
            {
                return View(MobileBao.GetById(id));
            }
            return View();
        }
    }
}