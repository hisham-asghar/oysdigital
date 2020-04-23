using Generics.Data;
using Generics.DataModels.Enums;
using Generics.Services.DatabaseService.AdoNet;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Generics.Configurations.Installer
{
    public class DbInstaller : IInstaller
    {
        public void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env, IConfiguration configuration, ProjectType projectType)
        {
        }

        public void InstallServices(IServiceCollection services, IConfiguration configuration, ProjectType projectType)
        {
            
            var connectionString = configuration["connectionStrings:DefaultConnection"];
            Constants.ConnectionString = connectionString;
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(
                    configuration.GetConnectionString("DefaultConnection")));
        }
    }
}
