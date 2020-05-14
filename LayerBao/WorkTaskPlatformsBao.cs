using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class WorkTaskPlatformsBao
    {
        public static List<WorkTaskPlatforms> GetAll()
        {
            return WorkTaskPlatformsDao.GetAll();
        }
        public static WorkTaskPlatforms GetById(long id)
        {
            return WorkTaskPlatformsDao.GetById(id);
        }
        public static List<WorkTaskPlatforms> GetByWorkTaskId(long id)
        {
            return WorkTaskPlatformsDao.GetByWorkTaskId(id);
        }
        public static bool Insert(WorkTaskPlatforms worktaskplatforms)
        {
            return WorkTaskPlatformsDao.Insert(worktaskplatforms);
        }
        public static bool Update(WorkTaskPlatforms worktaskplatforms)
        {
            return WorkTaskPlatformsDao.Update(worktaskplatforms);
        }
        public static bool Delete(long id)
        {
            return WorkTaskPlatformsDao.Delete(id);
        }

        public static bool CheckWorkTaskPlatformExist(long workTaskId, long platformId)
        {
            return WorkTaskPlatformsDao.CheckWorkTaskPlatformExist(workTaskId,platformId);
        }
    }
}
