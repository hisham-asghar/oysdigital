using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class WorkTask:BaseEntity
    {
        public long ProjectId { get; set; }
        [Ignore]
        public string  ProjectName { get; set; }
        public DateTime ProjectSchedulingTime { get; set; }
        public bool IsCompleted { get; set; }
        public bool IsDesigned { get; set; }
        public bool IsScheduled { get; set; }
        public DateTime OnReported { get; set; }
        public bool IsReported { get; set; }
        public string ReportedBy { get; set; }
        public List<WorkTaskPlatforms> WorkTaskPlatforms { get; set; }
    }
}
