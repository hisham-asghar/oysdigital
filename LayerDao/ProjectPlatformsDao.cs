using System;
using System.Collections.Generic;
using System.Text;
using Generics.DataModels;
using Generics.DataModels.AdminModels;
using Generics.Services.DatabaseService.AdoNet;

namespace LayerDao
{
    public class ProjectPlatformsDao
    {
        public static List<ProjectPlatforms> GetAll()
        {
            string sql = $"SELECT * FROM dbo.ProjectPlatforms JOIN dbo.Project ON ProjectPlatforms.ProjectId = Project.ProjectId Join dbo.Platform ON Platform.PlatformId=ProjectPlatforms.PlatformId Join dbo.MobileSpaces ON MobileSpaces.MobileSpacesId=ProjectPlatforms.MobileSpacesId;";
            return QueryExecutor.List<ProjectPlatforms>(sql);
        }
        public static ProjectPlatforms GetById(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectPlatforms JOIN dbo.Project ON ProjectPlatforms.ProjectId = Project.ProjectId Join dbo.Platform ON Platform.PlatformId=ProjectPlatforms.PlatformId Join dbo.MobileSpaces ON MobileSpaces.MobileSpacesId=ProjectPlatforms.MobileSpacesId WHERE ProjectPlatformsId = {Id};";
            return QueryExecutor.FirstOrDefault<ProjectPlatforms>(sql);
        }
        public static List<ProjectPlatforms> GetByProjectId(long Id)
        {
            string sql = $"SELECT * FROM dbo.ProjectPlatforms JOIN dbo.Project ON ProjectPlatforms.ProjectId = {Id} Join dbo.Platforms ON Platforms.PlatformId=ProjectPlatforms.PlatformId Join dbo.MobileSpaces ON MobileSpaces.MobileSpacesId=ProjectPlatforms.MobileSpacesId;";
            return QueryExecutor.List<ProjectPlatforms>(sql);
        }
        public static bool Insert(ProjectPlatforms c)
        {
            string sql = $"Insert Into dbo.ProjectPlatforms (PlatformLink,ProjectId,PlatformId,PostPerDay" +
                $",PostPerWeek,PostPerMonth,PostSchedulingTime,StoriesPerDay,StoriesPerWeek,StoriesPerMonth,StoriesSchedulingTime,MobileSpacesId" +
                $",IsActive,CreatedBy,ModifiedBy,OnCreated,OnModified)" +
                $" output INSERTED.ProjectPlatformsId as Result VALUES (" +
                $"'{c.PlatformLink}',{c.ProjectId},{c.PlatformId},{c.PostPerDay}," +
                $"{c.PostPerWeek},{c.PostPerMonth},'{c.PostSchedulingTime}',{c.StoriesPerDay}," +
                $"{c.StoriesPerWeek},{c.StoriesPerMonth},'{c.StoriesSchedulingTime}',{c.MobileSpacesId}," +
                $"'{c.IsActive}','{c.CreatedBy}','{c.ModifiedBy}','{c.OnCreated}','{c.OnModified}');";

            long data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result;
            return data == 0 ? true : false;
        }
        public static bool Update(ProjectPlatforms c)
        {
            string sql = $"UPDATE dbo.ProjectPlatforms Set PlatformLink='{c.PlatformLink}',ProjectId={c.ProjectId},PlatformId={c.PlatformId},PostPerDay={c.PostPerDay}" +
                $",PostPerWeek={c.PostPerWeek},PostPerMonth={c.PostPerMonth},PostSchedulingTime='{c.PostSchedulingTime}',StoriesPerDay={c.StoriesPerDay}" +
                $",StoriesPerWeek={c.StoriesPerWeek},StoriesPerMonth={c.StoriesPerMonth},StoriesSchedulingTime='{c.StoriesSchedulingTime}',MobileSpacesId={c.MobileSpacesId}" +
                $",IsActive='{c.IsActive}',ModifiedBy='{c.ModifiedBy}',OnModified='{c.OnModified}' output inserted.ProjectPlatformsId as Result where (ProjectPlatformsId={c.ProjectPlatformsId})";
            return QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
        }
        public static bool Delete(long Id)
        {
            string sql = $"DELETE FROM dbo.ProjectPlatforms output deleted.ProjectPlatformsId as Result WHERE ProjectPlatformsId = {Id};";
            var data = QueryExecutor.FirstOrDefault<TemplateClass<long>>(sql).Result == 0 ? false : true;
            return data;
        }
    }
}
