using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Shared.DataTransferObjects
{
    public class Roadmap
    {
        public Guid Id { get; set; }

        [Required]
        public string Title { get; set; } = null!;

        [Required]
        public string DifficultyLevel { get; set; } = null!;

        [Range(1, int.MaxValue)]
        public int TotalDurationMonths { get; set; }

        [Range(1, int.MaxValue)]
        public int TotalHours { get; set; }

        [Required]
        public string Description { get; set; } = null!;

        [MinLength(1)]
        public List<PhaseDto> Phases { get; set; } = new List<PhaseDto>();

        [MinLength(1)]
        public List<string> CareerOutcomes { get; set; } = new List<string>();

        public string? Html { get; set; }
    }

    public class RoadmapCreatedDto
    {
        public int Id { get; set; }
        public string Html { get; set; } = null!;
    }

    public class RoadmapViewDto
    {
        public int Id { get; set; }
        public string? Title { get; set; }
        public string? Html { get; set; }
    }

    public class PhaseDto
    {
        [Required]
        public string Title { get; set; } = null!;

        [Range(1, int.MaxValue)]
        public int Month { get; set; }

        [Required]
        public string Focus { get; set; } = null!;

        [MinLength(1)]
        public List<string> SkillsGained { get; set; } = new List<string>();

        public List<string>? Prerequisites { get; set; }

        public List<string>? RecommendedCourses { get; set; }

        [MinLength(1)]
        public List<WeekDto> Weeks { get; set; } = new List<WeekDto>();
    }

    public class WeekDto
    {
        [Range(1, int.MaxValue)]
        public int Week { get; set; }

        [Required]
        public string Focus { get; set; } = null!;

        [Range(1, int.MaxValue)]
        public int Hours { get; set; }

        [MinLength(1)]
        public List<string> Topics { get; set; } = new List<string>();

        [MinLength(1)]
        public List<string> Deliverables { get; set; } = new List<string>();
    }
}


