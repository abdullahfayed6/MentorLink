using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
namespace Presistence.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(AssemblyRef).Assembly);
            base.OnModelCreating(modelBuilder);
        }

        public DbSet<Tag> Tags { get; set; }
        public DbSet<Skill> Skills { get; set; }
        public DbSet<FocusArea> FocusAreas { get; set; }
        public DbSet<Language> Languages { get; set; }
        public DbSet<GainedSkill> GainedSkills { get; set; }
        public DbSet<RecommendedCourse> RecommendedCourses { get; set; }
        public DbSet<Prerequisite> Prerequisites { get; set; }
        public DbSet<CareerOutcome> CareerOutcomes { get; set; }
        public DbSet<RoadMap> RoadMaps { get; set; }
        public DbSet<Trainee> Trainees { get; set; }
        public DbSet<Mentor> Mentors { get; set; }
        public DbSet<Rate> Rates { get; set; }
        public DbSet<Phase> Phases { get; set; }
        public DbSet<PasswordReset> PasswordResets { get; set; }

    }
}
