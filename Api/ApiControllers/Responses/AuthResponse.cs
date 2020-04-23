using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.ApiControllers.Responses
{
    public class AuthResponse
    {
        public bool Status { get; set; }
    }
    public class AuthFailResponse : AuthResponse
    {
        public IEnumerable<string> Errors { get; set; }
    }
    public class AuthSuccessResponse : AuthResponse
    {
        public string Token { get; set; }
        public string RefreshToken { get; set; }
    }
}
