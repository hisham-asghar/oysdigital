using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public static class ProjectTaskDao
    {
        public static List<ProjectTask> GetAll()
        {
            var query = $"select ProjectTask.*,Project.Name as ProjectName from ProjectTask join Project on Project.Id=ProjectTask.ProjectId;";
            return QueryExecutor.List<ProjectTask>(query);
        }
        public static ProjectTask GetById(long id)
        {
            return TableConstants.ProjectTask.Select<ProjectTask>((int)id);
        }
        public static List<ProjectTask> GetByProjectId(long id)
        {
            var where = $"ProjectId={id}";
            var data = TableConstants.ProjectTask.SelectList<ProjectTask>(where);
           
            if (data != null)
            {
               
                foreach (var item in data)
                {
                    var projecttask = $"ProjectTaskId={item.Id}";
                    var query = $"select ProjectPlatforms.*,Platform.Name as PlatformName,Platform.IconClass as PlatformIcon,MobileSpaces.Name as MobileSpaceName from ProjectPlatforms join MobileSpaces on ProjectPlatforms.MobileSpaceId=MobileSpaces.Id join Platform on platform.Id=ProjectPlatforms.PlatformId where ProjectId={id};";
                    item.ProjectPlatforms = QueryExecutor.List<ProjectPlatforms>(query);
                    item.ProjectTaskScheduling = TableConstants.ProjectTaskScheduling.SelectList<ProjectTaskScheduling>(projecttask);
                }
            }
            return data;
        }
        public static long Insert(ProjectTask projecttask)
        {
            return projecttask.Insert(TableConstants.ProjectTask);
        }
        public static bool Update(ProjectTask projecttask)
        {
            return projecttask.Update(TableConstants.ProjectTask, (int)projecttask.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectTask.Delete((int)id);
        }
    }
}
