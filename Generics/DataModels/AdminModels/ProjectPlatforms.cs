using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class ProjectPlatforms:BaseEntity
    {
        public string Link { get; set; }
        public long MobileSpaceId { get; set; }
        public long PlatformId { get; set; }
        public long ProjectId { get; set; }
        public bool IsActive { get; set; }
        [Ignore]
        public string ProjectName { get; set; }
        [Ignore]
        public string PlatformName { get; set; }
        [Ignore]
        public string PlatformIcon { get; set; }
        [Ignore]
        public string MobileSpaceName { get; set; }

    }
    public class ProjectPlaformCreateView:ProjectPlatforms
    {
        public int PostCount { get; set; }
        public int StoriesCount { get; set; }
        public int PostType { get; set; }
        public int StoriesType { get; set; }
    }
    
}
