using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Generics.DataModels.Extensions
{
    public static class GenericAttributeExtensions
    {
        public static GenericAttribute Copy(this GenericAttribute a)
        {
            return new GenericAttribute
            {
                Id = a.Id,
                Key = a.Key,
                EntityId = a.EntityId,
                KeyGroup = a.KeyGroup,
                StoreId = a.StoreId,
                Value = a.Value
            };
        }
        public static GenericAttribute SetKeyValue(this GenericAttribute a, string key, string value)
        {
            if (a == null) return null;
            a.Key = key;
            a.Value = value;
            return a;
        }
        public static bool Compare(this GenericAttribute a, GenericAttribute b)
        {
            if (a == null || b == null) return false;
            return a.EntityId == b.EntityId
                && a.KeyGroup == b.KeyGroup
                && a.Key == b.Key
                && a.StoreId == b.StoreId;
        }
        public static bool KeyIsInList(this GenericAttribute a, List<GenericAttribute> list)
        {
            if (a == null || list == null || list.Count == 0) return false;
            return list.FirstOrDefault(attr => a.Compare(attr)) != null;
        }
        public static bool IsInList(this GenericAttribute a, List<GenericAttribute> list)
        {
            if (a == null || list == null || list.Count == 0) return false;
            return list.FirstOrDefault(attr => a.CompareWithValue(attr)) != null;
        }
        public static bool CompareWithValue(this GenericAttribute a, GenericAttribute b)
        {
            if (a == null || b == null) return false;
            return a.EntityId == b.EntityId
                && a.KeyGroup == b.KeyGroup
                && a.Key == b.Key
                && a.StoreId == b.StoreId
                && a.Value == b.Value;
        }
    }
}
