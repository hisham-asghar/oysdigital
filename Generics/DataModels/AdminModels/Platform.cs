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
            dictionary.Add("zmdi zmdi-instagram", "instagram");
            dictionary.Add("zmdi zmdi-twitter", "twitter");
            dictionary.Add("zmdi zmdi-linkedin", "linked In");
            dictionary.Add("zmdi zmdi-pinterest", "pinterest");
            dictionary.Add("zmdi zmdi-tumblr", "tumblr");
            dictionary.Add("fab fa-snapchat", "snapchat");
            dictionary.Add("zmdi zmdi-whatsapp", "whatsApp");
            dictionary.Add("zmdi zmdi-google", "Google my business");
            dictionary.Add("zmdi zmdi-youtube", "youtube");
            dictionary.Add("fab fa-facebook-messanger", "messanger");
            dictionary.Add("fab fa-wechat", "wechat");
            dictionary.Add("fab fa-tiktok", "tiktok");
            dictionary.Add("zmdi zmdi-reddit", "reddit");
            dictionary.Add("zmdi zmdi-skype", "skype");
            dictionary.Add("fab fa-telegram", "telegram");
            dictionary.Add("zmdi zmdi-google-drive", "google-drive");
            dictionary.Add("zmdi zmdi-flickr", "flickr");
            
            
            
            
           
            return dictionary;
        }
    }

}
