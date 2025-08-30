using DomainLayer.Models;
using Shared;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Service.Specifications
{
    public class MentorSpecification : BaseSpecifications<Mentor>
    {
        public MentorSpecification(MentorsQueryParam queryParam) 
            : base(p => (!queryParam.TagId.HasValue || p.Tags.Any(t => t.Id == queryParam.TagId)) &&
                        (!queryParam.SkillId.HasValue || p.Skills.Any(s => s.Id == queryParam.SkillId)) &&
                        (string.IsNullOrEmpty(queryParam.SearchValue) || p.Name.Contains(queryParam.SearchValue) || p.JobTitle.Contains(queryParam.SearchValue) || p.Description.Contains(queryParam.SearchValue))
                  )
        {
            AddInclude(p=>p.Tags);
            AddInclude(p => p.Skills);
            AddInclude(p => p.Rates);
            switch (queryParam.SortingOptions)
            {
                case MentorSortingOptions.PriceAsc:
                    AddOrderBy(p => p.Price);
                    break;
                case MentorSortingOptions.PriceDesc:
                    AddOrderByDescending(p => p.Price);
                    break;
                default:
                    AddOrderBy(p => p.Name);
                    break;
            }
            ApplyPaging(queryParam.PageSize, queryParam.PageIndex);
        }
        
        public MentorSpecification(int id): base(p => p.MentorId == id) // Get Mentor by Id
        {
            AddInclude(p => p.Tags);
            AddInclude(p => p.Skills);
            AddInclude(p => p.Rates);
        }
    }
}
