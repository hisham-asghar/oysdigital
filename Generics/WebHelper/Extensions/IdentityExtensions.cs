using Generics.Common;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Text;

namespace Generics.WebHelper.Extensions
{
    public static class ClaimsPrincipalExtensions
    {
        public static string GetUserId(this ClaimsPrincipal principal)
        {
            if (principal == null)
                throw new ArgumentNullException(nameof(principal));

            return principal.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        }
        public static int GetCustomerId(this ClaimsPrincipal principal)
        {
            if (principal == null)
                throw new ArgumentNullException(nameof(principal));

            var id = principal.FindFirst(u => u.Type == "CustomerId")?.Value;
            return id.ToInt();
        }
        public static string GetName(this ClaimsPrincipal principal)
        {
            if (principal == null)
                throw new ArgumentNullException(nameof(principal));

            return principal.FindFirst(u => u.Type == "Name")?.Value;
        }
    }
}
