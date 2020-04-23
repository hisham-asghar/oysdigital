using Generics.DataModels;
using LayerBAO.GoogleBao;
using Microsoft.Extensions.Options;
using System;
using System.Net.Mail;
using System.Threading.Tasks;

namespace Admin.Services.MessageService
{
    // This class is used by the application to send Email and SMS
    // when you turn on two-factor authentication in ASP.NET Identity.
    // For more details see this link https://go.microsoft.com/fwlink/?LinkID=532713
    public class MessageService : Microsoft.AspNetCore.Identity.UI.Services.IEmailSender, ISmsSender
    {
        public static SmtpClient smtpClient;
        public MessageService(IOptions<SMSoptions> optionsAccessor)
        {
            Options = optionsAccessor.Value;
        }

        public SMSoptions Options { get; }  // set only via Secret Manager

        public Task SendEmailAsync(string email, string subject, string message)
        {
            new SendEmailModel() {
                To = email,
                Body = message,
                Subject = subject
            }.SendMailGoogle();

            //if(smtpClient != null)
            //{
            //    SendSmtpEmailAsync(email, subject, message);
            //}
            // Plug in your email service here to send an email.
            return Task.FromResult(0);
        }

        public static bool SendEmail(string email, string subject, string message)
        {
            return new SendEmailModel()
            {
                To = email,
                Body = message,
                Subject = subject
            }.SendMailGoogle();

            //if (smtpClient != null)
            //{
            //    return SendSmtpEmailAsync(email, subject, message);
            //}
            // Plug in your email service here to send an email.
            
        }


        public static bool SendSmtpEmailAsync(string email, string subject, string message)
        {
            try
            {
                smtpClient.Send(new MailMessage(
                   to: email,
                   subject: subject,
                   body: message,
                   from: Generics.Common.SmtpConfiguration.Username
                   ));
                return true;
            }catch(Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
            // Plug in your email service here to send an email.
            return false;
        }


        public Task SendSmsAsync(string number, string message)
        {
            // Plug in your SMS service here to send a text message.

            // Please check MessageServices_twilio.cs or MessageServices_ASPSMS.cs
            // for implementation details.

            return Task.FromResult(0);
        }
    }
}
