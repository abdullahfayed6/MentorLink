using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace MentorLink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ProtectedController : ControllerBase
    {
        [HttpGet("profile")]
        public IActionResult GetProfile()
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var email = User.FindFirst(ClaimTypes.Email)?.Value;
            var name = User.FindFirst("Name")?.Value;
            var phone = User.FindFirst("Phone")?.Value;
            var level = User.FindFirst("Level")?.Value;

            return Ok(new
            {
                Message = "This is a protected endpoint",
                User = new
                {
                    UserId = userId,
                    Email = email,
                    Name = name,
                    Phone = phone,
                    Level = level
                }
            });
        }

        [HttpGet("test")]
        public IActionResult Test()
        {
            return Ok(new { Message = "Authentication is working! You have access to this protected endpoint." });
        }
    }
}
