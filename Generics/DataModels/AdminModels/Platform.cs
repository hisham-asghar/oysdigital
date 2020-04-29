using Generics.Common.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class Platform:BaseEntity
    {        
        public string Name { get; set; }
        public string IconUrl { get; set; }
        public bool IsActive { get; set; }
    }
}
