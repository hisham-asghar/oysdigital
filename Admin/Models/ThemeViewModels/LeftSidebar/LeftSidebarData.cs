using Generics.DataModels.Constants;
using LayerBao;
using System.Collections.Generic;

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
                new LeftSidebarDto("Platforms", "/Platform", "delicious"),
                new LeftSidebarDto("Users", "/Users", "persons"),
            };
            return data;
        }

        public static List<LeftSidebarDto> GetData(string userId)
        {
            var user = AspNetUserRolesBao.GetByUserId(userId);
            var data = new List<LeftSidebarDto>();
            if (user != null)
            {
                if (user.NormalizedRoles.Contains(UserRoles.Admin.ToUpper()) || user.NormalizedRoles.Contains(UserRoles.Hr.ToUpper()))
                {
                    data.Add(new LeftSidebarDto("Dashboard", "/", "home"));
                    data.Add(new LeftSidebarDto("Customers", "/Customer", "accounts"));
                    data.Add(new LeftSidebarDto("Projects", "/Project", "assignment"));
                    data.Add(new LeftSidebarDto("Mobiles", "/Mobile", "smartphone-android"));
                    data.Add(new LeftSidebarDto("Platforms", "/Platform", "delicious"));
                    data.Add(new LeftSidebarDto("Labels", "/LabelType", "label"));
                    data.Add(new LeftSidebarDto("Users", "/User", "accounts"));

                }
                else if (user.NormalizedRoles.Contains(UserRoles.Designer.ToUpper()) || user.NormalizedRoles.Contains(UserRoles.Scheduler.ToUpper()))
                {
                    data.Add(new LeftSidebarDto("Dashboard", "/", "home"));
                    data.Add(new LeftSidebarDto("Projects", "/Project", "assignment"));
                }

            }
            var list = new List<LeftSidebarDto>();
            foreach (var item in data)
            {
                if (!list.Contains(item))
                {
                    list.Add(item);
                }
            }
            return list;
        }
    }
}
