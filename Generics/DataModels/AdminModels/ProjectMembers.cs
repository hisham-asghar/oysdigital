using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class ProjectMembers:BaseEntity
    {
        public long ProjectMemberTypeId { get; set; }
        [Ignore]
        public string MemberType { get; set; }
        public long ProjectId { get; set; }
        public string AspNetUserId { get; set; }
        [Ignore]
        public string MemberName { get; set; }
        public bool IsActive { get; set; }
    }
}
