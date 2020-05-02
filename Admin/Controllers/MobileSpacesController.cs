using System.Collections.Generic;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

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
        public IActionResult Create(long id = 0, long mobileId = 0,string returnUrl = null)
        {
            
            MobileSpaces mobilespaces = id <= 0 ? new MobileSpaces() : MobileSpacesBao.GetById(id);
            if (id > 0 && mobilespaces == null)
            {
                // Dont Exist
            }
            else
            {
                var mobile = MobileBao.GetById(mobileId);
                if (mobile == null)
                    ViewBag.MobileDictionary = MobileBao.GetAll().CreateDictionaryFromModelList();
                else
                {
                    var dictionary = new Dictionary<int, string>();
                    dictionary.Add((int)mobile.Id, mobile.Name);
                    ViewBag.MobileDictionary = dictionary;
                }
            }
            ViewBag.IsEdit = id > 0;
            return View(mobilespaces);
        }

        [Route("/MobileSpaces/Create")]
        [Route("/MobileSpaces/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(MobileSpaces mobilespaces, int id = 0, long mobileId = 0, string returnUrl = null)
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
                MobileSpacesBao.Insert(mobilespaces);               
            }
            else
            {
                mobilespaces.SetOnUpdate(userId);
                MobileSpacesBao.Update(mobilespaces);
            }
            if(string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }

        public IActionResult Delete(long id)
        {
            MobileSpaces mobilespaces = MobileSpacesBao.GetById(id);
            if (id > 0 && mobilespaces == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.MobileSpacesDictionary = Functions.CreateDictionaryFromModel(mobilespaces);
            }
            return View(mobilespaces);
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
            MobileSpaces mobilespaces = MobileSpacesBao.GetById(id);
            if (id > 0 && mobilespaces == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.MobileSpacesDictionary = Functions.CreateDictionaryFromModel(mobilespaces);
            }
            return View(mobilespaces);
        }
    }
}