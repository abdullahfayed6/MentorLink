using Microsoft.AspNetCore.Mvc;
using ServiceAbstraction;

namespace MentorLink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TraineesController : ControllerBase
    {
        private readonly IServiceManager _services;

        public TraineesController(IServiceManager services)
        {
            _services = services;
        }

        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete(int id)
        {
            var ok = await _services.TraineeService.DeleteAsync(id);
            if (!ok) return NotFound();
            return NoContent();
        }
    }
}


