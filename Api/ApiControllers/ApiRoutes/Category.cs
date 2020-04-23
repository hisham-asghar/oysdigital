using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.ApiControllers.ApiRoutes
{

    public class Category : Admin.ApiControllers.Routes.Api
    {
        public const string CategoryBase = Base + "/category";
        public const string CategoryByGuid = CategoryBase + "/{guid}";
        public const string GetHomePageView = CategoryBase+"/homepageview";
        public const string CategoryById = CategoryBase + "/{id}";
        public const string ProductByCategoryGuid = CategoryByGuid + "/products";
        public const string ProductByCategoryId = CategoryById + "/products";
    }
}
