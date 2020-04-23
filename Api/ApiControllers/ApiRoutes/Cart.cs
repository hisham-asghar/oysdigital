using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.ApiControllers.ApiRoutes
{
    public class Cart : Admin.ApiControllers.Routes.Api
    {
        public const string CartBase = Base + "/cart";
        public const string CartByCustomerId = CartBase;
        public const string AddItemsToCart = CartBase+"/{productId}/{shoppingCartTypeId}/{quantity}";  
        public const string UpdateCart = CartBase + "/updateCart/{cartItemId}/{quantity}/{shoppingCartTypeId}/{productId}";
        public const string DeleteCart = CartBase+ "/deleteItem" + "/{cartItemId}";
 
    }
}
