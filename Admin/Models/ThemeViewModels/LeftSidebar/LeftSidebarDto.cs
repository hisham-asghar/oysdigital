using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.Models.ThemeViewModels.LeftSidebar
{
    public class LeftSidebarDto
    {
        public string Title { get; set; }
        public string ClassName { get; set; }
        public string ReferenceLink { get; set; }
        public bool IsNewTabLink { get; set; }
        public List<LeftSidebarDto> SubItems { get; set; }
        public LeftSidebarDto(string title = null, string referenceLink = null, string className = null,  bool isNewTabLink = false)
        {
            if (SubItems == null) SubItems = new List<LeftSidebarDto>();
            if (Title == null) Title = title;
            if (ClassName == null) ClassName = className;
            if (ReferenceLink == null) ReferenceLink = referenceLink;
            if (IsNewTabLink == false) IsNewTabLink = isNewTabLink;

        }
    }
}
