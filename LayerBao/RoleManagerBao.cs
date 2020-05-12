﻿using System;
using System.Collections.Generic;
using System.Text;
using Generics.Data;
using LayerDao;

namespace LayerBao
{
    public static class RoleManagerBao
    {
        public static List<ApplicationUser> GetUsersByRoleName(string roleName)
        {
            return RoleManagerDao.GetUsersByRoleName(roleName);
        }
    }
}
