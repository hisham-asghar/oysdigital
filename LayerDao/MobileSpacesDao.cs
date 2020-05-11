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
        public static List<MobileSpaces> GetByMobileId(long id)
        {
            var where = $"MobileId = {id}";
            return TableConstants.MobileSpaces.SelectList<MobileSpaces>(where);
        }
        public static List<MobileSpaces> GetByProjectId(long id)
        {
            var where = $"ProjectId = {id}";
            return TableConstants.MobileSpaces.SelectList<MobileSpaces>(where);
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
