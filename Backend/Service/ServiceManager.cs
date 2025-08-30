using AutoMapper;
using DomainLayer.Contracts;
using ServiceAbstraction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public class ServiceManager(IUnitOfWork unitOfWork, IMapper mapper) : IServiceManager
    {
        private readonly Lazy<IMentorService> _LazyMentorService = new Lazy<IMentorService>(() => new MentorService(unitOfWork, mapper));
        public IMentorService MentorService => _LazyMentorService.Value;
        private readonly Lazy<ITraineeService> _LazyTraineeService = new Lazy<ITraineeService>(() => new TraineeService(unitOfWork));
        public ITraineeService TraineeService => _LazyTraineeService.Value;
        private readonly Lazy<IRoadmapAppService> _LazyRoadmapAppService = new Lazy<IRoadmapAppService>(() => new RoadmapAppService(unitOfWork, new RoadmapService()));
        public IRoadmapAppService RoadmapAppService => _LazyRoadmapAppService.Value;
    }
}
