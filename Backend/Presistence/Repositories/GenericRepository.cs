using DomainLayer.Contracts;
using Microsoft.EntityFrameworkCore;
using Presistence.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Presistence.Repositories
{
    public class GenericRepository<TEntity>(AppDbContext _dbcontext) : IGenericRepository<TEntity> where TEntity : class
    {
        public async Task AddAsync(TEntity entity) => await _dbcontext.Set<TEntity>().AddAsync(entity);

   

        public async Task<IEnumerable<TEntity>> GetAllAsync() => await _dbcontext.Set<TEntity>().ToListAsync();
        // Get all entities based on specifications
        public async Task<IEnumerable<TEntity>> GetAllAsync(ISpecifications<TEntity> specifications)
        {
           return await SpecificationEvaluator.CreateQuery(_dbcontext.Set<TEntity>().AsQueryable(), specifications).ToListAsync();
        }
        // Get entity by specifications (single entity)
        public async Task<TEntity?> GetByIdAsync(ISpecifications<TEntity> specifications)
        {
           return await SpecificationEvaluator.CreateQuery(_dbcontext.Set<TEntity>(), specifications).FirstOrDefaultAsync();
        }

        public async Task<TEntity?> GetByIdAsync(int id) => await _dbcontext.Set<TEntity>().FindAsync(id);


        public void Remove(TEntity entity) => _dbcontext.Set<TEntity>().Remove(entity);

        public void Update(TEntity entity) => _dbcontext.Set<TEntity>().Update(entity);    
        public async Task<int> CountAsync(ISpecifications<TEntity> specifications)
        {
            return await SpecificationEvaluator.CreateQuery(_dbcontext.Set<TEntity>(), specifications).CountAsync();
        }
    }
}
