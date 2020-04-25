using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class MobileSpacesBao
    {
        public static List<MobileSpaces> GetAll()
        {
            return MobileSpacesDao.GetAll();
        }
        public static MobileSpaces GetById(long id)
        {
            return MobileSpacesDao.GetById(id);
        }
        public static bool Insert(MobileSpaces c)
        {
            return MobileSpacesDao.Insert(c);
        }
        public static bool Update(MobileSpaces c)
        {
            return MobileSpacesDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return MobileSpacesDao.Delete(id);
        }
    }
}
