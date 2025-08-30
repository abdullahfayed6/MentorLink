using DomainLayer.Contracts;
using DomainLayer.Models;
using ServiceAbstraction;

namespace Service
{
    public class TraineeService(IUnitOfWork unitOfWork) : ITraineeService
    {
        public async Task<bool> DeleteAsync(int traineeId)
        {
            var trainee = await unitOfWork.Trainees.GetByIdAsync(traineeId);
            if (trainee == null) return false;
            unitOfWork.Trainees.Remove(trainee);
            await unitOfWork.SaveChangesAsync();
            return true;
        }
    }
}


