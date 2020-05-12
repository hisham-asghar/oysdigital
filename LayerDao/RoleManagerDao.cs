using System;
using System.Collections.Generic;
using System.Text;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class RoleManagerDao
    {
        public static List<ApplicationUser> GetUsersByRoleName(string roleName)
        {
            if(roleName==null)
            {
                return null;
            }
            return ViewConstants.UserRoleView.SelectList<ApplicationUser>($"NormalizedRoleName = '{roleName.ToUpper()}'");
        }
        public static AspNetRoles GetById(long id)
        {
            return TableConstants.AspNetRoles.Select<AspNetRoles>((int)id);
        }
        public static bool Insert(AspNetRoles platform)
        {
            return platform.Insert(TableConstants.AspNetRoles) > 0;
        }
        //public static bool Update(AspNetRoles platform)
        //{
        //    return platform.Update(TableConstants.AspNetRoles, platform.Id) > 0;
        //}
        public static bool Delete(long id)
        {
            return TableConstants.AspNetRoles.Delete((int)id);
        }
    }
}
