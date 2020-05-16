using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Generics.DataModels.Constants;
using Generics.WebHelper.Extensions;
using LayerBao;

namespace Admin.Models.ThemeViewModels.LeftSidebar
{
    public class LeftSidebarData
    {
        public static List<LeftSidebarDto> GetData()
        {
            
            var  data = new List<LeftSidebarDto>
            {
                new LeftSidebarDto("Dashboard", "/", "home"),
                new LeftSidebarDto("Customers", "/Customer", "accounts"),
                new LeftSidebarDto("Projects", "/Project", "assignment"),
                new LeftSidebarDto("Mobiles", "/Mobile", "smartphone-android"),
                new LeftSidebarDto("Platforms", "/Platform", "delicious"),
                new LeftSidebarDto("Roles", "/AspNetRoles", "delicious"),
                new LeftSidebarDto("Assign Roles", "/AspNetUserRoles", "delicious")
            };
            return data;
        }

        public static List<LeftSidebarDto> GetData(string userId)
        {
            var user = AspNetUserRolesBao.GetByUserId(userId);
            var data = new List<LeftSidebarDto>();
            if (user.Roles != null)
            {
                foreach (var item in user.Roles)
                {
                    if (item == UserRoles.Admin.ToUpper() || item == UserRoles.Hr.ToUpper())
                    {
                        data.Add(new LeftSidebarDto("Dashboard", "/", "home"));
                        data.Add(new LeftSidebarDto("Customers", "/Customer", "accounts"));
                        data.Add(new LeftSidebarDto("Projects", "/Project", "assignment"));
                        data.Add(new LeftSidebarDto("Mobiles", "/Mobile", "smartphone-android"));
                        data.Add(new LeftSidebarDto("Platforms", "/Platform", "delicious"));
                        data.Add(new LeftSidebarDto("Roles", "/AspNetRoles", "delicious"));
                        data.Add(new LeftSidebarDto("Assign Roles", "/AspNetUserRoles", "delicious"));
                    }
                    if (item == UserRoles.Designer.ToUpper() || item == UserRoles.Scheduler.ToUpper())
                    {
                        data.Add(new LeftSidebarDto("Dashboard", "/", "home"));
                        data.Add(new LeftSidebarDto("Projects", "/Project", "assignment"));
                    }
                }

            }
            return data;
        }
     }
}
