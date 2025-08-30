using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;

namespace Presistence.Data.Configs
{
    public class TraineeConfig : IEntityTypeConfiguration<Trainee>
    {
        public void Configure(EntityTypeBuilder<Trainee> builder)
        {
            builder.HasOne(t => t.RoadMap)
                   .WithOne(rm => rm.Trainee)
                   .HasForeignKey<RoadMap>(RoadMap => RoadMap.TraineeId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(t=>t.Mentor)
                .WithMany(m=>m.Trainees)
                   .HasForeignKey(t=>t.MentorId)
                   .OnDelete(DeleteBehavior.SetNull);

            builder.HasMany(t => t.PreferredLanguages)
                   .WithMany(l => l.Trainees)
                   .UsingEntity(j => j.ToTable("TraineeLanguages"));

            builder.HasMany(t => t.FocusAreas)
                   .WithMany(f => f.Trainees)
                   .UsingEntity(j => j.ToTable("TraineeFocusAreas"));
        }
    }
}
