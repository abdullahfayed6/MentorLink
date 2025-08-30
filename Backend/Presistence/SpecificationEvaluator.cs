using DomainLayer.Contracts;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Presistence
{
    internal static class SpecificationEvaluator
    {
        public static IQueryable<TEntity> CreateQuery<TEntity>(IQueryable<TEntity> inputQuery, ISpecifications<TEntity> specifications) where TEntity : class
        {
            var query = inputQuery;
            // Apply criteria
            if (specifications.Criteria != null)
            {
                query = query.Where(specifications.Criteria);
            }
            // Apply includes
            if(specifications.IncludeExperssions != null && specifications.IncludeExperssions.Count > 0)
            {
                query = specifications.IncludeExperssions.Aggregate(query, (current, include) => current.Include(include));
            }
            // Apply ordering
            if (specifications.OrderBy != null)
                query = query.OrderBy(specifications.OrderBy);
            else if (specifications.OrderByDescending != null)
                query = query.OrderByDescending(specifications.OrderByDescending);
            // Apply paging
            if (specifications.IsPagingEnabled)
            {
                query = query.Skip(specifications.Skip).Take(specifications.Take);
            }
            return query;
        }
    }
}
