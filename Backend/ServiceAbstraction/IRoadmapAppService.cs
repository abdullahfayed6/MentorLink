using Shared.DataTransferObjects;

namespace ServiceAbstraction
{
    public interface IRoadmapAppService
    {
        Task<RoadmapCreatedDto?> CreateAsync(int traineeId, Roadmap roadmap);
        Task<RoadmapViewDto?> GetByIdAsync(int id);
    }
}


