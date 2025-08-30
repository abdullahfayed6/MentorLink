using DomainLayer.Contracts;
using DomainLayer.Models;
using Presistence.Data;
using Microsoft.EntityFrameworkCore;

namespace Presistence.Repositories
{
    public class PasswordResetRepository : GenericRepository<PasswordReset>, IPasswordResetRepository
    {
        private readonly AppDbContext _dbcontext;

        public PasswordResetRepository(AppDbContext dbcontext) : base(dbcontext)
        {
            _dbcontext = dbcontext;
        }

        public async Task<PasswordReset?> GetValidResetCodeAsync(string email, string resetCode)
        {
            return await _dbcontext.PasswordResets
                .FirstOrDefaultAsync(pr => 
                    pr.Email == email && 
                    pr.ResetCode == resetCode && 
                    !pr.IsUsed && 
                    pr.ExpiresAt > DateTime.UtcNow);
        }

        public async Task<IEnumerable<PasswordReset>> GetExpiredResetCodesAsync()
        {
            return await _dbcontext.PasswordResets
                .Where(pr => pr.ExpiresAt <= DateTime.UtcNow && !pr.IsUsed)
                .ToListAsync();
        }

        public async Task InvalidateResetCodesForEmailAsync(string email)
        {
            var resetCodes = await _dbcontext.PasswordResets
                .Where(pr => pr.Email == email && !pr.IsUsed)
                .ToListAsync();

            foreach (var resetCode in resetCodes)
            {
                resetCode.IsUsed = true;
                resetCode.UsedAt = DateTime.UtcNow;
            }

            await _dbcontext.SaveChangesAsync();
        }
    }
}
