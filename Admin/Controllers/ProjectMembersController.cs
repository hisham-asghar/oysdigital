using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Admin.Controllers
{
    public class ProjectMembersController : Controller
    {
        private UserManager<ApplicationUser> _userManager;
        public ProjectMembersController(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }
        public IActionResult Index()
        {
            var data = ProjectMembersBao.GetAll();

            return View(data);
        }
        [Route("/ProjectMembers/Create")]
        [Route("/ProjectMembers/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0,long projectId=0,string returnUrl=null)
        {
            ProjectMembers projectmembers = id <= 0 ? new ProjectMembers() : ProjectMembersBao.GetById(id);
            if (id > 0 && projectmembers == null)
            {
                // Dont Exist
            }
            else
            {
                var project = ProjectBao.GetById(projectId);
                if (project == null)
                {
                   
                    ViewBag.ProjectDictionary = ProjectBao.GetAll().CreateDictionaryFromModelList();
                    
                }
                 else
                {
                    var prodictionary = new Dictionary<int, string>();
                    prodictionary.Add((int)project.Id, project.Name);
                    ViewBag.ProjectDictionary = prodictionary;
                }
                                
            }
            ViewBag.ProjectMemberTypeDictionary = ProjectMemberTypeBao.GetAll().CreateDictionaryFromModelList();
            var user = _userManager.Users.ToList();
            var dictionary = new Dictionary<string, string>();
            foreach (var item in user)
            {
                dictionary.Add(item.Id, item.Name);
            }
            ViewBag.AspNetUsersDictionary = dictionary;
            ViewBag.IsEdit = id > 0;
            return View(projectmembers);
        }
        [Route("/ProjectMembers/Create")]
        [Route("/ProjectMembers/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectMembers projectmembers, int id = 0, long projectId = 0, string returnUrl = null)
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
                ProjectMembersBao.Insert(projectmembers);
            }
            else
            {
                projectmembers.SetOnUpdate(userId);
                ProjectMembersBao.Update(projectmembers);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        public IActionResult Delete(long id)
        {
            ProjectMembers projectmembers = ProjectMembersBao.GetById(id);
            if (id > 0 && projectmembers == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectMembersDictionary = Functions.CreateDictionaryFromModel(projectmembers);
            }
            return View(projectmembers);
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
            ProjectMembers projectmembers = ProjectMembersBao.GetById(id);
            if (id > 0 && projectmembers == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.ProjectMembersDictionary = Functions.CreateDictionaryFromModel(projectmembers);
            }
            return View(projectmembers);
        }
    }
}