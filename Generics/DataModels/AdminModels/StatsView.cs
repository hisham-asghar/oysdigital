using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.AdminModels
{
    public class StatsView
    {
        public AspNetUserRoles User { get; set; }
        public StatsModel Stats { get; set; }
    }
}
