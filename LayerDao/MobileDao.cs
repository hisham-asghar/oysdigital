using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class MobileDao
    {
        public static List<Mobile> GetAll()
        {
            return TableConstants.Mobile.SelectAll<Mobile>();
        }
        public static Mobile GetById(long id)
        {
            return TableConstants.Mobile.Select<Mobile>((int)id);
        }
        public static bool Insert(Mobile mobile)
        {
            return mobile.Insert(TableConstants.Mobile) > 0;
        }
        public static bool Update(Mobile mobile)
        {
            return mobile.Update(TableConstants.Mobile, (int)mobile.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.Mobile.Delete((int)id);
        }
    }
}
