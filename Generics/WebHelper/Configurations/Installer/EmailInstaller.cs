using Admin.Services.MessageService;
using Generics.Common;
using Generics.DataModels.Enums;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System.Net;

namespace Generics.Configurations.Installer
{
    public class EmailInstaller : IInstaller
    {
        public void InstallServices(IServiceCollection services, IConfiguration configuration, ProjectType projectType)
        {
            SetSmtpConfiguration(services, configuration);
        }

        private static void SetSmtpConfiguration(IServiceCollection services, IConfiguration configuration)
        {
            SmtpConfiguration.Host = configuration.GetValue<string>("Email:Smtp:Host");
            SmtpConfiguration.Port = configuration.GetValue<int>("Email:Smtp:Port");
            SmtpConfiguration.Username = configuration.GetValue<string>("Email:Smtp:Username");
            SmtpConfiguration.Password = configuration.GetValue<string>("Email:Smtp:Password");
            if(string.IsNullOrWhiteSpace(SmtpConfiguration.Host) || string.IsNullOrWhiteSpace(SmtpConfiguration.Username)
                || string.IsNullOrWhiteSpace(SmtpConfiguration.Password) || SmtpConfiguration.Port == 0) return;

            MessageService.smtpClient = new System.Net.Mail.SmtpClient()
            {
                Host = SmtpConfiguration.Host,
                Port = SmtpConfiguration.Port,
                Credentials = new NetworkCredential(
                        SmtpConfiguration.Username,
                        SmtpConfiguration.Password
                    )
            };
        }

        public void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env, IConfiguration configuration, ProjectType projectType)
        {
        }

    }
}
