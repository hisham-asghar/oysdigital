using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class PlatformDao
    {
        public static List<Platform> GetAll()
        {
            return TableConstants.Platform.SelectAll<Platform>();
        }
        public static Platform GetById(long id)
        {
            return TableConstants.Platform.Select<Platform>((int)id);
        }
        public static bool Insert(Platform platform)
        {
            return platform.Insert(TableConstants.Platform) > 0;
        }
        public static bool Update(Platform platform)
        {
            return platform.Update(TableConstants.Platform, (int)platform.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.Platform.Delete((int)id);
        }
    }
}
