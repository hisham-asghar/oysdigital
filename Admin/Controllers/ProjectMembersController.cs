using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
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
        [HttpGet]
        public IActionResult Create(long Id)
        {

            if (Id != 0)
            {
                var data = ProjectMembersBao.GetById(Id);
                 if (data != null)
                {
                    ViewData["ProjectMemberTypesId"] = new SelectList(GetMembersSortedList(data.ProjectMemberTypesId), "ProjectMemberTypesId", "ProjectMemberTypeName", data.ProjectMemberTypesId);
                    return View(data);
                }
                ProjectMembers m = new ProjectMembers();
                m.ProjectMembersId = 0; m.ProjectMemberTypesId = 0; m.ProjectId = Id; m.IsActive = false;
                ViewData["ProjectMemberTypesId"] = new SelectList(GetMembersSortedList(Id), "ProjectMemberTypesId", "ProjectMemberTypeName");
                return View(m);
            }
            else
            {
                return RedirectToAction("Index");
            }
            //return View();
        }
        public List<ProjectMembers> GetMembersSortedList(long id)
        {
            List<ProjectMembers> pal = new List<ProjectMembers>();
            var projectMembers = ProjectMembersBao.GetAll();
            foreach (var item in projectMembers)
            {
                if (id != item.ProjectMemberTypesId)
                {
                    pal.Add(item);
                }
            }
            return pal;
        }
        [HttpPost]
        public IActionResult Create(ProjectMembers projectmembers)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try
            {

                if (projectmembers.ProjectMembersId == 0)
                {
                    projectmembers.OnCreated = DateTime.Now;
                    projectmembers.CreatedBy = userId;
                    ProjectMembersBao.Insert(projectmembers);
                    return RedirectToAction("Index");
                }
                else
                {
                    projectmembers.OnModified = DateTime.Now;
                    projectmembers.ModifiedBy = userId;
                    ProjectMembersBao.Update(projectmembers);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(projectmembers);
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