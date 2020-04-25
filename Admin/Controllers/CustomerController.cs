﻿using System;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Admin.Controllers
{
    public class CustomerController : Controller
    {
        // GET: /<controller>/
        public IActionResult Index()
        {           
            return View(CustomerBao.GetAll());
        }
        [HttpGet]
        public IActionResult Create(long Id)
        {
            if (Id != 0)
            {
                var data = CustomerBao.GetById(Id);
                if (data != null)
                {
                    return View(data);
                }

            }
            else
            {
                Customer c =new Customer();
                c.CustomerName = ""; c.PhoneNumber = ""; c.CustomerId = 0; c.Email = ""; c.Address = "";
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
                    CustomerBao.Insert(customer);
                    return RedirectToAction("Index");
                }
                else
                {
                    customer.OnModified = DateTime.Now;
                    CustomerBao.Update(customer);
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
                return View(CustomerBao.GetById(id));
            }
            return View();
        }
      
        public IActionResult ConfirmDelete(long id)
        {
            if (id != 0)
            {
                CustomerBao.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public IActionResult Detail(long id)
        {
            if (id != 0)
            {
                return View(CustomerBao.GetById(id));
            }
            return View();
        }
    }
}
