using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;
using LayerDao.DatabaseInfo;

namespace LayerDao
{
    public class ProjectPlatformsDao
    {
        public static List<ProjectPlatforms> GetAll()
        {
            var query = $"SELECT  ProjectPlatforms.*, Platform.Name as PlatformName,Project.Name as ProjectName  FROM [dbo].[ProjectPlatforms] Join dbo.Platform on ProjectPlatforms.PlatformId=Platform.Id Join dbo.Project on ProjectPlatforms.ProjectId=Project.Id ;";
            return QueryExecutor.List<ProjectPlatforms>(query);
        }
        public static ProjectPlatforms GetById(long id)
        {
            var query = $"SELECT  ProjectPlatforms.*, Platform.Name as PlatformName,Platform.IconClass as PlatformIcon,Project.Name as ProjectName FROM [dbo].[ProjectPlatforms] Join dbo.Platform on ProjectPlatforms.PlatformId=Platform.Id Join dbo.Project on ProjectPlatforms.ProjectId=Project.Id where ProjectPlatforms.Id={id};";
            return QueryExecutor.FirstOrDefault<ProjectPlatforms>(query);
        }
        public static List<ProjectPlatforms> GetByProjectId(long id)
        {
            var query = $"SELECT  ProjectPlatforms.*, Platform.Name as PlatformName,Platform.IconClass as PlatformIcon,Project.Name as ProjectName FROM [dbo].[ProjectPlatforms] Join dbo.Platform on ProjectPlatforms.PlatformId=Platform.Id Join dbo.Project on ProjectPlatforms.ProjectId=Project.Id where ProjectId={id};";
              return QueryExecutor.List<ProjectPlatforms>(query);
        }
        public static bool Insert(ProjectPlatforms projectplatforms)
        {
            return projectplatforms.Insert(TableConstants.ProjectPlatforms) > 0;
        }
        public static bool Update(ProjectPlatforms projectplatforms)
        {
            return projectplatforms.Update(TableConstants.ProjectPlatforms, (int)projectplatforms.Id) > 0;
        }
        public static bool Delete(long id)
        {
            return TableConstants.ProjectPlatforms.Delete((int)id);
        }
    }
}
