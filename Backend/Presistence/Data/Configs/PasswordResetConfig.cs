using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Presistence.Data.Configs
{
    public class PasswordResetConfig : IEntityTypeConfiguration<PasswordReset>
    {
        public void Configure(EntityTypeBuilder<PasswordReset> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Email)
                .IsRequired()
                .HasMaxLength(100);

            builder.Property(x => x.ResetCode)
                .IsRequired()
                .HasMaxLength(5);

            builder.Property(x => x.CreatedAt)
                .IsRequired();

            builder.Property(x => x.ExpiresAt)
                .IsRequired();

            builder.Property(x => x.IsUsed)
                .IsRequired()
                .HasDefaultValue(false);

            // Create index on Email and ResetCode for faster lookups
            builder.HasIndex(x => new { x.Email, x.ResetCode });

            // Create index on ExpiresAt for cleanup operations
            builder.HasIndex(x => x.ExpiresAt);
        }
    }
}
