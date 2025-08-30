using AutoMapper;
using AutoMapper.Execution;
using DomainLayer.Models;
using Microsoft.Extensions.Configuration;
using Shared.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.MappingProfiles
{
    public class PictureUrlResolver(IConfiguration _configuration) : IValueResolver<Mentor, MentorDto, string>
    {
        public string Resolve(Mentor source, MentorDto destination, string destMember, ResolutionContext context)
        {

            if (string.IsNullOrEmpty(source.PictureUrl))
                return string.Empty;
            else
            {
                var Url = $"{_configuration.GetSection("Url")["BaseUrl"]}{source.PictureUrl}";
                return Url;
            }
        }
    }
}
