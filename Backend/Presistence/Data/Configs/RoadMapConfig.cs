using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;

namespace Presistence.Data.Configs
{
    public class RoadMapConfig : IEntityTypeConfiguration<RoadMap>
    {
        public void Configure(Microsoft.EntityFrameworkCore.Metadata.Builders.EntityTypeBuilder<RoadMap> builder)
        {
            builder
            .HasOne(r => r.Trainee)
            .WithOne(t => t.RoadMap)
            .HasForeignKey<RoadMap>(r => r.TraineeId)
            .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
