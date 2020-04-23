using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public class UserDao
    {
        public static list<Customer> GetAllCustomer(Customer dto)
        {
            return UserDao.GetAllCustomer();
        }

        public static Customer GetUser(string id)
        {
            return UserDao.GetUser(id);
        }

        public static bool UpdateUser(AspNetUsers dto)
        {
            return UserDao.UpdateUser(dto);
        }
    }
}
