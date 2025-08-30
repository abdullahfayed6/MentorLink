using DomainLayer.Contracts;
using Presistence.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Presistence.Repositories
{
    public class UnitOfWork(AppDbContext _dbContext) : IUnitOfWork
    {
        private Dictionary<string ,object> _repositories = new Dictionary<string ,object>();
        private ITraineeRepository? _trainees;
        private IPasswordResetRepository? _passwordResets;
        
        public ITraineeRepository Trainees => _trainees ??= new TraineeRepository(_dbContext);
        public IPasswordResetRepository PasswordResets => _passwordResets ??= new PasswordResetRepository(_dbContext);
        
        public IGenericRepository<TEntity> GetRepository<TEntity>() where TEntity : class
        {
            var typeName = typeof(TEntity).Name;
            if (_repositories.TryGetValue(typeName, out object value))
                return (IGenericRepository <TEntity>)value;
            else
            {
                var Repo = new GenericRepository<TEntity>(_dbContext);
                _repositories.Add(typeName, Repo);
                return Repo;
            }
        }

        public Task<int> SaveChangesAsync() => _dbContext.SaveChangesAsync();
    }
}
