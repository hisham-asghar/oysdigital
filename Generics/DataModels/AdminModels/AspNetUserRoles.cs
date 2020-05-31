using Generics.Common.Attributes;
using System.Collections.Generic;

namespace Generics.DataModels.AdminModels
{
    public class AspNetUserRoles
    {
        [Ignore]
        public string Id { get; set; }
        public string UserId { get; set; }
        public string RoleId { get; set; }
        [Ignore]
        public string Name { get; set; }
        [Ignore]
        public string UserName { get; set; }
        [Ignore]
        public string Email { get; set; }
        [Ignore]
        public string RoleName { get; set; }
        [Ignore]
        public List<string> Roles { get; set; }
        [Ignore]
        public List<string> NormalizedRoles { get; set; }
    }
}
