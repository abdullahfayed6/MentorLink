using Shared.DataTransferObjects;

namespace ServiceAbstraction
{
    public interface IRoadmapService
    {
        Roadmap GenerateHtml(Roadmap roadmap);
    }
}


