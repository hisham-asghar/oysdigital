using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;
using System.Linq;

namespace LayerDao
{
    public class WorkTaskPlatformsDao
    {
        public static List<WorkTaskPlatforms> GetAll()
        {
            var query = $"Select WorkTaskPlatforms.*,Platform.Name as PlatformName,Platform.IconClass as PlatformIcon from WorkTaskPlatforms join Platform on Platform.Id=WorkTaskPlatforms.PlatformId;";
            return QueryExecutor.List<WorkTaskPlatforms>(query);
        }
        public static WorkTaskPlatforms GetById(long id)
        {
            var query = $"select WorkTaskPlatforms.*,Platform.Name as PlatformName,Platform.IconClass as PlatformIcon from WorkTaskPlatforms join Platform on Platform.Id=WorkTaskPlatforms.PlatformId where WorkTaskPlatforms.Id={id};";
            return QueryExecutor.FirstOrDefault<WorkTaskPlatforms>(query);
        }
        public static List<WorkTaskPlatforms> GetByWorkTaskId(long id)
        {
            var query = $"select WorkTaskPlatforms.*,Platform.Name as PlatformName,Platform.IconClass as PlatformIcon from WorkTaskPlatforms join Platform on Platform.Id=WorkTaskPlatforms.PlatformId where WorkTaskId={id};";
            return QueryExecutor.List<WorkTaskPlatforms>(query);
        }
        public static List<WorkTaskPlatforms> GetByProjectIds(List<long> ids)
        {
            if (ids == null || ids.Count == 0) return new List<WorkTaskPlatforms>();
            string idStr;
            if (ids.Count == 1)
                idStr = ids.FirstOrDefault() + "";
            else idStr = ids.Select(id => id + "").Aggregate((c, n) => $"{c},{n}");
            return ViewConstants.WORK_TASK_PLATFORM_VIEW.SelectList<WorkTaskPlatforms>($" WorkTaskId IN (SELECT Id FROM dbo.WorkTask WHERE ProjectId IN ({idStr})) ");
        }

        public static WorkTaskPlatforms GetByBoth(long workTaskId, long platformId)
        {
            var query = $"select WorkTaskPlatforms.*,Platform.Name as PlatformName,Platform.IconClass as PlatformIcon from WorkTaskPlatforms join Platform on Platform.Id=WorkTaskPlatforms.PlatformId where WorkTaskPlatforms.WorkTaskId={workTaskId} AND PlatformId={platformId};";
            return QueryExecutor.FirstOrDefault<WorkTaskPlatforms>(query);
        }

        public static bool CheckWorkTaskPlatformExist(long workTaskId, long platformId)
        {
            var query = $"select WorkTaskPlatforms.*,Platform.Name as PlatformName,Platform.IconClass as PlatformIcon from WorkTaskPlatforms join Platform on Platform.Id=WorkTaskPlatforms.PlatformId where WorkTaskPlatforms.WorkTaskId={workTaskId} AND PlatformId={platformId};";
            return QueryExecutor.FirstOrDefault<WorkTaskPlatforms>(query) == null ? false : true;
        }


        public static bool Insert(WorkTaskPlatforms worktaskplatfroms)
        {
            return worktaskplatfroms.Insert(TableConstants.WorkTaskPlatforms) > 0;
        }
        public static bool Update(WorkTaskPlatforms worktaskplatfroms)
        {
            return worktaskplatfroms.Update(TableConstants.WorkTaskPlatforms, (int)worktaskplatfroms.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.WorkTaskPlatforms.Delete((int)id);
        }
    }
}
