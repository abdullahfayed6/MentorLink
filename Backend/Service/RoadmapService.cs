using System.Reflection;
using Scriban;
using Shared.DataTransferObjects;
using ServiceAbstraction;

namespace Service
{
    public class RoadmapService : IRoadmapService
    {
        private readonly string _templateText;

        public RoadmapService()
        {
            var assembly = Assembly.GetExecutingAssembly();
            var resourceName = assembly.GetManifestResourceNames()
                .FirstOrDefault(n => n.EndsWith("Templates.RoadmapTemplate.scriban"));
            if (resourceName == null)
            {
                throw new InvalidOperationException("Embedded template 'RoadmapTemplate.scriban' not found.");
            }

            using var stream = assembly.GetManifestResourceStream(resourceName)!;
            using var reader = new StreamReader(stream);
            _templateText = reader.ReadToEnd();
        }

        public Roadmap GenerateHtml(Roadmap roadmap)
        {
            var template = Template.Parse(_templateText);
            var html = template.Render(roadmap, memberRenamer: member => member.Name);
            roadmap.Html = html;
            return roadmap;
        }
    }
}