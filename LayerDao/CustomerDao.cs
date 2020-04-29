using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using System.Collections.Generic;

namespace LayerDao
{
    public class CustomerDao
    {
        public static List<Customer> GetAll()
        {
            return TableConstants.Customer.SelectAll<Customer>();
        }
        public static Customer GetById(long id)
        {
            return TableConstants.Customer.Select<Customer>((int)id);
        }
        public static bool Insert(Customer customer)
        {
            return customer.Insert(TableConstants.Customer) > 0;
        }
        public static bool Update(Customer customer)
        {
            return customer.Update(TableConstants.Customer, (int)customer.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.Customer.Delete((int)id);
        }
    }
}
