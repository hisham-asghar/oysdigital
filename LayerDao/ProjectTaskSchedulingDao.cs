﻿using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;
using System.Linq;

namespace LayerDao
{
    public static class ProjectTaskSchedulingDao
    {
        public static List<ProjectTaskScheduling> GetAll()
        {
            return TableConstants.ProjectTaskScheduling.SelectAll<ProjectTaskScheduling>();
        }
        public static ProjectTaskScheduling GetById(long id)
        {
            return TableConstants.ProjectTaskScheduling.Select<ProjectTaskScheduling>((int)id);
        }
        public static List<ProjectTaskScheduling> GetByProjectTaskId(long id)
        {
            var where = $"ProjectTaskId={id}";
            return TableConstants.ProjectTaskScheduling.SelectList<ProjectTaskScheduling>(where);
        }
        public static bool Insert(ProjectTaskScheduling projecttaskscheduling)
        {
            return projecttaskscheduling.Insert(TableConstants.ProjectTaskScheduling) > 0;
        }
        public static bool Insert(List<ProjectTaskScheduling> projectTaskSchedulings)
        {
            if (projectTaskSchedulings == null || projectTaskSchedulings.Count <= 0) return false;
            return (projectTaskSchedulings.Insert(TableConstants.ProjectTaskScheduling) ?? new List<int>()).Count(i => i > 0) == projectTaskSchedulings.Count;
        }
        public static bool Update(ProjectTaskScheduling projecttaskscheduling)
        {
            return projecttaskscheduling.Update(TableConstants.ProjectTaskScheduling, (int)projecttaskscheduling.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectTaskScheduling.Delete((int)id);
        }
    }
}
