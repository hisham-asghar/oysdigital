using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.Models.ThemeViewModels.LeftSidebar
{
    public class LeftSidebarData
    {
        public static List<LeftSidebarDto> GetData()
        {
            var data = new List<LeftSidebarDto>
            {
                new LeftSidebarDto("Dashboard", "/", "home"),
                new LeftSidebarDto("Customers", "/Customer", "accounts"),
                new LeftSidebarDto("Projects", "/Project", "assignment"),
                new LeftSidebarDto("Mobiles", "/Mobile", "smartphone-android"),
                new LeftSidebarDto("Platforms", "/Platform", "delicious")
            };
            return data;
        }
    }
}
