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
        public static List<MobileSpaces> GetByProjectId(long id)
        {
            return MobileSpacesDao.GetByProjectId(id);
        }
        public static bool Insert(MobileSpaces mobilespaces)
        {
            return MobileSpacesDao.Insert(mobilespaces);
        }
        public static bool Update(MobileSpaces mobilespaces)
        {
            return MobileSpacesDao.Update(mobilespaces);
        }
        public static bool Delete(long id)
        {
            return MobileSpacesDao.Delete(id);
        }
    }
}
