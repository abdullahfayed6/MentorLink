using System.ComponentModel.DataAnnotations;

namespace DomainLayer.Models
{
    public class Language
    {
        public int LanguageId { get; set; }
        [MaxLength(50)]
        public string Name { get; set; } = null!;

        public ICollection<Trainee> Trainees { get; set; } = new List<Trainee>();
    }

}
