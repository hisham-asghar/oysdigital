using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin + "," + UserRoles.Hr)]
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
        [HttpGet]
        public IActionResult Create(long projectId = 0, string type = null, string returnUrl = null)
        {
            var project = ProjectBao.GetById(projectId);
            if (project == null || type == null) return RedirectToAction("Error", "Home");

            var members = ProjectMembersBao.GetByProjectId(projectId) ?? new List<ProjectMembers>();
            var found = members.FirstOrDefault(m =>
                !string.IsNullOrWhiteSpace(m.MemberType)
                && m.MemberType.ToLower() == type.ToLower());
            if (found != null) return Redirect(returnUrl);

            var users = (AspNetUserRolesBao.GetAll() ?? new List<AspNetUserRoles>())
                .Where(u => u.NormalizedRoles.Contains(type.ToUpper()) || u.NormalizedRoles.Contains(type.ToUpper()))
                .ToList().CreateDictionaryWithKeyStringFromModelList("UserId", "Name");
            ViewBag.Projects = new Dictionary<int, string>
            {
                { (int)project.Id, project.Name }
            };
            ViewBag.ProjectMemberTypes = new Dictionary<int, string>
            {
                { 0, type }
            };
            return View(users);
        }
        [Route("/ProjectMembers/Create")]
        [HttpPost]
        public IActionResult Create(string userId, int id = 0, long projectId = 0, string type = null, string returnUrl = null)
        {
            var project = ProjectBao.GetById(projectId);
            if (project == null || type == null) return RedirectToAction("Error", "Home");

            var memberType = ProjectMemberTypeBao.GetAll().FirstOrDefault(m => m.Name.ToLower() == type.ToLower());
            if (memberType == null) return RedirectToAction("Error", "Home");


            var member = new ProjectMembers()
            {
                AspNetUserId = userId,
                ProjectId = projectId,
                ProjectMemberTypeId = memberType.Id
            };
            member.SetOnCreate(User.GetUserId());
            ProjectMembersBao.Insert(member);

            if (string.IsNullOrWhiteSpace(returnUrl) == false)
                return RedirectPermanent(returnUrl);
            return RedirectToAction("Detail", "Project", new { id = projectId });

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

        public IActionResult ConfirmDelete(long id, string returnUrl = null)
        {
            if (id != 0)
            {
                ProjectMembersBao.Delete(id);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);
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