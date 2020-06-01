using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectNotesBao
    {
        public static List<ProjectNotes> GetAll()
        {
            return ProjectNotesDao.GetAll();
        }
        public static ProjectNotes GetById(long id)
        {
            return ProjectNotesDao.GetById(id);
        }
        public static long Insert(ProjectNotes projectnotes)
        {
            return ProjectNotesDao.Insert(projectnotes);
        }
        public static bool Update(ProjectNotes projectnotes)
        {
            return ProjectNotesDao.Update(projectnotes);
        }
        public static bool Delete(long id)
        {
            return ProjectNotesDao.Delete(id);
        }
    }
}
