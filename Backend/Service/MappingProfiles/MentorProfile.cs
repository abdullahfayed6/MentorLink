using AutoMapper;
using DomainLayer.Models;
using Shared.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.MappingProfiles
{
    public class MentorProfile : Profile
    {
        public MentorProfile()
        {
            CreateMap<Mentor, MentorDto>()
                .ForMember(dis => dis.PictureUrl, option => option.MapFrom<PictureUrlResolver>()) 
                .ForMember(dis => dis.Skills, options => options.MapFrom(src => src.Skills.Select(x => x.Name)))
                .ForMember(dis => dis.Tags, options => options.MapFrom(src => src.Tags.Select(x => x.Name)))
                .ForMember(dis => dis.RateCount, option => option.MapFrom(src => src.Rates.Count))
                .ForMember(dis => dis.AverageRate, options => options.MapFrom(src => src.Rates.Any() ? src.Rates.Average(r => r.Rating) : 0));

               
        }
    }
}
