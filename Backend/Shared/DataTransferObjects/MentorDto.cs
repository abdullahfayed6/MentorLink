using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Shared.DataTransferObjects
{
    public class MentorDto
    {
        public string Name { get; set; } = null!;
        public string? PictureUrl { get; set; }
        public string? Description { get; set; }
        public string? JobTitle { get; set; }
        public int Price { get; set; }
        //public bool IsAvailable { get; set; } = true;
        public List<string> Tags { get; set; } = new List<string>();
        public List<string> Skills { get; set; } = new List<string>();
        public int RateCount { get; set; }
        public double AverageRate { get; set; }
    }
}
