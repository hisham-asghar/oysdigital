using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.Services.StorageService.Models
{
    public static class FtpCredentialModel
    {
        public static string Username { get; set; }
        public static string Password { get; set; }
        public static string Host { get; set; }
        public static int Port { get; set; }
    }
}
