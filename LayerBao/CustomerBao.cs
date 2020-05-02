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
            var customer = CustomerDao.GetById(id);
            if (customer != null) customer.Projects = ProjectDao.GetByCustomerId(id);
            return customer;
        }
        public static bool Insert(Customer customer)
        {
            return CustomerDao.Insert(customer);
        }
        public static bool Update(Customer customer)
        {
            return CustomerDao.Update(customer);
        }
        public static bool Delete(long id)
        {
            return CustomerDao.Delete(id);
        }
    }
}
