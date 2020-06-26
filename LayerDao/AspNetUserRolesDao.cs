using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;

namespace LayerDao
{
    public static class AspNetUserRolesDao
    {
        public static List<AspNetUserRoles> GetAll()
        {
            return ViewConstants.USER_ROLE_VIEW.SelectAll<AspNetUserRoles>();
            var query = $"SELECT distinct AspNetUserRoles.UserId, AspNetUsers.NormalizedEmail as Email, AspNetUsers.Name as UserName  FROM [dbo].[AspNetUserRoles] INNER JOIN AspNetUsers ON AspNetUsers.Id = AspNetUserRoles.UserId;";
            return QueryExecutor.List<AspNetUserRoles>(query);
        }

        public static List<AspNetUserRoles> GetByUserId(string id)
        {
            return ViewConstants.USER_ROLE_VIEW.SelectList<AspNetUserRoles>($" Id = '{id}'");
            var query = $"SELECT AspNetUserRoles.RoleId,AspNetUserRoles.UserId, AspNetUsers.NormalizedEmail as Email, AspNetUsers.Name as UserName ,AspNetRoles.NormalizedName as RoleName FROM [dbo].[AspNetUserRoles] INNER JOIN AspNetRoles ON AspNetRoles.Id = AspNetUserRoles.RoleId INNER JOIN AspNetUsers ON AspNetUsers.Id = AspNetUserRoles.UserId WHERE AspNetUserRoles.UserId='{id}';";
            return QueryExecutor.List<AspNetUserRoles>(query);
        }
        public static bool Insert(AspNetUserRoles aspNetUserRoles)
        {
            return aspNetUserRoles.Insert(TableConstants.AspNetUserRoles) > 0;
        }
        public static bool Update(AspNetUserRoles aspNetUserRoles)
        {
            var query = $"UPDATE [dbo].[AspNetUserRoles] SET [UserId] = '{aspNetUserRoles.UserId}', [RoleId] = '{aspNetUserRoles.RoleId}' OUTPUT INSERTED.UserId AS Result WHERE UserId = '{aspNetUserRoles.UserId}'";
            return QueryExecutor.FirstOrDefault<int>(query) > 0;
        }
        public static bool Delete(string userId)
        {
            var query = $"DELETE FROM dbo.AspNetUserRoles where UserId='{userId}';";
            return QueryExecutor.FirstOrDefault<bool>(query);
        }
        public static AspNetUserRoles IsExist(string userId, string roleId)
        {
            var query = $"SELECT * FROM dbo.AspNetUserRoles where UserId='{userId}' AND RoleId='{roleId}';";
            return QueryExecutor.FirstOrDefault<AspNetUserRoles>(query);
        }
    }
}
