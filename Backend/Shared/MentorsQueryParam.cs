using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Shared
{
    public class MentorsQueryParam
    {
        private const int MaxPageSize = 10;
        private const int MinPageSize = 5;
        public int? TagId { get; set; }
        public int? SkillId { get; set; }
        public MentorSortingOptions SortingOptions { get; set; }
        public string? SearchValue { get; set; }
        public int PageIndex { get; set; } = 1;
        private int _pageSize = MinPageSize;
        public int PageSize
        {
            get => _pageSize;
            set => _pageSize = (value > MaxPageSize) ? MaxPageSize : (value < MinPageSize) ? MinPageSize : value;
        }
    }
}
