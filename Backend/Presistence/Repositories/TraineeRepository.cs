using DomainLayer.Contracts;
using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
using Presistence.Data;

namespace Presistence.Repositories
{
    public class TraineeRepository : GenericRepository<Trainee>, ITraineeRepository
    {
        private readonly AppDbContext _dbcontext;

        public TraineeRepository(AppDbContext dbcontext) : base(dbcontext)
        {
            _dbcontext = dbcontext;
        }

        public async Task<Trainee?> GetByEmailAsync(string email)
        {
            return await _dbcontext.Trainees
                .FirstOrDefaultAsync(t => t.Email == email);
        }

        public async Task<Trainee?> GetByRefreshTokenAsync(string refreshToken)
        {
            return await _dbcontext.Trainees
                .FirstOrDefaultAsync(t => t.RefreshToken == refreshToken);
        }
    }
}
