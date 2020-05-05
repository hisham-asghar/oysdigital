using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class ProjectTaskScheduling
    {
        [DbGenerated]
        public long Id { get; set; }
        public long ProjectTaskId { get; set; }
        public DateTime Time { get; set; }
    }
}
