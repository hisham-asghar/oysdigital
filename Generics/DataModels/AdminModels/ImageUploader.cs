using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http.Headers;
using System.Text;

namespace Generics.DataModels.AdminModels
{
    public class ImageUploader
    {
        private readonly IHostingEnvironment _environment;
        public ImageUploader(IHostingEnvironment environment)
        {
            _environment = environment ?? throw new ArgumentNullException(nameof(environment));
        }
        public string SaveImage(IFormFile file)
        {
            // do other validations on your model as needed
            var uploads = Path.Combine(_environment.WebRootPath, "uploads");
            var uniquefileName = GetUniqueFileName(file.FileName);
            if (file.Length > 0)
            {
                using (var fileStream = new FileStream(Path.Combine(uploads, uniquefileName), FileMode.Create))
                {
                    file.CopyToAsync(fileStream);
                }
                return uniquefileName;
            }
            return null;
            // to do  : Return something
        }
        private string GetUniqueFileName(string fileName)
        {
            fileName = Path.GetFileName(fileName);
            return Path.GetFileNameWithoutExtension(fileName)
                      + "_"
                      + Guid.NewGuid().ToString().Substring(0, 4)
                      + Path.GetExtension(fileName);
        }
        public bool DeleteImage(string file)
        {
            var uploads = Path.Combine(_environment.WebRootPath, "uploads");
            string fileName = Path.Combine(uploads, file);

            if (fileName != null || fileName != string.Empty)
            {
                if ((System.IO.File.Exists(fileName)))
                {
                    System.IO.File.Delete(fileName);
                    return true;
                }

            }
            return false;
        }
    }
}
