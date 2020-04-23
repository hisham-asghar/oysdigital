using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.ApiControllers.Requests
{
    public static class IdentityRequests
    {
        public class LoginRequest
        {
            public string Password { get; set; }
            public string Nickname { get; set; }
        }
        public class UserRegisterationRequest
        {
            public string Email { get; set; }
            public string Password { get; set; }
            public string FirstName { get; set; }
            public string LastName { get;set;}
            public string PhoneNumber { get;set;}
        }
        public class UserInfoRequest
        {
            public string Id { get; set; }
            public string Name { get; set; }
            public string Country { get; set; }
            public string PhoneNumber { get; set; }
            public string Gender { get; set; }
            public string AboutMe { get; set; }
        }
        public class RefreshTokenRequest
        {
            public string Token { get; set; }
            public string RefreshToken { get; set; }
        }

        public class UpdateUserImagesRequest
        {
            public string userId { get; set; }
            public string fileName { get; set; }
            public string filePath { get; set; }
        }
    }
}
