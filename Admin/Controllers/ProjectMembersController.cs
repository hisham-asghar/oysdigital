using System;
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
    public class ProjectMembersController : Controller
    {
        public IActionResult Index()
        {
            var data = ProjectMembersBao.GetAll();

            return View(data);
        }
        [Route("/ProjectMembers/Create")]
        [Route("/ProjectMembers/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            ProjectMembers projectmembers = id <= 0 ? new ProjectMembers() : ProjectMembersBao.GetById(id);
            if (id > 0 && projectmembers == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            ViewBag.PMT = new SelectList(ProjectMemberTypeBao.GetAll(),"Name", "Id");
            return View(projectmembers);
        }
        [Route("/ProjectMembers/Create")]
        [Route("/ProjectMembers/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectMembers projectmembers, int id = 0)
        {
            ProjectMembers projectmembersDb = ProjectMembersBao.GetById(id);
            if (id > 0 && projectmembersDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectmembers == null)
            {
                projectmembersDb = projectmembersDb ?? new ProjectMembers();
                ViewBag.IsEdit = id > 0;
                return View(projectmembersDb);
            }
            if (id == 0)
            {
                projectmembers.SetOnCreate(userId);
                if (ProjectMembersBao.Insert(projectmembers))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    return View(projectmembers);
                }
            }
            else
            {
                projectmembers.SetOnUpdate(userId);
                ProjectMembersBao.Update(projectmembers);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(ProjectMembersBao.GetById(id));
            }
            return View();
        }

        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                ProjectMembersBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(ProjectMembersBao.GetById(id));
            }
            return View();
        }
    }
}