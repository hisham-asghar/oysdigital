using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Generics.Common.Attributes;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace Generics.DataModels.AdminModels
{
    public class WorkTaskPlatforms
    {
        [DbGenerated]
        public long Id { get; set; }
        public long PlatformId { get; set; }
        [Ignore]
        public string PlatformName { get; set; }
        [Ignore]
        public string PlatformIcon { get; set; }
        public long WorkTaskId { get; set; }

        public bool IsCompleted { get; set; }

        public bool IsDesigned { get; set; }

        public bool IsScheduled { get; set; }

        public bool Status { get; set; }
        public string Link { get; set; }
    }
    public partial class TaskPlatforms
    {
        public string Id { get; set; }
    }

    public partial class TaskPlatforms
    {
        public static List<TaskPlatforms> FromJson(string json) => JsonConvert.DeserializeObject<List<TaskPlatforms>>(json);
    }

    public static class Serialize
    {
        public static string ToJson(this List<TaskPlatforms> self) => JsonConvert.SerializeObject(self);


        internal static class Converter
        {
            public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
            {
                MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
                DateParseHandling = DateParseHandling.None,
                Converters =
            {
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
            };
        }
    }
}

