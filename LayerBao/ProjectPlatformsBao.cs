﻿using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels.AdminModels;
using LayerDao;

namespace LayerBao
{
    public class ProjectPlatformsBao
    {
        public static List<ProjectPlatforms> GetAll()
        {
            return ProjectPlatformsDao.GetAll();
        }
        public static ProjectPlatforms GetById(long id)
        {
            return ProjectPlatformsDao.GetById(id);
        }
        public static List<ProjectPlatforms> GetByProjectId(long id)
        {
            return ProjectPlatformsDao.GetByProjectId(id);
        }
        public static long Insert(ProjectPlatforms projectplatforms)
        {
            return ProjectPlatformsDao.Insert(projectplatforms);
        }
        public static bool Update(ProjectPlatforms projectplatforms)
        {
            return ProjectPlatformsDao.Update(projectplatforms);
        }
        public static bool Delete(long id)
        {
            return ProjectPlatformsDao.Delete(id);
        }
    }
}
