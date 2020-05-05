using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.Constants
{
    public static class FrequencyType
    {
        public const string Daily = "0";
        public const string Weekly = "1";
        public const string Monthly = "2";
        public static string CheckFrequencyType(int type)
        {
            if (type == 0)
                return "Daily";
            if (type == 1)
                return "Weekly";
            else
                return "Monthly";
        }
        public static Dictionary<int, string> CreateFrequencyTypeDictionary()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "Daily"); dictionary.Add(1, "Weekly"); dictionary.Add(2, "Monthly");
            return dictionary;
        }
    }
}
