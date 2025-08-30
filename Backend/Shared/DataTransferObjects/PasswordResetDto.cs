using System.ComponentModel.DataAnnotations;

namespace Shared.DataTransferObjects
{
    public class ForgotPasswordDto
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid email address")]
        [StringLength(100, ErrorMessage = "Email cannot exceed 100 characters")]
        public string Email { get; set; } = null!;
    }

    public class VerifyCodeDto
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid email address")]
        [StringLength(100, ErrorMessage = "Email cannot exceed 100 characters")]
        public string Email { get; set; } = null!;

        [Required]
        [StringLength(5, MinimumLength = 5, ErrorMessage = "Reset code must be exactly 5 digits")]
        [RegularExpression(@"^[0-9]{5}$", ErrorMessage = "Reset code must contain exactly 5 digits")]
        public string ResetCode { get; set; } = null!;
    }

    public class ResetPasswordDto
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid email address")]
        [StringLength(100, ErrorMessage = "Email cannot exceed 100 characters")]
        public string Email { get; set; } = null!;

        [Required]
        [StringLength(5, MinimumLength = 5, ErrorMessage = "Reset code must be exactly 5 digits")]
        [RegularExpression(@"^[0-9]{5}$", ErrorMessage = "Reset code must contain exactly 5 digits")]
        public string ResetCode { get; set; } = null!;

        [Required]
        [StringLength(100, MinimumLength = 8, ErrorMessage = "Password must be between 8 and 100 characters")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$",
            ErrorMessage = "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character (@$!%*?&)")]
        public string NewPassword { get; set; } = null!;

        [Required]
        [Compare("NewPassword", ErrorMessage = "Passwords do not match")]
        public string ConfirmPassword { get; set; } = null!;
    }

    public class PasswordResetResponseDto
    {
        public bool Success { get; set; }
        public string Message { get; set; } = null!;
        public DateTime? ExpiresAt { get; set; }
    }
}
