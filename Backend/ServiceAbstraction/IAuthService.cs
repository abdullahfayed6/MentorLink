using Shared.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public interface IAuthService
    {
        Task<AuthResponseDto> SignUpAsync(SignUpDto signUpDto);
        Task<AuthResponseDto> SignInAsync(SignInDto signInDto);
        Task<AuthResponseDto> RefreshTokenAsync(string refreshToken);
        Task<bool> RevokeTokenAsync(string refreshToken);
        Task<PasswordResetResponseDto> ForgotPasswordAsync(ForgotPasswordDto forgotPasswordDto);
        Task<PasswordResetResponseDto> VerifyCodeAsync(VerifyCodeDto verifyCodeDto);
        Task<PasswordResetResponseDto> ResetPasswordAsync(ResetPasswordDto resetPasswordDto);
    }
}
