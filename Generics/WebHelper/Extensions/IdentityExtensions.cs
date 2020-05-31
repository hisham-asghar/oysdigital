using Generics.Common;
using Generics.DataModels.Constants;
using System;
using System.Security.Claims;

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
        public static bool HaveAnyRole(this ClaimsPrincipal principal)
        {
            if (principal == null) return false;

            return principal.IsInRole(UserRoles.Admin) || principal.IsInRole(UserRoles.Hr) || principal.IsInRole(UserRoles.Designer) || principal.IsInRole(UserRoles.Scheduler);
        }
        public static bool IsDesigner(this ClaimsPrincipal principal)
        {
            if (principal == null) return false;

            return principal.IsInRole(UserRoles.Designer);
        }
        public static bool IsScheduler(this ClaimsPrincipal principal)
        {
            if (principal == null) return false;

            return principal.IsInRole(UserRoles.Scheduler);
        }
        public static bool IsAdminOrHr(this ClaimsPrincipal principal)
        {
            if (principal == null) return false;

            return principal.IsInRole(UserRoles.Admin) || principal.IsInRole(UserRoles.Hr);
        }
    }

}
