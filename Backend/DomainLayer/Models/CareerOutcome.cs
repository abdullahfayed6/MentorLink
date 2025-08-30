using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class CareerOutcome
    {
        public int Id { get; set; }
        [MaxLength(100)]
        public string Outcome { get; set; } = null!;
        public int RoadMapId { get; set; }
        public RoadMap? RoadMap { get; set; }
    }
}
