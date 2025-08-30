using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DomainLayer.Models
{
    public class RoadMap
    {
        public int RoadMapId { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? Html { get; set; }
        public int Total_Months { get; set; }
        public int Total_Hours { get; set; }
        public Level DifficultyLevel { get; set; }  
        public List<Phase> Phases { get; set; } = new List<Phase>();
        public ICollection<CareerOutcome> Career_Outcomes { get; set; } = new List<CareerOutcome>();
        public int TraineeId { get; set; }
        public Trainee? Trainee { get; set; }    
    }
}
