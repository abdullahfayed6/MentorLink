using DomainLayer.Models;

namespace DomainLayer.Contracts
{
    public interface ITraineeRepository : IGenericRepository<Trainee>
    {
        Task<Trainee?> GetByEmailAsync(string email);
        Task<Trainee?> GetByRefreshTokenAsync(string refreshToken);
    }
}
