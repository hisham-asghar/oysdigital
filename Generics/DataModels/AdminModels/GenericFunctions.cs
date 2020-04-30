using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace Generics.DataModels.AdminModels
{
    public static class GenericFunctions
    {
        public static Dictionary<int, string> GetDictinary<T>(List<T> model) where T : new()
        {
            int x = 0;
            Dictionary<int, string> mobile=new Dictionary<int, string>();
            foreach (var info in model)
            {
                mobile.Add(x, info.ToString());
                x++;
            }
            return mobile;
        }
    }
}
