using Generics.DataModels.AdminModels;
using LayerDao;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerBao
{
    public static class MobileBao
    {
        public static List<Mobile> GetAll()
        {
            return MobileDao.GetAll();
        }
        public static Mobile GetById(long id)
        {
            var mobile = MobileDao.GetById(id);
            if (mobile != null) mobile.Spaces = MobileSpacesDao.GetByMobileId(id);
            return mobile;
        }
        public static bool Insert(Mobile mobile)
        {
            return MobileDao.Insert(mobile);
        }
        public static bool Update(Mobile mobile)
        {
            return MobileDao.Update(mobile);
        }
        public static bool Delete(long id)
        {
            return MobileDao.Delete(id);
        }
    }
}
