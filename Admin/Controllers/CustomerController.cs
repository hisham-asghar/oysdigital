﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Security.Claims;
using Amazon.S3.Encryption.Internal;
using Generics.Common;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.DataModels.Constants;
using Generics.DataModels.Enums;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Admin.Controllers
{
    [Authorize(Roles = UserRoles.Admin+","+UserRoles.Hr)]
    public class CustomerController : Controller
    {
        // GET: /<controller>/
        public IActionResult Index(ProjectFilter status = ProjectFilter.All)
        {
            var customers = CustomerBao.GetAll();
            ViewBag.Status = status;
            var ListCustomer = new List<Customer>();
            foreach (var item in customers)
            {
                if (status == ProjectFilter.Active)
                {
                    if (item.IsActive == true)
                    {
                        ListCustomer.Add(item);
                    }
                }
                if (status == ProjectFilter.InActive)
                {
                    if (item.IsActive == false)
                    {
                        ListCustomer.Add(item);
                    }
                }
                if (status == ProjectFilter.All)
                {
                    ListCustomer = customers;
                }
            }
            return View(ListCustomer);
        }

        [Route("/Customer/Create")]
        [Route("/Customer/Edit/{id}")]
        [HttpGet]
        public IActionResult Create(long id = 0)
        {
            Customer customer = id <= 0 ? new Customer() : CustomerBao.GetById(id);
            if (id > 0 && customer == null)
            {
                // Dont Exist
            }
            ViewBag.IsEdit = id > 0;
            return View(customer);
        }
        [Route("/Customer/Create")]
        [Route("/Customer/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(Customer customer, int id = 0)
        {
            var IsActive = Request.Form.CheckBoxStatus("IsActive");
            customer.IsActive = IsActive;
            Customer customerDb = CustomerBao.GetById(id);
            if (id > 0 && customerDb == null)
            {
                // Not Exists
            }

            var userId = User.GetUserId();

            if (customer == null)
            {
                customerDb = customerDb ?? new Customer();
                ViewBag.IsEdit = id > 0;
                return View(customerDb);
            }
            if (id == 0)
            {
                customer.SetOnCreate(userId);
                customer.Guid = Guid.NewGuid().ToString();
                CustomerBao.Insert(customer);
            }
            else
            {
                customer.OnCreated = customerDb.OnCreated;
                customer.Guid = customerDb.Guid;
                customer.CreatedBy = customerDb.CreatedBy;
                customer.SetOnUpdate(userId);
                CustomerBao.Update(customer);
            }

            return RedirectToAction("Index");

        }
        public IActionResult Delete(long id)
        {
            Customer customer = CustomerBao.GetById(id);
            if (id > 0 && customer == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.CustomerDictionary = Functions.CreateDictionaryFromModel(customer);
            }
            return View(customer);
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
            Customer customer = CustomerBao.GetById(id);
            if (id > 0 && customer == null)
            {
                // Dont Exist
            }
            else
            {
                ViewBag.CustomerDictionary = Functions.CreateDictionaryFromModel(customer);
            }
            return View(customer);
        }
    }
}
