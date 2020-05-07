using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

namespace Admin.Controllers
{
    public class JsonController : Controller
    {
        [Route("/Json/Getplatforms")]
        [HttpGet]
        public JsonResult Getplatforms()
        {
            var list = PlatformBao.GetAll();
            return Json(list);
        }
        [Route("/Json/GetMobileSpaces")]
        [HttpGet]
        public JsonResult GetMobileSpaces()
        {
            var list = MobileSpacesBao.GetAll();
            return Json(list);
        }
    }
}