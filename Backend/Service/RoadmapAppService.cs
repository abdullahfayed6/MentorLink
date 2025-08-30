using DomainLayer.Contracts;
using DomainLayer.Models;
using Microsoft.EntityFrameworkCore;
using ServiceAbstraction;
using Shared.DataTransferObjects;

namespace Service
{
    public class RoadmapAppService(IUnitOfWork unitOfWork, IRoadmapService roadmapService) : IRoadmapAppService
    {
        public async Task<RoadmapCreatedDto?> CreateAsync(int traineeId, Roadmap roadmap)
        {
            var trainee = await unitOfWork.Trainees.GetByIdAsync(traineeId);
            if (trainee == null) return null;

            roadmapService.GenerateHtml(roadmap);

            var entity = new RoadMap
            {
                Title = roadmap.Title,
                Description = roadmap.Description,
                Html = roadmap.Html,
                DifficultyLevel = Enum.TryParse<Level>(roadmap.DifficultyLevel, true, out var lvl) ? lvl : Level.Beginner,
                Total_Months = roadmap.TotalDurationMonths,
                Total_Hours = roadmap.TotalHours,
                TraineeId = traineeId
            };

            await unitOfWork.GetRepository<RoadMap>().AddAsync(entity);
            await unitOfWork.SaveChangesAsync();

            return new RoadmapCreatedDto { Id = entity.RoadMapId, Html = roadmap.Html! };
        }

        public async Task<RoadmapViewDto?> GetByIdAsync(int id)
        {
            var road = await unitOfWork.GetRepository<RoadMap>().GetByIdAsync(id);
            if (road == null) return null;
            return new RoadmapViewDto { Id = road.RoadMapId, Title = road.Title, Html = road.Html };
        }
    }
}


