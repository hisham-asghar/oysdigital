﻿using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectMemberTypeDao
    {
        public static List<ProjectMemberTypes> GetAll()
        {
            return TableConstants.ProjectMemberTypes.SelectAll<ProjectMemberTypes>();
        }
        public static ProjectMemberTypes GetById(long id)
        {
            return TableConstants.ProjectMemberTypes.Select<ProjectMemberTypes>((int)id);
        }
        public static bool Insert(ProjectMemberTypes projectmembertype)
        {
            return projectmembertype.Insert(TableConstants.ProjectMemberTypes) > 0;
        }
        public static bool Update(ProjectMemberTypes projectmembertype)
        {
            return projectmembertype.Update(TableConstants.ProjectMemberTypes, (int)projectmembertype.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectMemberTypes.Delete((int)id);
        }
    }
}
