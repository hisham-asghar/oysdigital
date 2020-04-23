using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.DataModels.Enums;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Swagger;
using Generics.Configurations.Options;

namespace Generics.Configurations.Installer
{
    public class SwaggerInstaller : IInstaller
    {
        public void ConfigureServices(IApplicationBuilder app, IWebHostEnvironment env, IConfiguration configuration, ProjectType projectType)
        {
            if (projectType != ProjectType.Api)
                return;
            var swaggerOptions = new Options.SwaggerOptions();
            configuration.GetSection(nameof(Options.SwaggerOptions)).Bind(swaggerOptions);
            app.UseSwagger(option => { option.RouteTemplate = swaggerOptions.JsonRoute; });
            app.UseSwaggerUI(option =>
            {
                option.SwaggerEndpoint(swaggerOptions.UiEndpoint, swaggerOptions.Description);
            });

        }

        public void InstallServices(IServiceCollection services, IConfiguration configuration, ProjectType projectType)
        {
            if (projectType != ProjectType.Api) 
                return;

            services.AddSwaggerGen(x =>
            {
                x.SwaggerDoc("v1", new OpenApiInfo { Title = "API", Version = "v1" });

                x.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Description = "JWT Authorization header using the bearer scheme",
                    Name = "Authorization",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.ApiKey
                });
                //x.AddSecurityRequirement(new OpenApiSecurityRequirement
                //{
                //    {new OpenApiSecurityScheme{Reference = new OpenApiReference
                //    {
                //        Id = "Bearer",
                //        Type = ReferenceType.SecurityScheme
                //    }}, new List<string>()}
                //});
                x.AddSecurityRequirement(new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Id = "Bearer",
                                Type = ReferenceType.SecurityScheme
                            }
                        }
                        ,new List<string>()
                    }
                });

                //x.AddSecurityRequirement(new Dictionary<string, IEnumerable<string>>
                //{
                //    {"Bearer",new string[0] }
                //});
                //var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                //var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
                //x.IncludeXmlComments(xmlPath);
            });

        }

    }
}
