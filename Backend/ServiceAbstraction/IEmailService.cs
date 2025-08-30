namespace ServiceAbstraction
{
    public interface IEmailService
    {
        Task<bool> SendPasswordResetEmailAsync(string email, string resetCode, DateTime expiresAt);
    }
}
