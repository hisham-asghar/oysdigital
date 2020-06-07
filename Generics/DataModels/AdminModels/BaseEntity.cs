using Generics.Common;
using Generics.Common.Attributes;
using System;

namespace Generics.DataModels.AdminModels
{
    public class BaseEntity
    {
        [DbGenerated]
        public long Id { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated { get; set; }
        public DateTime OnModified { get; set; }

        public void SetOnCreate(string userId)
        {
            CreatedBy = userId;
            ModifiedBy = userId;
            OnCreated = DataConstants.LocalNow;
            OnModified = DataConstants.LocalNow;
        }
        public void SetOnUpdate(string userId)
        {
            ModifiedBy = userId;
            OnModified = DataConstants.LocalNow;
        }
    }
}
