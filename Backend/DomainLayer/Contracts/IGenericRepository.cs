using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DomainLayer.Contracts
{
    public interface IGenericRepository<TEntity> where TEntity : class
    {
        Task<IEnumerable<TEntity>> GetAllAsync();
        Task<TEntity?> GetByIdAsync(int id);
        Task<IEnumerable<TEntity>> GetAllAsync(ISpecifications<TEntity> specifications);
        Task<TEntity?> GetByIdAsync(ISpecifications<TEntity> specifications);
        Task AddAsync(TEntity entity);
        Task<int> CountAsync(ISpecifications<TEntity> specifications);
        void Update(TEntity entity);
        void Remove(TEntity entity);
    }
}
