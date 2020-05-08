using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
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
        [Route("/ProjectPlatform/Create")]
        [Route("/ProjectPlatform/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0, long projectId = 0, string returnUrl = null)
        {
            ProjectPlatforms projectplatform = id <= 0 ? new ProjectPlatforms() : ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatform == null)
            {
                // Dont Exist
            }
            else
            {
                var project = ProjectBao.GetById(projectId);
                if (project == null)
                    ViewBag.ProjectDictionary = ProjectBao.GetAll().CreateDictionaryFromModelList();
                else
                {
                    var dictionary = new Dictionary<int, string>();
                    dictionary.Add((int)project.Id, project.Name);
                    ViewBag.ProjectDictionary = dictionary;
                }
                ViewBag.PlatformDictionary = Functions.CreateDictionaryFromModelList(PlatformBao.GetAll());
                ViewBag.MobileSpacesDictionary = Functions.CreateDictionaryFromModelList(MobileSpacesBao.GetAll());
            }
            ProjectPlaformCreateView p = new ProjectPlaformCreateView();

            ViewBag.IsEdit = id > 0;
            if (projectplatform != null)
            {
                p = ProjectPlatformHelper.ProjectPlatformCreateViewParser(projectplatform);
                return View(p);
            }
            else
            {
                return View(p);
            }
        }
        [Route("/ProjectPlatform/Create")]
        [Route("/ProjectPlatform/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(ProjectView projectview, int id = 0, long projectId = 0, string returnUrl = null)
        {
            ProjectPlatforms projectplatformDb = ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatformDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (projectview == null)
            {
                projectplatformDb = projectplatformDb ?? new ProjectPlatforms();
                ViewBag.IsEdit = id > 0;
                return View(projectplatformDb);
            }
            if (id == 0)
            {
                ProjectPlatforms projectplatform = new ProjectPlatforms();
                projectplatform.SetOnCreate(userId);
                foreach (var item in projectview.ProjectPlatforms)
                {
                    projectplatform.PlatformId = item.ToLong();
                    projectplatform.MobileSpaceId = projectview.MobileSpaceId;
                    projectplatform.ProjectId = projectview.ProjectId;
                    projectplatform.Link = projectview.Link;
                    ProjectPlatformsBao.Insert(projectplatform);
                }
                ProjectTask projectTask = new ProjectTask();
                projectTask.ProjectId = projectview.ProjectId;
                projectTask.TaskTypeId = TaskType.CheckTaskTypeByName(projectview.PlatformType);
                projectTask.Frequency = projectview.Quantity;
                if (projectview.PlatformType == "Stories") {
                    projectTask.FrequencyTypeId = projectview.StoryType;
                }
                else
                {
                    projectTask.FrequencyTypeId = 0;
                }
                long projecttaskId=ProjectTaskBao.Insert(projectTask);
                for(int x = 0; x < projectview.Quantity; x++)
                {
                    ProjectTaskScheduling projectTaskScheduling = new ProjectTaskScheduling();
                    projectTaskScheduling.ProjectTaskId = projecttaskId;
                    projectTaskScheduling.Time = DateTime.Now;
                    ProjectTaskSchedulingBao.Insert(projectTaskScheduling);
                }
               }
            else
            {
               // ProjectPlatforms project = ProjectPlatformHelper.ProjectPlatformParser(projectplatform);
               // project.SetOnUpdate(userId);
               // ProjectPlatformsBao.Update(project);
            }
            if (string.IsNullOrWhiteSpace(returnUrl))
                return RedirectToAction("Index");
            else
                return RedirectPermanent(returnUrl);

        }
        public IActionResult Delete(long id)
        {
            ProjectPlatforms projectplatform = ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.projectplatformDictionary = Functions.CreateDictionaryFromModel(projectplatform);
            }
            return View(projectplatform);
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
            ProjectPlatforms projectplatform = ProjectPlatformsBao.GetById(id);
            if (id > 0 && projectplatform == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.projectplatformDictionary = Functions.CreateDictionaryFromModel(projectplatform);
            }
            return View(projectplatform);
        }
    }
}