using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.DataModels.Constants
{
    public static class AlertType
    {
        public const string NotDone = "0";
        public const string Done = "1";
        public const string Issue = "2";
        public static string CheckAlertType(int type)
        {
            if (type == 0)
                return "NotDone";
            if (type == 1)
                return "Done";
            else
                return "Issue";
        }
        public static string GetColor(int type)
        {
            if (type == 0)
                return "orange";
            if (type == 1)
                return "seagreen";
            else
                return "red";
        }
        public static Dictionary<int, string> CreateAlertTypeDictionary()
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            dictionary.Add(0, "NotDone"); dictionary.Add(1, "Done"); dictionary.Add(2, "Issue");
            return dictionary;
        }
    }
}
