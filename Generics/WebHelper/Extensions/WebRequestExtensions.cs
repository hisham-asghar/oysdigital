using Generics.Common;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Text;

namespace Generics.WebHelper.Extensions
{
    public static class WebRequestExtensions
    {
        public static string GetPublicPath(this HttpRequest request)
        {
            if (request == null) return null;

            return request.Scheme + "://" + request.Host + request.Path;
        }
        
    }
}
