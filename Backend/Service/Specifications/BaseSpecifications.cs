using DomainLayer.Contracts;
using Microsoft.EntityFrameworkCore.Query;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Service.Specifications
{
    public abstract class BaseSpecifications<TEntity> : ISpecifications<TEntity> where TEntity : class
    {
        protected BaseSpecifications(Expression<Func<TEntity, bool>>? criteriaExp)
        {
            Criteria = criteriaExp;
        }
        public Expression<Func<TEntity, bool>>? Criteria { get; private set; }

        public List<Expression<Func<TEntity, object>>> IncludeExperssions { get; private set; } = [];
        public Expression<Func<TEntity, object>>? OrderBy { get; private set; }

        public Expression<Func<TEntity, object>>? OrderByDescending { get; private set; }
        protected void AddInclude(Expression<Func<TEntity, object>> includeExperssion) => IncludeExperssions.Add(includeExperssion);
        protected void AddOrderBy(Expression<Func<TEntity, object>> orderByExperssion) => OrderBy = orderByExperssion;
        protected void AddOrderByDescending(Expression<Func<TEntity, object>> orderByDescExperssion) => OrderByDescending = orderByDescExperssion;
        public int Take { get; private set; }
        public int Skip { get; private set; }
        public bool IsPagingEnabled { get;  set; } = false;
        protected void ApplyPaging(int pageSize, int pageIndex)
        {
            IsPagingEnabled = true;
            Take = pageSize;
            Skip = (pageIndex - 1) * pageSize;
        }
    }
}
