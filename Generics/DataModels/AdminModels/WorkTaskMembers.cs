using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.AdminModels
{
    public class WorkTaskMembers:BaseEntity
    {
        public string AspNetUserId { get; set; }
        public long WorkTaskId { get; set; }
        public long MemberTypeId { get; set; }
        public bool IsActive { get; set; }
    }
}
