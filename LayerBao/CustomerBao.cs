using Generics.DataModels.AdminModels;
using LayerDao;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerBao
{
    public class CustomerBao
    {
        public static List<Customer> GetAll()
        {
            return CustomerDao.GetAll();
        }
        public static Customer GetById(long id)
        {
            return CustomerDao.GetById(id);
        }
        public static bool Insert(Customer c)
        {
            return CustomerDao.Insert(c);
        }
        public static bool Update(Customer c)
        {
            return CustomerDao.Update(c);
        }
        public static bool Delete(long id)
        {
            return CustomerDao.Delete(id);
        }
    }
}
