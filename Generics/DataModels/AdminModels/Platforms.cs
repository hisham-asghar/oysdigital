using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class Platforms
    {
        
        public long PlatformId { get; set; }
        public string Name { get; set; }
        public string IconUrl { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated { get; set; }
        public DateTime OnModified { get; set; }
    }
}
