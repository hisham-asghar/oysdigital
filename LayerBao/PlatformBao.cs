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
        public static List<Platform> GetByProjectId(long id)
        {
            return PlatformDao.GetByProjectId(id);
        }
        public static bool Insert(Platform c)
        {
            return PlatformDao.Insert(c);
        }
        public static bool Update(Platform c)
        {
            return PlatformDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return PlatformDao.Delete(id);
        }
    }
}
