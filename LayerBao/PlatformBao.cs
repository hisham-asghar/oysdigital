using Generics.DataModels.AdminModels;
using LayerDao;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerBao
{
    public class PlatformBao
    {
        public static List<Platform> GetAll()
        {
            return PlatformDao.GetAll();
        }
        public static Platform GetById(long id)
        {
            return PlatformDao.GetById(id);
        }
        //public static List<Platform> GetByProjectId(long id)
        //{
        //    return PlatformDao.GetByProjectId(id);
        //}
        public static bool Insert(Platform platform)
        {
            return PlatformDao.Insert(platform);
        }
        public static bool Update(Platform platform)
        {
            return PlatformDao.Update(platform);
        }
        public static bool Delete(long id)
        {
            return PlatformDao.Delete(id);
        }
    }
}
