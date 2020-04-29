using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class MobileSpacesDao
    {
        public static List<MobileSpaces> GetAll()
        {
            return TableConstants.MobileSpaces.SelectAll<MobileSpaces>();
        }
        public static MobileSpaces GetById(long id)
        {
            return TableConstants.MobileSpaces.Select<MobileSpaces>((int)id);
        }
        public static bool Insert(MobileSpaces mobilespaces)
        {
            return mobilespaces.Insert(TableConstants.MobileSpaces) > 0;
        }
        public static bool Update(MobileSpaces mobilespaces)
        {
            return mobilespaces.Update(TableConstants.MobileSpaces, (int)mobilespaces.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.MobileSpaces.Delete((int)id);
        }
    }
}
