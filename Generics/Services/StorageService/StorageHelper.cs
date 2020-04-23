using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.Services.StorageService
{
    public class StorageHelper
    {
        public static bool Upload(string src, string destination)
        {
            if (S3StorageModel.isSet)
            {
                return S3StorageHelper.UploadFileToS3(src, destination);
            }
            return false;
        }
        public static bool UploadBase64(byte[] src, string destination)
        {
            var rootFolder = Directory.GetCurrentDirectory();
            var uploads = rootFolder + "/uploads/";
            if (uploads.Contains("//")) uploads = uploads.Replace("//", "/");
            if (Directory.Exists(uploads) == false) Directory.CreateDirectory(uploads);
            var path = uploads + destination;
            File.WriteAllBytes(path, src);
            if (S3StorageModel.isSet)
            {
                return S3StorageHelper.UploadFileToS3(path, destination);
            }
            return false;
        }

    }
}
