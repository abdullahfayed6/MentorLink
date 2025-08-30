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
    public class RecommendedCourseConfig : IEntityTypeConfiguration<RecommendedCourse>
    {
        public void Configure(EntityTypeBuilder<RecommendedCourse> builder)
        {
            builder
            .HasOne(rc => rc.Phase)
            .WithMany(p => p.Recommended_Courses)
            .HasForeignKey(rc => rc.PhaseId)
            .OnDelete(DeleteBehavior.Cascade);

        }
    }
}
