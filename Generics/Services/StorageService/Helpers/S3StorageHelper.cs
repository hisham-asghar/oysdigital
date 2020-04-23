using System;
using System.Net;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Model;
using Generics.Services.StorageService.Models;
//using Microsoft.Azure;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace Generics.Services.StorageService.Helpers
{
    public class S3StorageHelper
    {

        public static bool UploadFileToS3(string srcPath, string destinationPath)
        {
            string accessKey = S3StorageModel.S3AccessKey;
            string secretKey = S3StorageModel.S3SecretKey;

            AmazonS3Config config = new AmazonS3Config
            {
                ServiceURL = S3StorageModel.S3ServiceUrl
            };
            var s3Client = new AmazonS3Client(accessKey, secretKey, config);
            var request = new PutObjectRequest
            {
                BucketName = S3StorageModel.BucketName,
                CannedACL = S3CannedACL.PublicRead,
                Key = destinationPath,
                FilePath = srcPath
            };
            try
            {

                var task = s3Client.PutObjectAsync(request);
                task.Wait();
                
                return true;
            }catch(Exception ex)
            {
                Console.Error.WriteLine(ex);
                return false;
            }
        }
    }
}
