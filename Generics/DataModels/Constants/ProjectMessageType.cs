using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.Constants
{
    public static class ProjectMessageType
    {
        public const string General = "0";
        public const string Task = "1";
        public const string CustomerInstruction = "2";
        public static string CheckProjectMessageType(int type)
        {
            if (type == 0)
                return "General";
            if (type == 1)
                return "Task";
            else
                return "CustomerInstruction";
        }
        public static Dictionary<int,string> CreateProjectMessageTypeDictionary()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "General"); dictionary.Add(1,"Task"); dictionary.Add(2, "CustomerInstruction");
            return dictionary;
        }
    }
    
}
