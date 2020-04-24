using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.AdminModels;
using LayerDao;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Admin.Controllers
{
    public class CustomerController : Controller
    {
        // GET: /<controller>/
        public IActionResult Index()
        {           
            return View(UserDao.Customers.GetAll());
        }
        
        //public IActionResult Create()
        //{
        //    Customer c = new Customer();
        //    c.Name = "";c.PhoneNumber = "";c.CustomerId = 0;c.Email = "";c.Address = "";
        //    return View(c);
        //}
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = UserDao.Customers.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                Customer c = new Customer();
                c.Name = ""; c.PhoneNumber = ""; c.CustomerId = 0; c.Email = ""; c.Address = "";
                return View(c);
            }
            return View();
        }
        [HttpPost]
        public IActionResult Create(Customer customer)
        {
            try
            {

                if (customer.CustomerId == 0)
                {
                    customer.OnCreated = DateTime.Now;
                    customer.Guid = Guid.NewGuid().ToString();
                    UserDao.Customers.Insert(customer);
                    return RedirectToAction("Index");
                }
                else
                {
                    customer.OnModified = DateTime.Now;
                    UserDao.Customers.Update(customer);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

            }
            return View(customer);
        }

        public IActionResult Delete(long id)
        {
            if (id != 0)
            {
                return View(UserDao.Customers.GetById(id));
            }
            return View();
        }
      
        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                UserDao.Customers.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail()
        {
            return View();
        }
    }
}
