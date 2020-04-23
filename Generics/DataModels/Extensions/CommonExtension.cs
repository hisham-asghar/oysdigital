
using Microsoft.AspNetCore.Http;

namespace Generics.DataModels.Extensions
{
    public static class CommonExtension
    {
        public static string GetReturnUrl(this HttpRequest request)
        {
            return request.Path;
        }
    }
}
