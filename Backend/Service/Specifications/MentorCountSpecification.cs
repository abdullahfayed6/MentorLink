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
    internal class MentorCountSpecification : BaseSpecifications<Mentor>
    {
        public MentorCountSpecification(MentorsQueryParam queryParam) 
            : base(p => (!queryParam.TagId.HasValue || p.Tags.Any(t => t.Id == queryParam.TagId)) &&
                    (!queryParam.SkillId.HasValue || p.Skills.Any(s => s.Id == queryParam.SkillId)) &&
                    (string.IsNullOrEmpty(queryParam.SearchValue) || p.Name.Contains(queryParam.SearchValue) || p.JobTitle.Contains(queryParam.SearchValue) || p.Description.Contains(queryParam.SearchValue))
                  )
        {
        }
    }
}
