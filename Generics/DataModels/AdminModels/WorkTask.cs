using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.AdminModels
{
    public class WorkTask:BaseEntity
    {
        public long ProjectId { get; set; }
        public long ProjectSchedulingTime { get; set; }
        public bool IsCompleted { get; set; }
        public bool IsDesigned { get; set; }
        public bool IsScheduled { get; set; }
        public DateTime OnReported { get; set; }
        public bool IsReporter { get; set; }
        public string ReportedBy { get; set; }

    }
}
