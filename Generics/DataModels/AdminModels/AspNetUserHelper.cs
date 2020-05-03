using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Generics.Data;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Generics.DataModels.AdminModels
{
    public static class AspNetUserHelper
    {
        private static UserManager<ApplicationUser> _userManager;

        public static List<ApplicationUser> GetAll()
        {
            return _userManager.Users.ToList();
        }
    }
}
