using System;
using System.Collections.Generic;
using System.Text;
using Generics.Common.Attributes;

namespace Generics.DataModels.AdminModels
{
    public class ProjectTask:BaseEntity
    {
        public int TaskTypeId { get; set; }
        [Ignore]
        public string TaskType { get; set; }
        [Ignore]
        public string FrequencyType { get; set; }
        
        public int Frequency { get; set; }
        public int FrequencyTypeId { get; set; }
        public long ProjectId { get; set; }
        [Ignore]
        public string ProjectName { get; set; }
        public List<ProjectTaskScheduling> ProjectTaskScheduling { get; set; }
        public List<ProjectPlatforms> ProjectPlatforms { get; set; }
    }
}
