using Generics.Common.Attributes;
using Generics.DataModels;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.Data
{
    public class ApplicationUser : IdentityUser<string>
    {
        [PersonalData]
        public string Name { get; set; }

        [PersonalData]
        public string ProfilePic { get; set; }


    }
    public class Rolemanager: ApplicationUser
    {
        public string RoleName { get; set; }
    }
}
