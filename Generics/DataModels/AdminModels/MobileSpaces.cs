using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class MobileSpaces:BaseEntity
    {
        public long MobileId { get; set; }
        public string Name { get; set; }
        public bool IsActive { get; set; }
    }

}
