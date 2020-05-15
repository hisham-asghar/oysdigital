using Generics.Common;
using Generics.Common.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Generics.Services.DatabaseService.AdoNet
{
    static class GenericQueries
    {
        public static string Delete(string tableName, int id, string schema) =>
            $"DELETE FROM [{schema}].[{tableName}] WHERE Id = {id}";
        public static string Delete(string tableName, string id, string schema) =>
           $"DELETE FROM [{schema}].[{tableName}] WHERE Id = '{id}'";
        public static string SelectAll(string tableName, string schema) =>
            $"SELECT * FROM [{schema}].[{tableName}]";
        public static string Select(string tableName, string schema) =>
            $"SELECT TOP 1 * FROM [{schema}].[{tableName}]";
        public static string Insert<T>(T model, string tableName, string schema)
        {
            var columns = "";
            var columnValues = "";
            var haveIdColumn = false;
            foreach (PropertyInfo prop in model.GetType().GetProperties())
            {
                var columnName = prop.Name;
                if (columnName.ToLower() == "id") haveIdColumn = true;

                var value = prop.GetValue(model, null)?.ToString();

                var type = Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType;
                if (!type.IsSimple())
                    continue;

                var ignoreByAttribute = prop.CustomAttributes
                    .FirstOrDefault(c => c.AttributeType == typeof(DbGenerated) || c.AttributeType == typeof(Ignore)) != null;
                if (ignoreByAttribute) continue;

                var ignoreByAttributeIfValueNull = prop.CustomAttributes
                    .FirstOrDefault(c => c.AttributeType == typeof(IgnoreIfNull)) != null;
                if (ignoreByAttributeIfValueNull && value == null) continue;

                columns += $"[{columnName}], ";
                if(value == null)
                    columnValues += $"NULL, ";
                else if (type == typeof(string))
                    columnValues += $"'{value.Replace("'","''")}', ";
                else if (type == typeof(DateTime))
                    columnValues += $"'{value}', ";
                else if (type == typeof(bool))
                    columnValues += $"{value.ToBoolInt()}, ";
                else
                    columnValues += $"{value.ToLong()}, ";

            }
            if (columns.EndsWith(", "))
                columns = columns.Substring(0, columns.Length - 2);
            if (columnValues.EndsWith(", "))
                columnValues = columnValues.Substring(0, columnValues.Length - 2);
            var query = $"INSERT INTO [{schema}].[{tableName}] ({columns}) " +
                (haveIdColumn ? $"OUTPUT INSERTED.Id AS Result " : "") +
                $"VALUES ({columnValues})";
            return query;
        }
        public static string Update<T>(T model, string tableName, long id, string schema)
        {
            var columnsAndValues = "";
            var haveIdColumn = false;
            foreach (PropertyInfo prop in model.GetType().GetProperties())
            {
                var columnName = prop.Name;

                if (columnName.ToLower() == "id") haveIdColumn = true;

                var value = prop.GetValue(model, null)?.ToString();

                var type = Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType;
                if (!type.IsSimple())
                    continue;

                var ignoreByAttribute = prop.CustomAttributes
                    .FirstOrDefault(c => c.AttributeType == typeof(IgnoreOnUpdate) || c.AttributeType == typeof(DbGenerated) || c.AttributeType == typeof(Ignore)) != null;
                if (ignoreByAttribute) continue;

                var ignoreByAttributeIfValueNull = prop.CustomAttributes
                    .FirstOrDefault(c => c.AttributeType == typeof(IgnoreIfNull)) != null;
                if (ignoreByAttributeIfValueNull && value == null) continue;

                var set = $"[{columnName}] = ";
                if (value == null)
                    set += $"NULL, ";
                else if (type == typeof(string))
                    set += $"'{value.Replace("'", "''")}', ";
                else if (type == typeof(DateTime))
                    set += $"'{value}', ";
                else if (type == typeof(bool))
                    set += $"{value.ToBoolInt()}, ";
                else
                    set += $"{value.ToLong()}, ";
                columnsAndValues += set;

            }
            if (columnsAndValues.EndsWith(", "))
                columnsAndValues = columnsAndValues.Substring(0, columnsAndValues.Length - 2);
            var query = $"UPDATE [{schema}].[{tableName}] SET {columnsAndValues} " +
                (haveIdColumn ? $"OUTPUT INSERTED.Id AS Result " : "") +
                $"WHERE Id = {id}";
            return query;
        }
        public static string Update<T>(T model, string tableName, string id, string schema)
        {
            var columnsAndValues = "";
            var haveIdColumn = false;
            foreach (PropertyInfo prop in model.GetType().GetProperties())
            {
                var columnName = prop.Name;

                if (columnName.ToLower() == "id") haveIdColumn = true;

                var value = prop.GetValue(model, null)?.ToString();

                var type = Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType;
                if (!type.IsSimple())
                    continue;

                var ignoreByAttribute = prop.CustomAttributes
                    .FirstOrDefault(c => c.AttributeType == typeof(IgnoreOnUpdate) || c.AttributeType == typeof(DbGenerated) || c.AttributeType == typeof(Ignore)) != null;
                if (ignoreByAttribute) continue;

                var ignoreByAttributeIfValueNull = prop.CustomAttributes
                    .FirstOrDefault(c => c.AttributeType == typeof(IgnoreIfNull)) != null;
                if (ignoreByAttributeIfValueNull && value == null) continue;

                var set = $"[{columnName}] = ";
                if (value == null)
                    set += $"NULL, ";
                else if (type == typeof(string))
                    set += $"'{value.Replace("'", "''")}', ";
                else if (type == typeof(DateTime))
                    set += $"'{value}', ";
                else if (type == typeof(bool))
                    set += $"{value.ToBoolInt()}, ";
                else
                    set += $"{value.ToLong()}, ";
                columnsAndValues += set;

            }
            if (columnsAndValues.EndsWith(", "))
                columnsAndValues = columnsAndValues.Substring(0, columnsAndValues.Length - 2);
            var query = $"UPDATE [{schema}].[{tableName}] SET {columnsAndValues} " +
                (haveIdColumn ? $"OUTPUT INSERTED.Id AS Result " : "") +
                $"WHERE Id = '{id}'";
            return query;
        }
    }
}
