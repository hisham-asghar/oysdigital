using Generics.Data;
using Generics.Configurations.Options;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using System;
using Microsoft.AspNetCore.Http;
using Generics.DataModels.Enums;
using Admin.Services.MessageService;
using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;

namespace Generics.Configurations.Installer
{
    public class SingletonInstaller : IInstaller
    {
        public void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env, IConfiguration configuration, ProjectType projectType)
        {
        }

        public void InstallServices(IServiceCollection services, IConfiguration configuration, ProjectType projectType)
        {
            services.AddTransient<IEmailSender, MessageService>();
        }
    }
}
