using System;
using System.Net;
using System.Threading.Tasks;
using Generics.Services.StorageService.Models;
//using Microsoft.Azure;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace Generics.Services.StorageService.Helpers
{
    public class AzureStorageHelper
    {
        public class BlobHelper
        {
            public static object AzureConstants { get; private set; }

            /// <summary>
            /// Upload File To Azure Blob Storage
            /// </summary>
            /// <param name="source">Source could be System Path or Can be a url</param>
            /// <param name="destination">Destination is the location of file in blob storage</param>
            /// <returns></returns>
            public static bool Upload(string source, string destination)
            {
                var result = Task.Run(() => UploadTask(source, destination));
                return result.Result;
            }
            private static async Task<bool> UploadTask(string source, string destination)
            {
                var bytes = GetByteArray(source);
                if (bytes == null || bytes.Length == 0) return false;
                try
                {
                    var container = await GetContainerAsync();
                    CloudBlockBlob blockBlob = container.GetBlockBlobReference
                        (AzureStorageModel.BaseFolder + destination);
                    await blockBlob.UploadFromByteArrayAsync(bytes, 0, bytes.Length);
                    return true;
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine(ex);
                    return false;
                }
            }

            /// <summary>
            /// Remove/Delete a file From Azure Blob Storage
            /// </summary>
            /// <param name="path">Path is the location of file which needs to be deleted it could be a file or a folder.</param>
            /// <returns></returns>
            public static bool Delete(string path)
            {
                try
                {

                    var result = Task.Run(() => DeleteTask(path));
                    return result.Result;
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine(ex);
                    return false;
                }
            }
            private static async Task<bool> DeleteTask(string path)
            {
                var container = await GetContainerAsync();
                CloudBlockBlob blockBlob = container.GetBlockBlobReference
                    (AzureStorageModel.BaseFolder + path);
                await blockBlob.DeleteIfExistsAsync();
                return true;
            }

            /// <summary>
            /// 
            /// </summary>
            /// <param name="connStr"></param>
            /// <returns></returns>
            private static CloudStorageAccount CreateStorageAccountFromConnectionString(string connStr)
            {
                CloudStorageAccount storageAccount;
                try
                {
                    storageAccount = CloudStorageAccount.Parse(connStr);
                }
                catch (FormatException)
                {
                    Console.WriteLine("Invalid storage account information provided. Please confirm the AccountName and AccountKey are valid in the app.config file - then restart the sample.");
                    Console.ReadLine();
                    throw;
                }
                catch (ArgumentException)
                {
                    Console.WriteLine("Invalid storage account information provided. Please confirm the AccountName and AccountKey are valid in the app.config file - then restart the sample.");
                    Console.ReadLine();
                    throw;
                }

                return storageAccount;
            }
            private static byte[] GetByteArray(string path)
            {
                try
                {

                    if (path.Contains("http") == false && path.Contains("https") == false)
                        return System.IO.File.ReadAllBytes(path);
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine(ex);
                    return null;
                }
                using (var wc = new WebClient())
                {
                    try
                    {
                        return wc.DownloadData(path);
                    }
                    catch (Exception ex)
                    {
                        Console.Error.WriteLine(ex);
                        return null;
                    }
                }
            }
            private static async Task<CloudBlobContainer> GetContainerAsync()
            {
                // Retrieve storage account information from connection string
                // How to create a storage connection string - http://msdn.microsoft.com/en-us/library/azure/ee758697.aspx
                var storageAccount = CreateStorageAccountFromConnectionString(AzureStorageModel.ConnectionString);

                // Create a blob client for interacting with the blob service.
                var blobClient = storageAccount.CreateCloudBlobClient();

                //Console.WriteLine("1. Creating Container");
                var container = blobClient.GetContainerReference(AzureStorageModel.DataBlob);
                try
                {
                    await container.CreateIfNotExistsAsync();
                    return container;
                }
                catch (StorageException)
                {
                    Console.WriteLine("If you are running with the default configuration please make sure you have started the storage emulator. Press the Windows key and type Azure Storage to select and run it from the list of applications - then restart the sample.");
                    return null;
                }
            }
        }
    }
}
