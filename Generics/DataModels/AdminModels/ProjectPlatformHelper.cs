using Amazon.S3.Model.Internal.MarshallTransformations;
using Generics.Common;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Reflection.Metadata.Ecma335;
using System.Text;

namespace Generics.DataModels.AdminModels
{
    public static class ProjectPlatformHelper
    {
        public static int GetPostCount(params int[] items)
        {
            int postconnt = 0;
            if (items != null && items.Length > 0)
            {
                
                for (var i = 0; i < items.Length; i++)
                {
                    if (items[i] != 0)
                    {
                        return items[i];
                    }
                }
            }
            return postconnt;
        }
        

    public static ProjectPlatforms ProjectPlatformParser(ProjectPlaformCreateView proj)
        {
            ProjectPlatforms p=new ProjectPlatforms();
            if (proj.PostType == 0)
                p.PostPerDay = proj.PostCount;
            if (proj.PostType == 1)
                p.PostPerWeek = proj.PostCount;
            if (proj.PostType == 2)
                p.PostPerMonth = proj.PostCount;
            if (proj.StoriesType == 0)
                p.StoriesPerDay = proj.StoriesCount;
            if (proj.StoriesType == 1)
                p.StoriesPerWeek = proj.StoriesCount;
            if (proj.StoriesType == 2)
                p.StoriesPerMonth = proj.StoriesCount;
            p.PostSchedulingTime = proj.PostSchedulingTime;
            p.StoriesSchedulingTime = proj.StoriesSchedulingTime;
            p.ProjectId = proj.ProjectId;
            p.PlatformId = proj.PlatformId;
            p.PlatformLink = proj.PlatformLink;
            p.MobileSpaceId = proj.MobileSpaceId;
            p.IsActive = proj.IsActive;
            p.Id = proj.Id;
            p.CreatedBy = proj.CreatedBy;
            p.ModifiedBy = proj.ModifiedBy;
            p.OnCreated = proj.OnCreated;
            p.OnModified = proj.OnModified;
            return p;
        }
        public static ProjectPlaformCreateView ProjectPlatformCreateViewParser(ProjectPlatforms proj)
        {
            ProjectPlaformCreateView p = new ProjectPlaformCreateView();
            if (proj.PostPerDay != 0)
            {
                p.PostCount = proj.PostPerDay;
                p.PostType = 0;
            }
            if (proj.PostPerWeek != 0)
            {
                p.PostCount = proj.PostPerWeek;
                p.PostType = 1;
            }
            if (proj.PostPerMonth != 0)
            {
                p.PostCount = proj.PostPerMonth;
                p.PostType = 2;
            }
            if (proj.StoriesPerDay != 0)
            {
                p.StoriesCount = proj.StoriesPerDay;
                p.StoriesType = 0;
            }
            if (proj.StoriesPerWeek != 0)
            {
                p.StoriesCount = proj.StoriesPerWeek;
                p.StoriesType = 1;
            }
            if (proj.StoriesPerMonth != 0)
            {
                p.StoriesCount = proj.StoriesPerMonth;
                p.StoriesType = 2;
            }
            p.PostSchedulingTime = proj.PostSchedulingTime;
            p.StoriesSchedulingTime = proj.StoriesSchedulingTime;
            p.ProjectId = proj.ProjectId;
            p.PlatformId = proj.PlatformId;
            p.PlatformLink = proj.PlatformLink;
            p.MobileSpaceId = proj.MobileSpaceId;
            p.IsActive = proj.IsActive;
            p.Id = proj.Id;
            p.CreatedBy = proj.CreatedBy;
            p.ModifiedBy = proj.ModifiedBy;
            p.OnCreated= proj.OnCreated;
            p.OnModified = proj.OnModified;
            return p;
        }
        public static Dictionary<int, string> CreatePostScheduling()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "PostPerDay"); dictionary.Add(1, "PostPerWeek"); dictionary.Add(2, "PostPerMonth");
            return dictionary;
        }
        public static Dictionary<int, string> CreateStoriesScheduling()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "StoriesPerDay"); dictionary.Add(1, "StoriesPerWeek"); dictionary.Add(2, "StoriesPerMonth");
            return dictionary;
        }

    }
}
