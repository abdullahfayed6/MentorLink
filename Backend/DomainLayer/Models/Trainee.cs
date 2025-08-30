using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;

namespace DomainLayer.Models
{
    public enum Level
    {
        Beginner,
        Intermediate,
        Advanced
    }
    public class Trainee
    {
        public int TraineeId { get; set; }

        [Required]
        [MaxLength(50)]
        public string Name { get; set; } = null!;

        [Required]
        [MaxLength(100)]
        [EmailAddress]
        public string Email { get; set; } = null!;
        
        [MaxLength(200)]
        public string? PictureUrl { get; set; }
        
        [Required]
        [MaxLength(255)]
        public string PasswordHash { get; set; } = null!;
        
        [Required]
        [StringLength(11, MinimumLength = 11, ErrorMessage = "Phone number must be exactly 11 digits.")]
        public string Phone { get; set; } = null!;

        public Level Level { get; set; } = Level.Beginner;

        public bool IsUpdated { get; set; } = false;

        public bool IsSubscribed { get; set; } = false;
        
        [MaxLength(100)]
        public string? SessionId { get; set; }
        
        [MaxLength(500)]
        public string? RefreshToken { get; set; }
        
        public DateTime? RefreshTokenExpiryTime { get; set; }
        
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
        public DateTime? LastLoginAt { get; set; }
        
        public ICollection<Language> PreferredLanguages { get; set; } = new List<Language>();
        public ICollection<FocusArea> FocusAreas { get; set; } = new List<FocusArea>();
        public ICollection<Rate> Rates { get; set; } = new List<Rate>();

        public RoadMap? RoadMap { get; set; }
        public int? MentorId { get; set; }
        public Mentor? Mentor { get; set; }
    }

}
