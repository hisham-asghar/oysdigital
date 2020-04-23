using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.ApiControllers.ApiRoutes
{
    public class Customer : Admin.ApiControllers.Routes.Api
    {
        public const string BaseIdentity = Base + "/customer";
        public const string GetAllCustomers = BaseIdentity;
        public const string GetCustomerByIdOrGuid = BaseIdentity + "/{customerId}";
        public const string UpdateCustomerPassword = BaseIdentity + "/password/{password}";
        public const string GetAddressByAddressId = BaseIdentity + "/address";
        public const string CreateAddress = BaseIdentity + "/address/{addressType}";
        public const string EditAddress = BaseIdentity + "/address/edit/{addressType}";
        public const string GetAddressbyAddressType = BaseIdentity + "/addresstype/{addressType}";
    }
}
