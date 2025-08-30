using System.Threading.Tasks;

namespace ServiceAbstraction
{
    public interface ITraineeService
    {
        Task<bool> DeleteAsync(int traineeId);
    }
}


