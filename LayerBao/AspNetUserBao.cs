using System;
using System.Collections.Generic;
using System.Text;
using Generics.Data;
using LayerDao;

namespace LayerBao
{
    public class AspNetUserBao
    {
        public static List<ApplicationUser> GetAll()
        {
            return AspNetUserDao.GetAll();
        }
        public static ApplicationUser GetById(string id)
        {
            return AspNetUserDao.GetById(id);
        }
        public static bool Insert(ApplicationUser applicationUser)
        {
            return AspNetUserDao.Insert(applicationUser);
        }
        public static bool Update(ApplicationUser applicationUser)
        {
            return AspNetUserDao.Update(applicationUser);
        }
        public static bool Delete(string id)
        {
            return AspNetUserDao.Delete(id);
        }
    }
}
