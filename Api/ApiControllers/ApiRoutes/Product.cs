using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.ApiControllers.ApiRoutes
{
    public class Product: Admin.ApiControllers.Routes.Api
    {
        public const string BaseIdentity = Base+"/products";
        
        public const string GetProductById = BaseIdentity + "/{id}";
    }
}
