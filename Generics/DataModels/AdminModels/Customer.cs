using Generics.Common.Attributes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Generics.DataModels.AdminModels
{
    public class Customer:BaseEntity
    {      
        public string Name { get; set; }
        public string Guid { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public bool IsActive { get; set; }
    }
    public class CustomerDetailView
    {
        public Customer customer { get; set; }
        public List<Project> Projects { get; set; }
    }
}
