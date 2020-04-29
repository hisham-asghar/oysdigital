using Generics.Common.Attributes;
using System;
using System.Collections.Generic;
using System.Text;

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
            OnCreated = DateTime.Now;
            OnModified = DateTime.Now;
        }
        public void SetOnUpdate(string userId)
        {
            ModifiedBy = userId;
            OnModified = DateTime.Now;
        }
    }
}
