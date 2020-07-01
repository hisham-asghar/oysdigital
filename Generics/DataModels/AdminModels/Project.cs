using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Generics.Common.Attributes;
using Microsoft.CodeAnalysis;

namespace Generics.DataModels.AdminModels
{
    public class Project:BaseEntity
    {
        public string Guid { get; set; }
        public string Name { get; set; }
        public long CustomerId { get; set; }
        [Ignore]
        public string CustomerName { get; set; }
        public bool IsActive { get; set; }
        public long MobileSpaceId { get; set; }
        [Ignore]
        public string MobileSpaceName { get; set; }
        [Ignore]
        public string MobileName { get; set; }

        [Ignore]
        public string Designer { get; set; }
        [Ignore]
        public string Scheduler { get; set; }
        [Ignore]
        public int IssueCount { get; set; }
        [Ignore]
        public int DoneCount { get; set; }
        [Ignore]
        public int NotDoneCount { get; set; }

        public List<ProjectMembers> ProjectMembers { get; set; }
        public List<ProjectAlertMessage> ProjectAlertMessages { get; set; }
        public List<ProjectNotes> ProjectNotes { get; set; }
        public List<ProjectPlatforms> ProjectPlatforms { get; set; }
        public List<ProjectTask> projectTasks { get; set; }
    }
}
