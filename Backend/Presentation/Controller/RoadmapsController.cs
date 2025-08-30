using Microsoft.AspNetCore.Mvc;
using ServiceAbstraction;
using Shared.DataTransferObjects;

namespace MentorLink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RoadmapsController : ControllerBase
    {
        private readonly IServiceManager _services;

        public RoadmapsController(IServiceManager services)
        {
            _services = services;
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromQuery] int traineeId, [FromBody] Roadmap roadmap)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);
            var result = await _services.RoadmapAppService.CreateAsync(traineeId, roadmap);
            if (result == null) return NotFound(new { message = "Trainee not found" });
            return CreatedAtAction(nameof(GetById), new { id = result.Id }, result);
        }

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var result = await _services.RoadmapAppService.GetByIdAsync(id);
            if (result == null) return NotFound();
            return Ok(result);
        }
    }
}

