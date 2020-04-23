using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.ApiControllers.Routes
{
    public partial class Api
    {
        public class Identity
        {
            public const string IdentityBase = Base + "/identity";

            public const string Login = IdentityBase + "/login";
            public const string LoginWithP = IdentityBase + "/loginphonenumber";
            public const string twofactor = IdentityBase + "/twofactor";
            public const string Register = IdentityBase + "/register";
            public const string Refresh = IdentityBase + "/refresh";
        }
    }
}
