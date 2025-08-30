using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class GainedSkill
    {
        public int Id { get; set; }
        [MaxLength(50)]
        public string SkillName { get; set; } = null!;
        public ICollection<Phase> Phases { get; set; } = new List<Phase>();
    }
}
