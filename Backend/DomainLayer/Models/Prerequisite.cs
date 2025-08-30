using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class Prerequisite
    {
        public int Id { get; set; }
        [MaxLength(100)]
        public string? Requirement { get; set; }
        public ICollection<Phase> Phases { get; set; } = new List<Phase>();
    }
}
