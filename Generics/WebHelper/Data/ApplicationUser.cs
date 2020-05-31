using Microsoft.AspNetCore.Identity;

namespace Generics.Data
{
    public class ApplicationUser : IdentityUser<string>
    {
        [PersonalData]
        public string Name { get; set; }

        [PersonalData]
        public string ProfilePic { get; set; }


    }
    public class Rolemanager : ApplicationUser
    {
        public string RoleName { get; set; }
    }
}
