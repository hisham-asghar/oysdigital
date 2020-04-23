using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Generics.Configurations.Installer
{
    public interface IInstaller
    {
        void InstallServices(IServiceCollection services,
            IConfiguration configuration,
            DataModels.Enums.ProjectType projectType);
        void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env,
            IConfiguration configuration,
            DataModels.Enums.ProjectType projectType);
    }
}
