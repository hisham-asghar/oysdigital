using System;
using System.Collections.Generic;
using System.Text;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class AspNetUserRoles
    {
        public string UserId { get; set; }
        public string RoleId { get; set; }
        [Ignore]
        public string UserName { get; set; }
        [Ignore]
        public string Email { get; set; }
        [Ignore]
        public string RoleName { get; set; }
        [Ignore]
        public List<string> Roles { get; set; }
    }
}
