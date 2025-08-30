using Microsoft.AspNetCore.Mvc;
using ServiceAbstraction;
using Shared;
using Shared.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Presentation.Controller
{
    [ApiController]
    [Route("api/[Controller]")]
    public class MentorController(IServiceManager _serviceManager) : ControllerBase
    {
        [HttpGet]
        public async Task<ActionResult<PaginatedResult<MentorDto>>> GetAllMentors([FromQuery] MentorsQueryParam queryParams)
        {
            var mentors = await _serviceManager.MentorService.GetAllMentorsAsync(queryParams);
            return Ok(mentors);
        }
        [HttpGet("{id}")]
        public async Task<ActionResult<MentorDto>> GetMentorById(int id)
        {
            var mentor = await _serviceManager.MentorService.GetMentorById(id);
            return Ok(mentor);
        }
    }
}
