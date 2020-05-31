using Generics.Data;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;

namespace LayerDao
{
    public class AspNetUserDao
    {
        public static List<ApplicationUser> GetAll()
        {
            return TableConstants.AspNetUsers.SelectAll<ApplicationUser>();
        }
        public static ApplicationUser GetById(string id)
        {
            return TableConstants.AspNetUsers.Select<ApplicationUser>($" Id = '{id}'");
        }
        public static bool Insert(ApplicationUser applicationUser)
        {
            return applicationUser.InsertWithExtraIgnore(TableConstants.AspNetUsers, new List<string>() { "Id" }) > 0;
        }
        public static bool Update(ApplicationUser applicationUser)
        {
            return applicationUser.UpdateWithExtraIgnore(TableConstants.AspNetUsers, applicationUser.Id, new List<string>() { "Id" }) != null;
        }
        public static bool Delete(string id)
        {
            return TableConstants.AspNetUsers.Delete(id);
        }
    }
}
