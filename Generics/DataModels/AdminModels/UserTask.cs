using Generics.Common.Attributes;
using System;

namespace Generics.DataModels.AdminModels
{
    public class UserTask
    {
        public int ProjectId { get; set; }
        public int WorkTaskId { get; set; }
        public bool IsCompleted { get; set; }
        public bool IsDesigned { get; set; }
        public bool IsScheduled { get; set; }
        public int ProjectMemberTypeId { get; set; }
        public string MemberType { get; set; }
        public string AspNetUserId { get; set; }
        public DateTime ProjectSchedulingTime { get; set; }
        [Ignore]
        public bool IsDone()
        {
            return MemberType != null && ((IsDesigned && MemberType.ToLower() == "designer") || (IsScheduled && MemberType.ToLower() == "scheduler") || (IsCompleted && MemberType.ToLower() == "manager"));
        }
        [Ignore]
        public bool IsPending() => !IsDone();
    }
}
