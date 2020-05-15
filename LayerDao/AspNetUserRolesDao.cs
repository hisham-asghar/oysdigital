using System;
using System.Collections.Generic;
using System.Text;
using Generics.Data;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using Microsoft.AspNetCore.Identity;

namespace LayerDao
{
    public static class AspNetUserRolesDao
    {
        public static List<AspNetUserRoles> GetAll()
        {
            var query = $"SELECT distinct AspNetUserRoles.UserId, AspNetUsers.NormalizedEmail as Email, AspNetUsers.Name as UserName  FROM [dbo].[AspNetUserRoles] INNER JOIN AspNetUsers ON AspNetUsers.Id = AspNetUserRoles.UserId;";
            return QueryExecutor.List<AspNetUserRoles>(query);
        }

        public static List<AspNetUserRoles> GetByUserId(string id)
        {
            var query = $"SELECT AspNetUserRoles.RoleId,AspNetUserRoles.UserId, AspNetUsers.NormalizedEmail as Email, AspNetUsers.Name as UserName ,AspNetRoles.NormalizedName as RoleName FROM [dbo].[AspNetUserRoles] INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId INNER JOIN AspNetUsers ON AspNetUsers.Id = AspNetUserRoles.UserId WHERE AspNetUserRoles.UserId='{id}';";
            return QueryExecutor.List<AspNetUserRoles>(query);
        }
        public static bool Insert(AspNetUserRoles aspNetUserRoles)
        {
            return aspNetUserRoles.Insert(TableConstants.AspNetUserRoles) > 0;
        }
        public static bool Update(AspNetUserRoles aspNetUserRoles)
        {
            return aspNetUserRoles.Update(TableConstants.AspNetUserRoles, aspNetUserRoles.UserId) > 0;
        }
        public static bool Delete(string userId)
        {
            var query = $"DELETE FROM AspNetUserRoles where UserId='{userId}';";
            return QueryExecutor.FirstOrDefault<bool>(query);
        }
        public static AspNetUserRoles IsExist(string userId,string roleId)
        {
            var query = $"SELECT * FROM AspNetUserRoles where UserId='{userId}' AND RoleId='{roleId}';";
            return QueryExecutor.FirstOrDefault<AspNetUserRoles>(query);
        }
    }
}
