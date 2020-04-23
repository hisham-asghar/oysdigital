using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class ProjectMembers
    {
        public long ProjectMembersId { get; set; }
        public long ProjectMemberTypesId { get; set; }
        public virtual ProjectMemberTypes ProjectMemberTypes { get; set; }
        public long ProjectId { get; set; }
        public virtual Project Project { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated { get; set; }
        public DateTime OnModified { get; set; }
    }
}
