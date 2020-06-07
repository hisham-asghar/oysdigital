using System;

namespace Generics.Common
{
    public class DataConstants
    {
        public const int GMT = 5;
        public static DateTime LocalNow { get { return DateTime.UtcNow.AddHours(GMT); } }
    }
}
