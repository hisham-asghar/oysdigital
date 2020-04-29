using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class ProjectMembers:BaseEntity
    {
        public long ProjectMemberTypeId { get; set; }
        public long ProjectId { get; set; }
        public bool IsActive { get; set; }
    }
}
