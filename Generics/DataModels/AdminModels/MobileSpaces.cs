using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class MobileSpaces : BaseEntity
    {
        public long MobileId { get; set; }
        public string Name { get; set; }
        public bool IsActive { get; set; }
        [Ignore]
        public Mobile Mobile { get; set; }
        [Ignore]
        public string DetailedName { get; set; }
    }

}
