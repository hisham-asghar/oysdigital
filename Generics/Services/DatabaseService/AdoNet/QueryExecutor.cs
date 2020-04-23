using System;
using System.Collections.Generic;

namespace Generics.Services.DatabaseService.AdoNet
{
    public static class QueryExecutor
    {
        // ADO.NET
        public static bool ExecuteDml(string query, string function = null, bool retry = true)
        {
            try
            {
                return DatabaseQueryExecuter<object>.Execute(query) >= 0;
            }
            catch (Exception ex)
            {
                if (retry && !string.IsNullOrWhiteSpace(ex.ToString()) && ex.ToString().ToLower().Contains("timeout"))
                    return ExecuteDml(query, function, false);
            }

            return false;
        }
        public static T FirstOrDefault<T>(string query, string function = null, bool retry = true) where T : new()
        {
            try
            {
                return DatabaseQueryExecuter<T>.Get(query);
            }
            catch (Exception ex)
            {
                if (retry && !string.IsNullOrWhiteSpace(ex.ToString()) && ex.ToString().ToLower().Contains("timeout"))
                    return FirstOrDefault<T>(query, function, false);
            }

            return default(T);
        }
        public static List<T> List<T>(string query, string function = null,bool retry = true) where T : new()
        {
            try
            {
                return DatabaseQueryExecuter<T>.GetAll(query);
            }
            catch (Exception ex)
            {
                if (retry && !string.IsNullOrWhiteSpace(ex.ToString()) && ex.ToString().ToLower().Contains("timeout"))
                    return List<T>(query, function, false);
            }

            return default(List<T>);
        }

    }
}
