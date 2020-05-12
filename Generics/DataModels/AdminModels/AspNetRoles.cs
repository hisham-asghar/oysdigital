using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity;

namespace Generics.DataModels.AdminModels
{
    public class AspNetRoles
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string NormalizedName { get; set; }
        public string ConcurrencyStamp { get; set; }
    }
    //public static AspNetRoles Parser(IdentityRole role)
    //{
    //    return AspNetRoles(new=>
    //    {
    //        Name = role.Name,
    //        NormalizedName = role.NormalizedName,
    //        Id = role.Id,
    //        ConcurrencyStamp = role.ConcurrencyStamp
    //    }
    //}
}
