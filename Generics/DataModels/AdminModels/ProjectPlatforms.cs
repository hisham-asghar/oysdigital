using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Generics.DataModels.AdminModels
{
    public class ProjectPlatforms
    {
        
        public long ProjectPlatformsId { get; set; }
        public string PlatformLink { get; set; }
        public long ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string IconUrl { get; set; }
        public long PlatformId { get; set; }
        public string PlatformName { get; set; }
        public int PostPerDay { get; set; }
        public int PostPerWeek { get; set; }
        public int PostPerMonth { get; set; }
        public DateTime PostSchedulingTime { get; set; }
        public int StoriesPerDay { get; set; }
        public int StoriesPerWeek { get; set; }
        public int StoriesPerMonth { get; set; }
        public DateTime StoriesSchedulingTime { get; set; }
        public long MobileSpacesId { get; set; }
        public string SpaceName { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime OnCreated { get; set; }
        public DateTime OnModified { get; set; }
        public int PostsQuantity { get; set; }
        public int StoriesQuantity { get; set; }
        
    }
}
