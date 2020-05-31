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
            return ViewConstants.USER_ROLE_VIEW.SelectList<ApplicationUser>($"NormalizedRoleName = '{roleName.ToUpper()}'");
        }

        public static List<ApplicationUser> GetAll()
        {
            return TableConstants.AspNetUsers.SelectAll<ApplicationUser>();
        }

        public static Rolemanager GetUserById(string userId)
        {
            var query = $"SELECT AspNetUsers.*, AspNetRoles.NormalizedName as RoleName FROM AspNetUserRoles INNER JOIN AspNetUsers ON AspNetUsers.Id = AspNetUserRoles.UserId INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId WHERE AspNetUsers.Id = '{userId}';";
            return QueryExecutor.FirstOrDefault<Rolemanager>(query);
        }
    }
}
