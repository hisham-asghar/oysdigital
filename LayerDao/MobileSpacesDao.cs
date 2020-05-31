using Generics.Common;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;
using System.Linq;

namespace LayerDao
{
    public class MobileSpacesDao
    {
        public static List<MobileSpaces> GetAll()
        {
            var spaces = TableConstants.MobileSpaces.SelectAll<MobileSpaces>();
            var mobiles = (TableConstants.Mobile.SelectAll<Mobile>() ?? new List<Mobile>()).ToDictionary(k => k.Id, v => v);
            spaces.ForEach(s =>
            {
                s.Mobile = mobiles.Get(s.MobileId);
                s.DetailedName = s.Mobile == null ? s.Name : s.Mobile.Name + " - " + s.Name;
            });
            return spaces;
        }
        public static MobileSpaces GetById(long id)
        {
            var space = TableConstants.MobileSpaces.Select<MobileSpaces>((int)id);
            if (space == null) return null;
            var mobile = MobileDao.GetById(space.Id);
            space.Mobile = mobile;
            space.DetailedName = space.Mobile == null ? space.Name : space.Mobile.Name + " - " + space.Name;
            return space;
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
