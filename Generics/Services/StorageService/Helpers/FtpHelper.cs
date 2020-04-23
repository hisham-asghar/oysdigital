using Generics.Services.StorageService.Models;
using System;
using System.Collections.Generic;
using System.Net;
using System.Text;

namespace Generics.Services.StorageService.Helpers
{
    public class FtpHelper
    {
        public static bool UploadFile(string destination, string src)
        {
            if (string.IsNullOrWhiteSpace(src)) return false;
            try
            {
                if (destination.Contains(FtpCredentialModel.Host))
                    destination = destination.Replace(FtpCredentialModel.Host, "");
                using (var client = new WebClient())
                {
                    if (src.Contains("http"))
                    {
                        var data = client.DownloadData(src);
                        client.Credentials = new NetworkCredential(FtpCredentialModel.Username, FtpCredentialModel.Password);
                        client.UploadData(FtpCredentialModel.Host + destination, data);
                    }
                    else
                    {
                        client.Credentials = new NetworkCredential(FtpCredentialModel.Username, FtpCredentialModel.Password);
                        client.UploadFile(FtpCredentialModel.Host + destination, src);
                    }

                    return true;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("FTP File Upload Error - " + ex);
                return false;
            }
        }

        public static bool DeleteFile(string path)
        {
            try
            {
                var request = (FtpWebRequest)WebRequest.Create(FtpCredentialModel.Host + path);
                request.Method = WebRequestMethods.Ftp.DeleteFile;
                request.Credentials = new NetworkCredential(FtpCredentialModel.Username, FtpCredentialModel.Password);
                using (var response = (FtpWebResponse)request.GetResponse())
                {
                    var res = response.StatusDescription;
                    Console.WriteLine(res);
                }
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("FTP File Upload Error - " + ex);
                return false;
            }
        }
    }
}
