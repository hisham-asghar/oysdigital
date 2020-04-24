using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerBao;

namespace LayerDao
{
    public class UserDao
    {
        public class Customers
        {
            public static List<Customer> GetAll()
            {
                return UserBao.CustomerBao.GetAll();
            }
            public static Customer GetById(long id)
            {
                return UserBao.CustomerBao.GetById(id);
            }
            public static bool Insert(Customer c)
            {
                return UserBao.CustomerBao.Insert(c);
            }
            public static bool Update(Customer c)
            {
                return UserBao.CustomerBao.Update(c);
            }
            public static bool Delete(long id)
            {
                return UserBao.CustomerBao.Delete(id);
            }
        }

        public static Customer GetUser(long id)
        {
            return UserBao.CustomerBao.GetById(id);
        }

        //public static bool UpdateUser(AspNetUsers dto)
        //{
        //    return UserBao.UpdateUser(dto);
        //}
    }
}
