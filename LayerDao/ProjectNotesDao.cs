using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectNotesDao
    {
        public static List<ProjectNotes> GetAll()
        {
            return TableConstants.ProjectNotes.SelectAll<ProjectNotes>();
        }
        public static ProjectNotes GetById(long id)
        {
            return TableConstants.ProjectNotes.Select<ProjectNotes>((int)id);
        }
        public static bool Insert(ProjectNotes projectnotes)
        {
            return projectnotes.Insert(TableConstants.ProjectNotes) > 0;
        }
        public static bool Update(ProjectNotes projectnotes)
        {
            return projectnotes.Update(TableConstants.ProjectNotes, (int)projectnotes.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectNotes.Delete((int)id);
        }
    }
}
