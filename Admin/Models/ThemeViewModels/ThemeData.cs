using Admin.Models.ThemeViewModels.LeftSidebar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.Models.ThemeViewModels
{
    public class ThemeData
    {
        public static List<LeftSidebarDto> leftSidebarDtos = LeftSidebarData.GetData();
    }
}
