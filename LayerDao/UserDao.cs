using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerBao;

namespace LayerDao
{
    public class UserDao
    {
        public partial class Customers
        {
            public static List<Customer> GetAll()
            {
                return UserBao.CustomerBao.GetAll();
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
