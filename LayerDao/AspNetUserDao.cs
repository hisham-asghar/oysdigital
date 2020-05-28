using System;
using System.Collections.Generic;
using System.Text;
using Generics.Data;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

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
            return TableConstants.AspNetUsers.Select<ApplicationUser>(id);
        }
        public static bool Insert(ApplicationUser applicationUser)
        {
            return applicationUser.Insert(TableConstants.AspNetUsers) > 0;
        }
        public static bool Update(ApplicationUser applicationUser)
        {
            return applicationUser.Update(TableConstants.AspNetUsers, applicationUser.Id) > 0;
        }
        public static bool Delete(string id)
        {
            return TableConstants.AspNetUsers.Delete(id);
        }
    }
}
