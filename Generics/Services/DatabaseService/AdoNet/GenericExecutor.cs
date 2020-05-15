using Generics.DataModels;
using Generics.Services.DatabaseService.AdoNet;
using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.Services.DatabaseService.AdoNet
{
    public static class GenericExecutor
    {
        const string DefaultSchema = "dbo";
        public static int Insert<T>(this T model, string tableName, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Insert(model, tableName, schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static int Update<T>(this T model, string tableName, int id, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Update(model, tableName, id, schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
        }
        public static int Update<T>(this T model, string tableName, string id, string schema = DefaultSchema)
        {
            if (model == null || string.IsNullOrWhiteSpace(tableName)) return 0;
            var query = GenericQueries.Update(model, tableName, id, schema);
            return QueryExecutor.FirstOrDefault<TemplateClass<int>>(query, query)?.Result ?? 0;
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
