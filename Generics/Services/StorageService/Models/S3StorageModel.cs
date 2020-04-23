using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.Services.StorageService.Models
{
    public static class S3StorageModel
    {
        public static bool isSet { get; set; }
        public static string S3AccessKey { get; set; }
        public static string S3SecretKey { get; set; }
        public static string S3ServiceUrl { get; set; }
        public static string BucketName { get; set; }
        public static string S3EndPoint { get; set; }
    }
}
