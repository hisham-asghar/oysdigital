using Generics.DataModels;
using Generics.DataModels.Enums;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Routing;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Website.Infrastructure.RouteConstraints
{
    public class CategoryRouteConstraint : IRouteConstraint
    {
        public bool Match(HttpContext httpContext, IRouter route, string routeKey, RouteValueDictionary values, RouteDirection routeDirection)
        {
            var val = httpContext.Request.Path.Value;
            if (string.IsNullOrWhiteSpace(val)) return false;
            var records = //LayerBao.CacheService.UrlRecordCache.GetAll(EnityType.Category) ?? 
                new List<UrlRecord>();
            var urls = records.Select(u => u.Slug).ToList();            
            if (val == null || val.Trim().Length <= 1) return false;
            if (val.StartsWith("/")) val = val.Substring(1);
            return urls.Contains(val);

        }
    }
    public class CategoryProductRouteConstraint : IRouteConstraint
    {
        public bool Match(HttpContext httpContext, IRouter route, string routeKey, RouteValueDictionary values, RouteDirection routeDirection)
        {
            var val = httpContext.Request.Path.Value?.ToLower();
            if (string.IsNullOrWhiteSpace(val)) return false;
            var records = //LayerBao.CacheService.UrlRecordCache.GetAll(EnityType.Product) ?? 
                new List<UrlRecord>();
            var urls = records.Select(u => u.Slug).ToList();
            if (val == null || val.Trim().Length <= 1) return false;
            if (val.StartsWith("/")) val = val.Substring(1);
            return urls.Contains(val);
        }
    }
}
