using Shared;
using Shared.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceAbstraction
{
    public interface IMentorService
    {
        Task<PaginatedResult<MentorDto>> GetAllMentorsAsync(MentorsQueryParam queryParams);
        Task<IEnumerable<MentorDto>> GetAllMentorsAsync();
        Task<MentorDto> GetMentorById(int id);
    }
}
