using Admin.Models.ThemeViewModels.LeftSidebar;
using System.Collections.Generic;

namespace Admin.Models.ThemeViewModels
{
    public class ThemeData
    {
        //public static List<LeftSidebarDto> leftSidebarDtos = LeftSidebarData.GetData();
        public static List<LeftSidebarDto> GetLeftSidebarDtos(string userId)
        {

            return LeftSidebarData.GetData(userId);

        }
        public static List<LeftSidebarDto> GetLeftSidebarDtos(bool isAdminOrHr)
        {

            return LeftSidebarData.GetData(isAdminOrHr);

        }
    }
}
