using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class RecommendedCourse
    {
        public int Id { get; set; }
        [MaxLength(100)]
        public string CourseName { get; set; } = null!;
        public string? PhaseId { get; set; }
        public Phase? Phase { get; set; }
    }
}
