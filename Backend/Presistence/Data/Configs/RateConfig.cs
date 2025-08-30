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
    internal class RateConfig : IEntityTypeConfiguration<Rate>
    {
        public void Configure(EntityTypeBuilder<Rate> builder)
        {
            builder.HasKey(r => new { r.TraineeId, r.MentorId });

            builder.HasOne(r => r.Trainee)
                .WithMany(t => t.Rates) 
                .HasForeignKey(r => r.TraineeId)
                .OnDelete(DeleteBehavior.Cascade);

                builder
                .HasOne(r => r.Mentor)
                .WithMany(m => m.Rates)
                .HasForeignKey(r => r.MentorId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
