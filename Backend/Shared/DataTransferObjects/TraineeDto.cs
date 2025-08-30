using DomainLayer.Models;

namespace Shared.DataTransferObjects
{
    public class TraineeDto
    {
        public int TraineeId { get; set; }
        public string Name { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? PictureUrl { get; set; }
        public string Phone { get; set; } = null!;
        public Level Level { get; set; }
        public bool IsUpdated { get; set; }
        public bool IsSubscribed { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? LastLoginAt { get; set; }
    }
}
