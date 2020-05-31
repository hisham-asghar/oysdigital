namespace Generics.DataModels.AdminModels
{
    public class WorkTaskMembers : BaseEntity
    {
        public string AspNetUserId { get; set; }
        public long WorkTaskId { get; set; }
        public long MemberTypeId { get; set; }
        public bool IsActive { get; set; }
    }
    public class WorkTaskMemberCompact
    {
        public string UserId { get; set; }
        public long WorkTaskId { get; set; }
        public string MemberType { get; set; }
    }
}
