using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.CodeAnalysis;

namespace Generics.DataModels.AdminModels
{
    public class Project:BaseEntity
    {
        public string Guid { get; set; }
        public string Name { get; set; }
        public long CustomerId { get; set; }
        public bool IsActive { get; set; }
        public List<ProjectMembers> ProjectMembers { get; set; }
        public List<ProjectAlertMessage> ProjectAlertMessages { get; set; }
        public List<ProjectNotes> ProjectNotes { get; set; }
        public List<Platform> Platforms { get; set; }
        public List<ProjectTask> projectTasks { get; set; }
    }
}
