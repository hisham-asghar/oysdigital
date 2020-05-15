using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Generics.Data;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public static class AspNetUserRolesBao
    {
        public static List<AspNetUserRoles> GetAll()
        {
            var data= AspNetUserRolesDao.GetAll();
            
            if (data.Count > 0)
            {
                foreach(var item in data)
                {
                    var list = new List<AspNetUserRoles>();
                    list.AddRange(AspNetUserRolesDao.GetByUserId(item.UserId));
                    item.Roles = list.Select(s=>s.RoleName).ToList();
                }
                
            }
            return data;
        }
        public static AspNetUserRoles GetByUserId(string id)
        {
            var data = AspNetUserRolesDao.GetByUserId(id);
            if (data.Count > 0)
            {
                foreach (var item in data)
                {
                    var list = new List<AspNetUserRoles>();
                    list.AddRange(AspNetUserRolesDao.GetByUserId(item.UserId));
                    item.Roles = list.Select(s => s.RoleName).ToList();
                    break;
                }

            }
            return data.FirstOrDefault();
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
        public static AspNetUserRoles IsExist(string userId,string roleId)
        {
            return AspNetUserRolesDao.IsExist(userId,roleId);
        }
    }
}
