using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.Constants
{
    public static class TaskType
    {
        public const string Post = "0";
        public const string Story = "1";
        public const string Status = "2";
        public static string CheckTaskType(int type)
        {
            if (type == 0)
                return "Post";
            if (type == 1)
                return "Story";
            else
                return "Status";
        }
        public static int CheckTaskTypeByName(string type)
        {
            if (type == "Post")
                return 0;
            if (type == "Stories")
                return 1;
            else
                return 2;
        }
        public static Dictionary<int,string> CreateTaskTypeDictionary()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "Post"); dictionary.Add(1,"Story"); dictionary.Add(2, "Status");
            return dictionary;
        }
    }
    
}
