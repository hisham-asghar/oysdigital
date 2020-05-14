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
            var user = RoleManagerBao.GetUserById();
            var data = new List<LeftSidebarDto>();
            UserRoles.IsUserInRole("Admin");
            if (user.RoleName != UserRoles.Admin)
            {
                data = new List<LeftSidebarDto>
            {
                new LeftSidebarDto("Dashboard", "/", "home"),
                new LeftSidebarDto("Projects", "/Project", "assignment"),
            };
            }
            else
            {
                data = new List<LeftSidebarDto>
            {
                new LeftSidebarDto("Dashboard", "/", "home"),
                new LeftSidebarDto("Customers", "/Customer", "accounts"),
                new LeftSidebarDto("Projects", "/Project", "assignment"),
                new LeftSidebarDto("Mobiles", "/Mobile", "smartphone-android"),
                new LeftSidebarDto("Platforms", "/Platform", "delicious")
            };
            }
            return data;
        }
    }
}
