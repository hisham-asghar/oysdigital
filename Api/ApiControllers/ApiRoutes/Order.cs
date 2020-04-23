using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.ApiControllers.ApiRoutes
{
    public class Order : Admin.ApiControllers.Routes.Api
    {
        public const string BaseIdentity = Base + "/order";
        public const string GetCustomerOrder = BaseIdentity;
        public const string GetOrderById = BaseIdentity + "/{orderId}";
        public const string CreateOrderByShippingCart = BaseIdentity;
        

    }
}
