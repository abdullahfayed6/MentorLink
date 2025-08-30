using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class Rate
    {
        public int TraineeId { get; set; }
        public Trainee? Trainee { get; set; }
        public int MentorId { get; set; }
        public Mentor? Mentor { get; set; }
        [Range(1, 5)]
        public int Rating { get; set; } 
        
    }
}
