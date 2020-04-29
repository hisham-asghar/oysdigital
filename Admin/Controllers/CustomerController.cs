using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Amazon.S3.Encryption.Internal;
using Generics.Data;
using Generics.DataModels.AdminModels;
using Generics.WebHelper.Extensions;
using LayerBao;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Admin.Controllers
{
    public class CustomerController : Controller
    {
        // GET: /<controller>/
        public IActionResult Index()
        {
            var customers = CustomerBao.GetAll();
            return View(customers);
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
            ViewBag.IsSave = id > 0;
            return View(customer);
        }
        [Route("/Customer/Create")]
        [Route("/Customer/Edit/{id}")]
        [HttpPost]
        public IActionResult Create(Customer customer, int id = 0)
        {
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
                if (CustomerBao.Insert(customer))
                {
                    //return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.IsSave = false;
                    return View(customer);
                }
            }
            else
            {
                customer.SetOnUpdate(userId);
                CustomerBao.Update(customer);
            }

            return RedirectToAction("Index");

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
                CustomerDetailView detail = new CustomerDetailView();
                var data= CustomerBao.GetById(id);
                detail.customer = data; 
                if (data != null)
                { 
                    //var pro = ProjectBao.GetByCustomerId(data.Id);
                    //if (pro != null)
                    //{
                    //    foreach (var item in pro)
                    //    {
                    //        item.ProjectPlatforms = ProjectPlatformsBao.GetByProjectId(item.ProjectId);
                    //        item.ProjectMembers = ProjectMembersBao.GetByProjectId(item.ProjectId);
                    //    }
                    //}
                    //detail.Projects = pro;
                }
                return View(detail);
            }
            return View();
        }
    }
}
