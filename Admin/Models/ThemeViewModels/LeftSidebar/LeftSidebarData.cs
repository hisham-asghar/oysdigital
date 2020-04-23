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
                new LeftSidebarDto("Dashboard", "#", "home"),
                new LeftSidebarDto("Our Profile", "#", "account"),
                new LeftSidebarDto("App", "#", "apps")
                {
                    SubItems = new List<LeftSidebarDto>
                    {
                        new LeftSidebarDto("Email", "#"),
                        new LeftSidebarDto("Chat Apps", "#"),
                        new LeftSidebarDto("Calendar", "#"),
                        new LeftSidebarDto("Contact", "#"),
                    }
                }
            };
            return data;
        }
    }
}
