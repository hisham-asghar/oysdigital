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
        public string ProjectMemberTypeName { get; set; }
        public long ProjectId { get; set; }
        public string ProjectName { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated { get; set; }
        public DateTime OnModified { get; set; }
    }
}
