using Generics.DataModels.AdminModels;
using LayerDao;
using System.Collections.Generic;
using System.Linq;

namespace LayerBao
{
    public static class AspNetUserRolesBao
    {
        public static List<AspNetUserRoles> GetAll()
        {
            var data = AspNetUserRolesDao.GetAll();

            if (data.Count > 0)
            {
                var grouped = data.GroupBy(g => g.Id).ToDictionary(k => k.Key, v => v.ToList());
                var list = new List<AspNetUserRoles>();
                foreach (var item in grouped)
                {
                    var user = item.Value.FirstOrDefault();
                    user.UserId = user.Id;
                    user.Roles = item.Value.Select(u => u.RoleName).ToList();
                    user.NormalizedRoles = item.Value.Select(u => u.RoleName.ToUpper()).ToList();
                    list.Add(user);
                }
                return list;
            }
            return data;
        }
        public static AspNetUserRoles GetByUserId(string id)
        {
            var data = AspNetUserRolesDao.GetByUserId(id);
            if (data.Count > 0)
            {
                var grouped = data.GroupBy(g => g.Id).ToDictionary(k => k.Key, v => v.ToList());
                var list = new List<AspNetUserRoles>();
                foreach (var item in grouped)
                {
                    var user = item.Value.FirstOrDefault();
                    user.UserId = user.Id;
                    user.Roles = item.Value.Select(u => u.RoleName).ToList();
                    user.NormalizedRoles = item.Value.Select(u => u.RoleName.ToUpper()).ToList();
                    list.Add(user);
                }
            }
            return data.FirstOrDefault();
        }
        public static List<string> GetRoleIdsByUserId(string id)
        {
            var data = AspNetUserRolesDao.GetByUserId(id) ?? new List<AspNetUserRoles>();
            return data.Select(d => d.RoleId).ToList();
        }
        public static bool Insert(AspNetUserRoles aspNetUserRoles)
        {
            return AspNetUserRolesDao.Insert(aspNetUserRoles);
        }
        public static bool Update(AspNetUserRoles aspNetUserRoles)
        {
            return AspNetUserRolesDao.Update(aspNetUserRoles);
        }
        public static bool Delete(string id)
        {
            return AspNetUserRolesDao.Delete(id);
        }
        public static AspNetUserRoles IsExist(string userId, string roleId)
        {
            return AspNetUserRolesDao.IsExist(userId, roleId);
        }
    }
}
