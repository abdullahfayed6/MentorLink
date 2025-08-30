using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using ServiceAbstraction;
using System.Text;
using Microsoft.Extensions.Configuration;

namespace Service
{
    public class EmailService : IEmailService
    {
        private readonly IConfiguration _configuration;

        public EmailService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<bool> SendPasswordResetEmailAsync(string email, string resetCode, DateTime expiresAt)
        {
            try
            {
                var emailSettings = _configuration.GetSection("EmailSettings");
                var smtpServer = emailSettings["SmtpServer"] ?? "smtp.gmail.com";
                var smtpPort = int.Parse(emailSettings["SmtpPort"] ?? "587");
                var smtpUsername = emailSettings["SmtpUsername"];
                var smtpPassword = emailSettings["SmtpPassword"];
                var fromEmail = emailSettings["FromEmail"] ?? smtpUsername;
                var fromName = emailSettings["FromName"] ?? "MentorLink";

                if (string.IsNullOrEmpty(smtpUsername) || string.IsNullOrEmpty(smtpPassword))
                {
                    // For development/testing, just log the email instead of sending
                    Console.WriteLine($"=== PASSWORD RESET EMAIL ===");
                    Console.WriteLine($"To: {email}");
                    Console.WriteLine($"Subject: Password Reset Code - MentorLink");
                    Console.WriteLine($"Reset Code: {resetCode}");
                    Console.WriteLine($"Expires At: {expiresAt:yyyy-MM-dd HH:mm:ss}");
                    Console.WriteLine($"================================");
                    return true;
                }

                var message = new MimeMessage();
                message.From.Add(new MailboxAddress(fromName, fromEmail));
                message.To.Add(new MailboxAddress("", email));
                message.Subject = "Password Reset Code - MentorLink";

                var bodyBuilder = new BodyBuilder();
                bodyBuilder.HtmlBody = GenerateEmailHtml(resetCode, expiresAt);
                bodyBuilder.TextBody = GenerateEmailText(resetCode, expiresAt);

                message.Body = bodyBuilder.ToMessageBody();

                using var client = new SmtpClient();
                await client.ConnectAsync(smtpServer, smtpPort, SecureSocketOptions.StartTls);
                await client.AuthenticateAsync(smtpUsername, smtpPassword);
                await client.SendAsync(message);
                await client.DisconnectAsync(true);

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending email: {ex.Message}");
                return false;
            }
        }

        private string GenerateEmailHtml(string resetCode, DateTime expiresAt)
        {
            return $@"
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset='utf-8'>
                    <title>Password Reset - MentorLink</title>
                    <style>
                        body {{ font-family: Arial, sans-serif; line-height: 1.6; color: #333; }}
                        .container {{ max-width: 600px; margin: 0 auto; padding: 20px; }}
                        .header {{ background-color: #007bff; color: white; padding: 20px; text-align: center; }}
                        .content {{ padding: 20px; background-color: #f8f9fa; }}
                        .code {{ font-size: 24px; font-weight: bold; text-align: center; padding: 20px; background-color: white; border: 2px solid #007bff; margin: 20px 0; }}
                        .footer {{ text-align: center; padding: 20px; color: #666; font-size: 12px; }}
                    </style>
                </head>
                <body>
                    <div class='container'>
                        <div class='header'>
                            <h1>Password Reset Request</h1>
                        </div>
                        <div class='content'>
                            <p>Hello,</p>
                            <p>You have requested to reset your password for your MentorLink account.</p>
                            <p>Please use the following reset code:</p>
                            <div class='code'>{resetCode}</div>
                            <p><strong>This code will expire at:</strong> {expiresAt:yyyy-MM-dd HH:mm:ss}</p>
                            <p>If you did not request this password reset, please ignore this email.</p>
                            <p>Best regards,<br>The MentorLink Team</p>
                        </div>
                        <div class='footer'>
                            <p>This is an automated message. Please do not reply to this email.</p>
                        </div>
                    </div>
                </body>
                </html>";
        }

        private string GenerateEmailText(string resetCode, DateTime expiresAt)
        {
            return $@"
Password Reset Request - MentorLink

Hello,

You have requested to reset your password for your MentorLink account.

Please use the following reset code: {resetCode}

This code will expire at: {expiresAt:yyyy-MM-dd HH:mm:ss}

If you did not request this password reset, please ignore this email.

Best regards,
The MentorLink Team

---
This is an automated message. Please do not reply to this email.";
        }
    }
}
