using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using Amazon.S3.Encryption.Internal;
using Generics.Data;
using Generics.DataModels.AdminModels;
using LayerBao;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

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
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try
            {

                if (customer.CustomerId == 0)
                {
                    customer.OnCreated = DateTime.Now;
                    customer.Guid = Guid.NewGuid().ToString();
                    customer.CreatedBy = userId;
                    CustomerBao.Insert(customer);
                    return RedirectToAction("Index");
                }
                else
                {
                    customer.OnModified = DateTime.Now;
                    customer.ModifiedBy = userId;
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
                CustomerDetailView detail = new CustomerDetailView();
                var data= CustomerBao.GetById(id);
                detail.customer = data; 
                if (data != null)
                { 
                    var pro = ProjectBao.GetByCustomerId(data.CustomerId);
                    foreach(var item in pro)
                    {
                        item.ProjectPlatforms = ProjectPlatformsBao.GetByProjectId(item.ProjectId);
                        item.ProjectMembers = ProjectMembersBao.GetByProjectId(item.ProjectId);
                        item.MobileSpaces = null;
                    }
                    detail.Projects = pro;
                }
                return View(detail);
            }
            return View();
        }
    }
}
