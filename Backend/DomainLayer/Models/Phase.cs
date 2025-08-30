using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;

namespace DomainLayer.Models
{
    public class Phase
    {
        [Key]
        public string PhaseId { get; set; }
        [MaxLength(100)]
        public string? Title { get; set; }
        public int? Month { get; set; }
        public int? Weeks { get; set; }
        public ICollection<GainedSkill> Skills_Gained { get; set; } = new List<GainedSkill>();  
        public ICollection<RecommendedCourse> Recommended_Courses { get; set; } = new List<RecommendedCourse>();
        public ICollection<Prerequisite> Prerequisites { get; set; } = new List<Prerequisite>();
        public int RoadMapId { get; set; }
        public RoadMap? RoadMap { get; set; }
    }
}
