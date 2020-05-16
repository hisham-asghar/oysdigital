using Admin.Models.ThemeViewModels.LeftSidebar;
using Generics.DataModels.Constants;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin.Models.ThemeViewModels
{
    public class ThemeData
    {
        //public static List<LeftSidebarDto> leftSidebarDtos = LeftSidebarData.GetData();
        public static List<LeftSidebarDto> GetLeftSidebarDtos(string userId)
        {

            return LeftSidebarData.GetData(userId);

        }
    }
}
