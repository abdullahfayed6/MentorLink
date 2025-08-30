using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class Skill
    {
        public int Id { get; set; }
        [MaxLength(50)]
        public string Name { get; set; } = null!;
        public ICollection<Mentor>? Mentors { get; set; }
    }
}
