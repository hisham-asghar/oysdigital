using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.EntityFrameworkCore;
using Website.Data;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Generics.Configurations.Installer;
using Website.Infrastructure.RouteConstraints;

namespace Website
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.InstallServicesInAssembly(Configuration, Generics.DataModels.Enums.ProjectType.Website);



            //services.AddDbContext<ApplicationDbContext>(options =>
            //    options.UseSqlServer(
            //        Configuration.GetConnectionString("DefaultConnection")));
            //services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            //    .AddEntityFrameworkStores<ApplicationDbContext>();
            //services.AddControllersWithViews();
            //services.AddRazorPages();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            //app.UseForwardedHeaders(new ForwardedHeadersOptions
            //{
            //    ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto
            //});
            app.ConfigureServicesInAssembly(env, Configuration, Generics.DataModels.Enums.ProjectType.Website);

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "NotFound",
                    pattern: "/Error",
                    new { controller = "Home", action = "Error" });

                endpoints.MapControllerRoute(
                    name: "category",
                    pattern: "{*guid}",
                    new { controller = "Category", action = "Index" },
                    new { guid = new CategoryRouteConstraint() });
                endpoints.MapControllerRoute(
                    name: "product",
                    pattern: "{*guid}",
                    new { controller = "Category", action = "Product" },
                    new { guid = new CategoryProductRouteConstraint() });


                endpoints.MapControllerRoute("Payments", "/account/payments",
                    new { controller = "Accounts", action = "Payments" });
                endpoints.MapControllerRoute("Orders", "/account/orders",
                    new { controller = "Account", action = "Payments" });

                endpoints.MapControllerRoute("SpecificOrders", "/account/orders/{orderId}",
                    new { controller = "Account", action = "SpecificOrder" });
                endpoints.MapControllerRoute("SpecificPayments", "/account/payments/{orderId}",
                    new { controller = "Account", action = "SpecificOrder" });


                endpoints.MapControllerRoute("Shopping_Cart", "cart",
                    new { controller = "ShoppingCart", action = "Index" });

                endpoints.MapControllerRoute("Shopping_Cart", "cart/checkout",
                    new { controller = "ShoppingCart", action = "Checkout" });

                endpoints.MapControllerRoute("Shopping_Cart", "cart/checkoutproceed",
                    new { controller = "ShoppingCart", action = "CheckoutPost" });

                //add product to cart (with attributes and options). used on the product details pages.
                endpoints.MapControllerRoute("AddProductToCart-Details", "addproducttocart/details/{productId:min(0)}/{shoppingCartTypeId:min(0)}",
                    new { controller = "ShoppingCart", action = "AddProductToCart_Details" });

                //add product to cart (with attributes and options). used on the product details pages.
                endpoints.MapControllerRoute("DeleteShoppingCartItem", "deleteproductfromcart/{itemId:min(0)}",
                    new { controller = "ShoppingCart", action = "DeleteShoppingCartItem" });
                //add product to cart (with attributes and options). used on the product details pages.
                endpoints.MapControllerRoute("UpdateShoppingCartItem", "updatecartproductquantity/{itemId:min(0)}/{quantity:min(0)}",
                    new { controller = "ShoppingCart", action = "UpdateShoppingCartItem" });

                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
                endpoints.MapRazorPages();
            });
        }
    }
}
