using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceAbstraction
{
    public interface IServiceManager
    {
        IMentorService MentorService { get; }
        ITraineeService TraineeService { get; }
        IRoadmapAppService RoadmapAppService { get; }
    }
}
