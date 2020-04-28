using Generics.DataModels.AdminModels;
using LayerDao;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerBao
{
    public class PlatformBao
    {
        public static List<Platforms> GetAll()
        {
            return PlatformDao.GetAll();
        }
        public static Platforms GetById(long id)
        {
            return PlatformDao.GetById(id);
        }
        public static List<Platforms> GetByProjectId(long id)
        {
            return PlatformDao.GetByProjectId(id);
        }
        public static bool Insert(Platforms c)
        {
            return PlatformDao.Insert(c);
        }
        public static bool Update(Platforms c)
        {
            return PlatformDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return PlatformDao.Delete(id);
        }
    }
}
