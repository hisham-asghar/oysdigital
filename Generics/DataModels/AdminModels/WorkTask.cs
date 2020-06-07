using Generics.Common.Attributes;
using System;
using System.Collections.Generic;

namespace Generics.DataModels.AdminModels
{
    public class WorkTask : BaseEntity
    {
        public long ProjectId { get; set; }
        [Ignore]
        public string ProjectName { get; set; }
        public DateTime ProjectSchedulingTime { get; set; }
        public bool IsCompleted { get; set; }
        public bool IsDesigned { get; set; }
        public bool IsScheduled { get; set; }
        public DateTime OnReported { get; set; }
        public bool IsReported { get; set; }
        public string ReportedBy { get; set; }
        public List<WorkTaskPlatforms> WorkTaskPlatforms { get; set; }

        [Ignore]
        public string DesignerName { get; set; }
        [Ignore]
        public string SchedulerName { get; set; }


        [Ignore]
        public string MemberType { get; set; }

        [Ignore]
        public bool IsDone()
        {
            return MemberType != null && ((IsDesigned && MemberType.ToLower() == "designer") || (IsScheduled && MemberType.ToLower() == "scheduler") || (IsCompleted && MemberType.ToLower() == "manager"));
        }
        [Ignore]
        public bool IsPending() => !IsDone();
    }

    public class GenertableTaskCount
    {
        public string Date { get; set; }
        public int TaskCount { get; set; }
    }
}
