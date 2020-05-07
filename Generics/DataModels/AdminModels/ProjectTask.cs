using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.AdminModels
{
    public class ProjectTask:BaseEntity
    {
        public int TaskTypeId { get; set; }
        public int Frequency { get; set; }
        public int FrequencyTypeId { get; set; }
        public long ProjectId { get; set; }
        public List<ProjectTaskScheduling> ProjectTaskScheduling { get; set; }
        public List<ProjectPlatforms> ProjectPlatforms { get; set; }
    }
}
