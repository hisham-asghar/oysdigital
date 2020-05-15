using Generics.DataModels.AdminModels;
using LayerDao;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerBao
{
    public class AspNetRolesBao
    {
        public static List<AspNetRoles> GetAll()
        {
            return AspNetRolesDao.GetAll();
        }
        public static AspNetRoles GetById(string id)
        {
            return AspNetRolesDao.GetById(id);
        }
        public static bool Insert(AspNetRoles aspNetRoles)
        {
            return AspNetRolesDao.Insert(aspNetRoles);
        }
        public static bool Update(AspNetRoles aspNetRoles)
        {
            return AspNetRolesDao.Update(aspNetRoles);
        }
        public static bool Delete(string id)
        {
            return AspNetRolesDao.Delete(id);
        }
    }
}
