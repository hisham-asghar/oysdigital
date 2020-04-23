using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.WebHelper.Attributes
{
    //public class CustomAuthorizeAttribute : FilterAttribute { }
    public class UserAuthorizeAttribute : IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationFilterContext filterContext)
        {
            //context.HttpContext.User.Identity.IsAuthenticated;
            //if (!filterContext.HttpContext.User.Identity.IsAuthenticated)
            //{
            //    // The user is not authenticated
            //    super.(filterContext);
            //}
        }
        //protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        //{
        //    if (filterContext.HttpContext.User.Identity.IsAuthenticated)
        //    {
        //        filterContext.Result = new HttpStatusCodeResult(HttpStatusCode.Forbidden);
        //    }
        //    else
        //    {
        //        base.HandleUnauthorizedRequest(filterContext);
        //    }
        //}
    }
}
