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
    public class CareerOutcomeConfig : IEntityTypeConfiguration<CareerOutcome>
    {
        public void Configure(EntityTypeBuilder<CareerOutcome> builder)
        {
            builder
            .HasOne(c => c.RoadMap)
            .WithMany(r => r.Career_Outcomes)
            .HasForeignKey(c => c.RoadMapId) 
            .OnDelete(DeleteBehavior.Cascade);
        }
    }
    
}
