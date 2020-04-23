using Generics.DataModels.Enums;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Generics.Configurations.Installer
{
    public class SocialInstaller : IInstaller
    {
        class Constants
        {
            private const string Authentication = "Authentication";
            private const string Twitter = "Twitter";
            private const string Google = "Google";
            private const string Facebook = "Facebook";
            private const string Microsoft = "Microsoft";

            public const string ClientId = "ClientId";
            public const string ClientSecret = "ClientSecret";
            public const string ConsumerAPIKey = "ConsumerAPIKey";
            public const string ConsumerSecret = "ConsumerSecret";

            public const string MicrosoftAuth = Authentication + ":" + Microsoft;
            public const string TwitterAuth = Authentication + ":" + Twitter;
            public const string FacebookAuth = Authentication + ":" + Facebook;
            public const string GoogleAuth = Authentication + ":" + Google;
        }
        public void InstallServices(IServiceCollection services, IConfiguration configuration, ProjectType projectType)
        {
            if (projectType == ProjectType.Admin) 
                return;

            SetGoogleAuth(services, configuration);
            SetTwitterAuth(services, configuration);
            SetFacebookAuth(services, configuration);
            SetMicrosoftAuth(services, configuration);
        }

        private static void SetGoogleAuth(IServiceCollection services, IConfiguration configuration)
        {
            var authNSection = configuration.GetSection(Constants.GoogleAuth);
            if (authNSection == null || authNSection.Value == null) return;

            services.AddAuthentication()
             .AddGoogle(options =>
             {
                 options.ClientId = authNSection[Constants.ClientId];
                 options.ClientSecret = authNSection[Constants.ClientSecret];
             });

        }
        private static void SetFacebookAuth(IServiceCollection services, IConfiguration configuration)
        {
            var authNSection = configuration.GetSection(Constants.FacebookAuth);
            if (authNSection == null || authNSection.Value == null) return;

            services.AddAuthentication()
             .AddFacebook(options =>
             {
                 options.ClientId = authNSection["ClientId"];
                 options.ClientSecret = authNSection["ClientSecret"];
             });

        }
        private static void SetTwitterAuth(IServiceCollection services, IConfiguration configuration)
        {
            IConfigurationSection authNSection =
                               configuration.GetSection(Constants.TwitterAuth);
            if (authNSection == null || authNSection.Value == null) return;

            services.AddAuthentication().AddTwitter(options =>
            {
                options.ConsumerKey = authNSection[Constants.ConsumerAPIKey];
                options.ConsumerSecret = authNSection[Constants.ConsumerSecret];
            });
        }
        private static void SetMicrosoftAuth(IServiceCollection services, IConfiguration configuration)
        {
            IConfigurationSection authNSection =
                               configuration.GetSection(Constants.MicrosoftAuth);
            if (authNSection == null || authNSection.Value == null) return;

            services.AddAuthentication().AddMicrosoftAccount(options =>
            {
                options.ClientId = authNSection[Constants.ClientId];
                options.ClientSecret = authNSection[Constants.ClientSecret];
            });
        }

        public void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env, IConfiguration configuration, ProjectType projectType)
        {
        }
    }
}
