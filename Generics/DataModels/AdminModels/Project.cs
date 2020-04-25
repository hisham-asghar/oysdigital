﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class Project
    {
       
        public long ProjectId { get; set; }
        public string Guid { get; set; }
        public string ProjectName { get; set; }
        public long CustomerId { get; set; }
        public string CustomerName { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated { get; set; }
        public DateTime OnModified { get; set; }
    }
}
