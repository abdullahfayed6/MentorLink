using DomainLayer.Models;

namespace DomainLayer.Contracts
{
    public interface IPasswordResetRepository : IGenericRepository<PasswordReset>
    {
        Task<PasswordReset?> GetValidResetCodeAsync(string email, string resetCode);
        Task<IEnumerable<PasswordReset>> GetExpiredResetCodesAsync();
        Task InvalidateResetCodesForEmailAsync(string email);
    }
}
