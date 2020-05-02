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
        public List<ProjectPlatforms> ProjectPlatforms { get; set; }
        public List<ProjectMembers> ProjectMembers { get; set; }
        public List<MobileSpaces> MobileSpaces { get; set; }
    }
}
