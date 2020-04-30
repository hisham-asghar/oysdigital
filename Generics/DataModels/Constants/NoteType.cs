using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.Constants
{
    public static class NoteType
    {
        public const string Admin = "0";
        public const string Manager = "1";
        public const string Member = "2";
        public static string CheckNoteType(int type)
        {
            if (type == 0)
                return "Admin";
            if (type == 1)
                return "Manager";
            else
                return "Member";
        }
        public static Dictionary<int, string> CreateProjectNoteDictionary()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "Admin"); dictionary.Add(1, "Manager"); dictionary.Add(2, "Member");
            return dictionary;
        }
    }
}
