using System;
using System.Collections.Generic;
using System.Text;
using Generics.Data;
using LayerDao;

namespace LayerBao
{
    public static class RoleManagerBao
    {
        public static List<ApplicationUser> GetUsersByRoleName(string roleName)
        {
            return RoleManagerDao.GetUsersByRoleName(roleName);
        }
        public static Rolemanager GetUserById(string userId)
        {
            return RoleManagerDao.GetUserById(userId);
        }
        public static List<ApplicationUser> GetAll()
        {
            return RoleManagerDao.GetAll();
        }
    }
}
