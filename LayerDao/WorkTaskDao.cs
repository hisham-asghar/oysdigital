using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class WorkTaskDao
    {
        public static List<WorkTask> GetAll()
        {
            var query = $"select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId;";
            return QueryExecutor.List<WorkTask>(query);
        }
        public static WorkTask GetById(long id)
        {
            var query = $"select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where WorkTask.Id={id};";
            return QueryExecutor.FirstOrDefault<WorkTask>(query);
        }
        public static long Insert(WorkTask worktask)
        {
            return worktask.Insert(TableConstants.WorkTask);
        }
        public static bool Update(WorkTask worktask)
        {
            return worktask.Update(TableConstants.WorkTask, (int)worktask.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.WorkTask.Delete((int)id);
        }
        public static List<WorkTask> CheckTaskCreated(DateTime date)
        {
            var query = $"Select WorkTask.*,Project.Name as ProjectName from WorkTask join Project on Project.Id=WorkTask.ProjectId where WorkTask.OnCreated='{date}';";
            return QueryExecutor.List<WorkTask>(query);
        }
    }
}
