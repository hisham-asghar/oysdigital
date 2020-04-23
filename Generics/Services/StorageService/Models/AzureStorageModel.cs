using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.Services.StorageService.Models
{
    public static class AzureStorageModel
    {
        public static bool isSet = false;
        public static string StorageAccountKey { get; set; }
        public static string ConnectionString { get; set; }
        public static string DataBlob { get; set; }
        public static string BaseFolder { get; set; }
    }
}
