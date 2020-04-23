using Generics.Common;
using Generics.DataModels;
using Generics.DataModels.Enums;
using Generics.Services.DatabaseService.AdoNet;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Job
{
    class Program
    {
        static void Main(string[] args)
        {
            //List<KeyValuePair<string, string>> form = new List<KeyValuePair<string, string>>();

            //form.Add(new KeyValuePair<string, string>("1", "12"));

            //FormCollection formCollection = new FormCollection(null);
            //formCollection.Append(new System.Collections.Generic.KeyValuePair<string, Microsoft.Extensions.Primitives.StringValues>("12", "12"));
            //Console.WriteLine(Newtonsoft.Json.JsonConvert.SerializeObject(form));
            Constants.ConnectionString = "data source=DESKTOP-NEUCL48;initial catalog=Nop;user id=sa;password=123;MultipleActiveResultSets=True";
            //var orderItem = new OrderItem()
            //{
            //    ProductId = 1,
            //    OrderItemGuid = Guid.NewGuid().ToString(),
            //    OrderId = 9,
            //    Quantity = 10,
            //    AttributeDescription = string.Empty,
            //    AttributesXml = string.Empty,
            //    DiscountAmountExclTax = decimal.Zero,
            //    DiscountAmountInclTax = decimal.Zero,
            //    DownloadCount = 0,
            //    IsDownloadActivated = false,
            //    OriginalProductCost = 100,
            //    PriceInclTax = 100,
            //    PriceExclTax = 100,
            //    UnitPriceExclTax = 100,
            //    UnitPriceInclTax = 100,
            //    LicenseDownloadId = "0"

            //};
            //LayerDao.OrdersDao.InsertOrderItem(orderItem);   


         
        }
    }
}
