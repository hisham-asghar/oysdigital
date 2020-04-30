using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class ProjectPlatforms:BaseEntity
    {
        public string PlatformLink { get; set; }
        public long ProjectId { get; set; }
        public long PlatformId { get; set; }
        public int PostPerDay { get; set; }
        public int PostPerWeek { get; set; }
        public int PostPerMonth { get; set; }
        public DateTime PostSchedulingTime { get; set; }
        public int StoriesPerDay { get; set; }
        public int StoriesPerWeek { get; set; }
        public int StoriesPerMonth { get; set; }
        public DateTime StoriesSchedulingTime { get; set; }
        public long MobileSpaceId { get; set; }
        public bool IsActive { get; set; }
        
    }
    public class ProjectPlaformCreateView:ProjectPlatforms
    {
        public int PostCount { get; set; }
        public int StoriesCount { get; set; }
        public int PostType { get; set; }
        public int StoriesType { get; set; }
    }
    
}
