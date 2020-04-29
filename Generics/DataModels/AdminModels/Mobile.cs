using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class Mobile : BaseEntity
    {       
        public long MobileId { get; set; }
        public string MobileName { get; set; }
        public bool IsActive { get; set; }
    }
}
