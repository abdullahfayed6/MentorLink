using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Presistence.Data.Configs
{
    internal class PhaseConfig : IEntityTypeConfiguration<Phase>
    {
        public void Configure(EntityTypeBuilder<Phase> builder)
        {
            builder
            .HasOne(p => p.RoadMap)
            .WithMany(r => r.Phases)
            .HasForeignKey(p => p.RoadMapId)
            .OnDelete(DeleteBehavior.Cascade);

            builder
            .HasMany(p => p.Skills_Gained)
            .WithMany(s => s.Phases)
            .UsingEntity(j => j.ToTable("PhaseGainedSkills"));

            builder
            .HasMany(p => p.Prerequisites)
            .WithMany(pr => pr.Phases)
            .UsingEntity(j => j.ToTable("PhasePrerequisites"));

            /* builder
                 .Property(sk=>sk.Skills_Gained)
                 .HasColumnType("nvarchar(max)")
                 .HasConversion(
                     v => JsonSerializer.Serialize(v, (JsonSerializerOptions)null),
                     v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions)null)
                 );*/
        }
    }
}
