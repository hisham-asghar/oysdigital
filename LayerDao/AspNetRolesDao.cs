using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Text;

namespace LayerDao
{
    public static class AspNetRolesDao
    {
        public static List<AspNetRoles> GetAll()
        {
            return TableConstants.AspNetRoles.SelectAll<AspNetRoles>();
        }
        public static AspNetRoles GetById(string id)
        {
            var where = $"Id='{id}'";
            return TableConstants.AspNetRoles.Select<AspNetRoles>(where);
        }
        public static bool Insert(AspNetRoles aspNetRoles)
        {
            return aspNetRoles.Insert(TableConstants.AspNetRoles) > 0;
        }
        public static bool Update(AspNetRoles aspNetRoles)
        {
            return aspNetRoles.Update(TableConstants.AspNetRoles, aspNetRoles.Id) > 0;
        }
        public static bool Delete(string id)
        {
            return TableConstants.AspNetRoles.Delete(id);
        }
    }
}
