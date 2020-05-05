using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class ProjectAlertMessage:BaseEntity
    {
        public string Message { get; set; }
        public int LabelTypeId { get; set; }
        [Ignore]
        public string LabelName { get; set; }
        [Ignore]
        public string LabelColor { get; set; }
        public long ProjectId { get; set; }
        public bool IsActive { get; set; }
    }
}
