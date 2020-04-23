using System.Text;
using System.Threading.Tasks;
using Generics.Configurations.Options;
using Generics.DataModels.Enums;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;

namespace Generics.Configurations.Installer
{
    public class MvcInstaller : IInstaller
    {
        public void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env, IConfiguration configuration, ProjectType projectType)
        {
        }

        public void InstallServices(IServiceCollection services, IConfiguration configuration, ProjectType projectType)
        {
            services.AddControllersWithViews();
            services.AddRazorPages();

            services.AddCors(options =>
            {
                options.AddPolicy("_all",
                    builder =>
                    {
                        builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
                    }
                );
            });
        }
    }
}
