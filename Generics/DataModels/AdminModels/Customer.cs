using System;

namespace Generics.DataModels.AdminModels
{
    public class Customer
    {      
        public long CustomerId { get; set; }
        public string Name { get; set; }
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
}
