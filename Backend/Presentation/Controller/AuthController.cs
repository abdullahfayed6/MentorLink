using Microsoft.AspNetCore.Mvc;
using Service;
using ServiceAbstraction;
using Shared.DataTransferObjects;

namespace MentorLink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("signup")]
        public async Task<ActionResult<AuthResponseDto>> SignUp([FromBody] SignUpDto signUpDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new AuthResponseDto
                {
                    Success = false,
                    Message = "Invalid input data",
                });
            }

            var result = await _authService.SignUpAsync(signUpDto);
            
            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("signin")]
        public async Task<ActionResult<AuthResponseDto>> SignIn([FromBody] SignInDto signInDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new AuthResponseDto
                {
                    Success = false,
                    Message = "Invalid input data",
                });
            }

            var result = await _authService.SignInAsync(signInDto);
            
            if (!result.Success)
            {
                return Unauthorized(result);
            }

            return Ok(result);
        }

        [HttpPost("refresh-token")]
        public async Task<ActionResult<AuthResponseDto>> RefreshToken([FromBody] RefreshTokenDto refreshTokenDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new AuthResponseDto
                {
                    Success = false,
                    Message = "Invalid input data",
                });
            }

            var result = await _authService.RefreshTokenAsync(refreshTokenDto.RefreshToken);
            
            if (!result.Success)
            {
                return Unauthorized(result);
            }

            return Ok(result);
        }

        [HttpPost("logout")]
        public async Task<ActionResult> Logout([FromBody] RefreshTokenDto refreshTokenDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new { Success = false, Message = "Invalid input data" });
            }

            var result = await _authService.RevokeTokenAsync(refreshTokenDto.RefreshToken);
            
            if (!result)
            {
                return BadRequest(new { Success = false, Message = "Invalid refresh token" });
            }

            return Ok(new { Success = true, Message = "Logged out successfully" });
        }

        [HttpPost("forgot-password")]
        public async Task<ActionResult<PasswordResetResponseDto>> ForgotPassword([FromBody] ForgotPasswordDto forgotPasswordDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new PasswordResetResponseDto
                {
                    Success = false,
                    Message = "Invalid input data"
                });
            }

            var result = await _authService.ForgotPasswordAsync(forgotPasswordDto);
            
            // Always return success to prevent email enumeration
            return Ok(result);
        }

        [HttpPost("verify-code")]
        public async Task<ActionResult<PasswordResetResponseDto>> VerifyCode([FromBody] VerifyCodeDto verifyCodeDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new PasswordResetResponseDto
                {
                    Success = false,
                    Message = "Invalid input data"
                });
            }

            var result = await _authService.VerifyCodeAsync(verifyCodeDto);
            
            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("reset-password")]
        public async Task<ActionResult<PasswordResetResponseDto>> ResetPassword([FromBody] ResetPasswordDto resetPasswordDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new PasswordResetResponseDto
                {
                    Success = false,
                    Message = "Invalid input data"
                });
            }

            var result = await _authService.ResetPasswordAsync(resetPasswordDto);
            
            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }
    }
}
