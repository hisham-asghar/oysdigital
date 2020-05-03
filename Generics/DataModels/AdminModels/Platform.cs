using Generics.Common.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class Platform:BaseEntity
    {        
        public string Name { get; set; }
        public string IconClass { get; set; }
        public bool IsActive { get; set; }
        
    }
    public static class PlatformHelper
    {
        public static Dictionary<string, string> GetPlatformDictionar()
        {
            var dictionary = new Dictionary<string, string>();
            dictionary.Add("zmdi zmdi-facebook", "facebook");
            dictionary.Add("zmdi zmdi-whatsapp", "WhatsApp");
            dictionary.Add("zmdi zmdi-youtube-play", "youtube");
            dictionary.Add("zmdi zmdi-google-plus", "Google Plus");
            dictionary.Add("zmdi zmdi-twitter", "twitter");
            dictionary.Add("zmdi zmdi-linkedin", "linked In");
            return dictionary;
        }
    }

}
