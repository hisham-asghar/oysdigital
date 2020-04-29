using Generics.Common.Attributes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Generics.DataModels.AdminModels
{
    public class Customer
    {      
        [DbGenerated]
        public long CustomerId { get; set; }
        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 6)]
        [DataType(DataType.Text)]
        public string CustomerName { get; set; }
        public string Guid { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated  { get; set; }
        public DateTime OnModified { get; set; }
    }
    public class CustomerDetailView
    {
        public Customer customer { get; set; }
        public List<Project> Projects { get; set; }
    }
}
