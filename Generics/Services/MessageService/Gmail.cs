using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using Generics.DataModels;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Gmail.v1;
using Google.Apis.Gmail.v1.Data;
using Google.Apis.Services;

namespace LayerBAO.GoogleBao
{
    public static class Gmail
    {
        public static bool SendMailGoogle(this SendEmailModel model, bool isHtml = true)
        {
            var email = model?.From ?? "hisham@octacer.com";
            var service = GoogleBase.GetMailService(email);
            var mailMessage =
                new MailMessage
                {
                    From = new MailAddress(email,"Octacer"),
                    Subject = model?.Subject,
                    Body = model?.Body ?? "",
                    IsBodyHtml = isHtml
                    
                };
            if(model?.To == null) return false;
            try
            {

                mailMessage.To.Add(model.To);
                mailMessage.ReplyToList.Add(email);
                var mimeMessage = MimeKit.MimeMessage.CreateFromMailMessage(mailMessage);
                var gmailMessage = new Message
                    {Raw = EmailMessageEncode(mimeMessage.ToString()), LabelIds = new List<string>() {"API"}};
                service.Users.Messages.Send(gmailMessage, "me").Execute();
                return true;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex);
                return false;
            }
        }
        private static string EmailMessageEncode(string input)
        {
            var inputBytes = System.Text.Encoding.UTF8.GetBytes(input);
            // Special "url-safe" base64 encode.
            return Convert.ToBase64String(inputBytes)
                .Replace('+', '-')
                .Replace('/', '_')
                .Replace("=", "");
        }
    }
}
