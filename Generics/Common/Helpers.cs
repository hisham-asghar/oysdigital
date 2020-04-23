using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Generics.Common
{
    public class Helpers
    {

        public static string PicturePath(long pictureId, string mimeType, string seoFileName = null, int targetSize = 0)
        {
            var lastPart = GetFileExtensionFromMimeType(mimeType);
            string thumbFileName;
            if (targetSize == 0)
            {
                thumbFileName = !string.IsNullOrEmpty(seoFileName)
                    ? $"{pictureId:0000000}_{seoFileName}.{lastPart}"
                    : $"{pictureId:0000000}.{lastPart}";
            }
            else
            {
                thumbFileName = !string.IsNullOrEmpty(seoFileName)
                    ? $"{pictureId:0000000}_{seoFileName}_{targetSize}.{lastPart}"
                    : $"{pictureId:0000000}_{targetSize}.{lastPart}";
            }
            return thumbFileName;
        }
        public static string GetFileExtensionFromMimeType(string mimeType)
        {
            if (mimeType == null)
                return null;

            //TODO use FileExtensionContentTypeProvider to get file extension

            var parts = mimeType.Split('/');
            var lastPart = parts[parts.Length - 1];
            switch (lastPart)
            {
                case "pjpeg":
                    lastPart = "jpg";
                    break;
                case "x-png":
                    lastPart = "png";
                    break;
                case "x-icon":
                    lastPart = "ico";
                    break;
            }

            return lastPart;
        }
    }
}
