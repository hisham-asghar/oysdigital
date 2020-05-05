using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class LabelTypeDao
    {
        public static List<LabelType> GetAll()
        {
            return TableConstants.LabelType.SelectAll<LabelType>();
        }
        public static LabelType GetById(long id)
        {
            return TableConstants.LabelType.Select<LabelType>((int)id);
        }
        public static bool Insert(LabelType mobile)
        {
            return mobile.Insert(TableConstants.LabelType) > 0;
        }
        public static bool Update(LabelType mobile)
        {
            return mobile.Update(TableConstants.LabelType, (int)mobile.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.LabelType.Delete((int)id);
        }
    }
}
