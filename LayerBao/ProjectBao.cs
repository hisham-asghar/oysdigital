using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectBao
    {
        public static List<Project> GetAll()
        {
            return ProjectDao.GetAll();
        }
        public static Project GetById(long id)
        {
            var project = ProjectDao.GetById(id);
            if (project != null)
            {
                project.projectTasks = ProjectTaskDao.GetByProjectId(id);
                project.ProjectMembers = ProjectMembersDao.GetByProjectId(id);
                project.ProjectAlertMessages = ProjectAlertMessageDao.GetByProjectId(id);
                project.ProjectNotes = ProjectNotesDao.GetByProjectId(id);
                project.Platforms = PlatformDao.GetAll();
            }
            return project;
        }
        public static List<Project> GetByCustomerId(long id)
        {
            return ProjectDao.GetByCustomerId(id);
        }
        public static bool Insert(Project project)
        {
            return ProjectDao.Insert(project);
        }
        public static bool Update(Project project)
        {
            return ProjectDao.Update(project);
        }
        public static bool Delete(long id)
        {
            return ProjectDao.Delete(id);
        }
    }
}
