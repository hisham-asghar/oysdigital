using Generics.DataModels;
using System.Collections.Generic;
using System.Linq;

namespace Generics.Services.DatabaseService.AdoNet
{
    public static class GenericExecutor
    {
        const string DefaultSchema = "dbo";
        public static int Insert<T>(this T model, string tableName, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Insert(model, tableName, new List<string>(), schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static List<int> Insert<T>(this List<T> list, string tableName, string schema = DefaultSchema)
        {
            if (list == null || list.Count <= 0 || string.IsNullOrWhiteSpace(tableName)) return new List<int>();
            var query = GenericQueries.Insert(list, tableName, new List<string>(), schema);
            return (QueryExecutor.List<TemplateClass<int>>(query, query) ?? new List<TemplateClass<int>>())
                .Select(r => r.Result).ToList();
        }

        public static int InsertWithExtraIgnore<T>(this T model, string tableName, List<string> ignoreColumns, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Insert(model, tableName, ignoreColumns, schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static int Update<T>(this T model, string tableName, int id, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Update(model, tableName, id, new List<string>(), schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static int UpdateWithExtraIgnore<T>(this T model, string tableName, int id, List<string> ignoreColumns, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Update(model, tableName, id, ignoreColumns, schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static int Update<T>(this T model, string tableName, string id, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Update(model, tableName, id, new List<string>(), schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static string UpdateWithExtraIgnore<T>(this T model, string tableName, string id, List<string> ignoreColumns, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return null;
            var query = GenericQueries.Update(model, tableName, id, ignoreColumns, schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<string>>(query, query)?.Result;
        }

        public static bool Delete(this string tableName, int id, string schema = DefaultSchema)
        {
            var query = GenericQueries.Delete(tableName, id, schema);
            return QueryExecutor.ExecuteDml(query, query);
        }
        public static bool Delete(this string tableName, string id, string schema = DefaultSchema)
        {
            var query = GenericQueries.Delete(tableName, id, schema);
            return QueryExecutor.ExecuteDml(query, query);
        }
        public static List<T> SelectAll<T>(this string tableName, string schema = DefaultSchema) where T : new()
        {
            var query = GenericQueries.SelectAll(tableName, schema);
            return QueryExecutor.List<T>(query, query);
        }
        public static List<T> SelectList<T>(this string tableName, string where, string schema = DefaultSchema) where T : new()
        {
            var query = GenericQueries.SelectAll(tableName, schema);
            if (!string.IsNullOrWhiteSpace(where))
                query += $" WHERE {where}";

            return QueryExecutor.List<T>(query, query);
        }
        public static T Select<T>(this string tableName, string where, string schema = DefaultSchema) where T : new()
        {
            var query = GenericQueries.Select(tableName, schema);
            if (!string.IsNullOrWhiteSpace(where))
                query += $" WHERE {where}";

            return QueryExecutor.FirstOrDefault<T>(query, query);
        }
        public static T Select<T>(this string tableName, int id, string schema = DefaultSchema) where T : new()
        {
            var query = GenericQueries.Select(tableName, schema);
            query += $" WHERE Id = {id}";

            return QueryExecutor.FirstOrDefault<T>(query, query);
        }
    }
}
