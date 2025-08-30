using AutoMapper;
using DomainLayer.Contracts;
using DomainLayer.Models;
using Service.Specifications;
using ServiceAbstraction;
using Shared;
using Shared.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public class MentorService(IUnitOfWork _unitOfWork, IMapper mapper) : IMentorService
    {
        public async Task<IEnumerable<MentorDto>> GetAllMentorsAsync()
        {
            var Repo = _unitOfWork.GetRepository<Mentor>();
            var mentors = await Repo.GetAllAsync();
            var mentorDtos = mapper.Map<IEnumerable<Mentor>,IEnumerable<MentorDto>>(mentors);
            return mentorDtos;

        }

        public async Task<PaginatedResult<MentorDto>> GetAllMentorsAsync(MentorsQueryParam queryParams)
        {
            var Repo = _unitOfWork.GetRepository<Mentor>();
            var specifications = new MentorSpecification(queryParams);
            var mentors = await Repo.GetAllAsync(specifications);
            var mentorDtos = mapper.Map<IEnumerable<Mentor>, IEnumerable<MentorDto>>(mentors);
            var mentorPageSize = mentorDtos.Count();
            var totalMentors = await Repo.CountAsync(new MentorCountSpecification(queryParams));
            return new PaginatedResult<MentorDto>(queryParams.PageIndex,mentorPageSize,totalMentors,mentorDtos);
        }

        public async Task<MentorDto> GetMentorById(int id)
        {
            var Repo = _unitOfWork.GetRepository<Mentor>();
            var specifications = new MentorSpecification(id);
            var mentor = await Repo.GetByIdAsync(specifications);
            var mentorDto = mapper.Map<Mentor, MentorDto>(mentor);
            // andle null case if mentor is not found Will be here later
            return mentorDto;
        }
    }
}
