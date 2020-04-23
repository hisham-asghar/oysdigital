using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading;
using System.Xml;
using System.Xml.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace Generics.Common
{
    public static class Functions
    {
#pragma warning disable 0168

        public static bool CompareDate(this DateTime d1 , DateTime d2)
        {
            return d1.Day == d2.Day && d1.Month == d2.Month && d1.Year == d2.Year;
        }
        public static string ReplaceMultiplesWithSingle(this string data,string replaceStr = " ")
        {       
            if(data == null) return null;
            
            if(string.IsNullOrWhiteSpace(data)) return "";
            while(data.Contains(replaceStr+replaceStr))
                data = data.Replace(replaceStr+replaceStr,replaceStr);
            return data;
        }
        public static int ToInt(int? number)
        {
            try
            {
                return number ?? 0;
            }
            catch (Exception e)
            {
                return 0;
            }
        }

        public static string Base64Encode(this string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        public static string Base64Decode(this string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }

        public static Dictionary<T1, T2> ToCustomDictionary<T1, T2>(this List<KeyValuePair<T1,T2>> list) 
        {
            var dictionary = new Dictionary<T1, T2>();
            foreach (var pair in list)
            {
                dictionary[pair.Key] = pair.Value;
            }
            return dictionary;
        }

        public static int ToInt(this string number)
        {
            try
            {
                return int.Parse(number);
            }
            catch (Exception e)
            {
                return 0;
            }
        }
        public static long ToLong(this string number)
        {
            try
            {
                return long.Parse(number);
            }
            catch (Exception e)
            {
                return 0;
            }
        }
        public static string SubStr(this string str,int start,int length)
        {
            if (string.IsNullOrWhiteSpace(str)) return "";
            if (str.Length > (length - start))
            {
                return str.Substring(start, length);
            }
            else if(str.Length < Math.Abs(start))
            {
                return "";
            }
            else
            {
                return str;
            }
        }
        public static string ConvetObjectToJson<T>(T request)
        {
            string requestJson = JsonConvert.SerializeObject(request, 
                    Newtonsoft.Json.Formatting.None, 
                    new JsonSerializerSettings { 
                        NullValueHandling = NullValueHandling.Ignore
                    });
            return requestJson;
        }
        public static T ConvertJsonToObject<T>(string request)
        {
            var requestJson = JsonConvert.DeserializeObject(request);
            return (T)requestJson;
        }
        public static decimal ToDecimal(this string number)
        {
            try
            {
                return decimal.Parse(number);
            }
            catch (Exception e)
            {
                return 0;
            }
        }
        public static double ToDouble(this string number)
        {
            try
            {
                return double.Parse(number);
            }
            catch (Exception e)
            {
                return 0;
            }
        }

        public static double ToDoubleFromAmountString(this string number)
        {
            if (string.IsNullOrWhiteSpace(number)) return 0;
            if (number.Contains("$"))
                number = number.Replace("$", "");
            if (number.Contains(","))
                number = number.Replace(",", "");
            return number.ToDouble();
        }

        public static long Floor(this decimal number) => (long)Math.Floor(number);
        public static long Floor(this double number) => (long)Math.Floor(number);
        public static decimal ExtractNumberFromString(this string str)
        {
            decimal parsedNumber = 0;
            try
            {
                var number = (Regex.Split(str, @"[^0-9\.]+")
                                  .FirstOrDefault(c => c != "." && c.Trim() != "") ?? "0").ToDecimal();
                parsedNumber = Math.Floor(number);
            }
            catch (Exception ex)
            {
                return 0;
            }

            return parsedNumber;
        }
        public static List<List<T>> ListDividier<T>(this IEnumerable<T> list, int nsize = 3)
        {
            var listOfList = new List<List<T>>();
            while (list.Any())
            {
                listOfList.Add(list.Take(nsize).ToList());
                list = list.Skip(nsize).ToList();
            }
            return listOfList;
        }

        public static string SerializeXml<T>(this T obj)
        {
            try
            {

                var stringwriter = new StringWriter();
                var serializer = new XmlSerializer(obj.GetType());
                serializer.Serialize(stringwriter, obj);
                return stringwriter.ToString();
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public static T DeserializeXml<T>(this string xml)
        {
            try
            {
                var stringReader = new System.IO.StringReader(xml);
                var serializer = new XmlSerializer(typeof(T));
                return (T) serializer.Deserialize(stringReader);
            }
            catch (Exception ex)
            {
                return default(T);
            }
        }


        public static string ConvertXmlToJson(this string xml)
        {
            if (string.IsNullOrWhiteSpace(xml)) return null;
            try
            {
                var doc = new XmlDocument();
                doc.LoadXml(xml);
                return JsonConvert.SerializeXmlNode(doc);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return null;
            }
        }
        public static T FromXml<T>(this string xml)
        {
            if (string.IsNullOrWhiteSpace(xml)) return default(T);
            try
            {
                var doc = new XmlDocument();
                doc.LoadXml(xml);

                T response = default(T);
                using (XmlReader reader = XmlReader.Create((new StringReader(xml))))
                {
                    var serializer = new XmlSerializer(typeof(T));
                    response = (T)serializer.Deserialize(reader);
                }
                return response;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return default(T);
            }
        }
        public static string ConvertJsontoxml(this string json)
        {
            if (string.IsNullOrWhiteSpace(json)) return null;
            try
            {
                var doc = JsonConvert.DeserializeXmlNode(json);
                return doc.InnerXml;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return null;
            }

        }
        public static T Get<T>(this Dictionary<string, T> dictionary, string key, T value = default(T))
        {
            return !dictionary.ContainsKey(key) ? value : dictionary[key];
        }
        public static T2 Get<T1,T2>(this Dictionary<T1, T2> dictionary, T1 key, T2 value = default(T2))
        {
            return !dictionary.ContainsKey(key) ? value : dictionary[key];
        }
        public static string Get(this Dictionary<string, string> dictionary, string key, string value = "")
        {
            return !dictionary.ContainsKey(key) ? "" : dictionary[key];
        }
        public static string GetEnumDescription(this Enum value)
        {
            string description = value.ToString();

            var fi = value.GetType().GetField(value.ToString());

            var attributes = (DescriptionAttribute[])fi.GetCustomAttributes(typeof(DescriptionAttribute), false);
            // ReSharper disable ConditionIsAlwaysTrueOrFalse
            if (null != attributes && attributes.Length > 0)
                // ReSharper restore ConditionIsAlwaysTrueOrFalse
            {
                description = attributes[0].Description;
            }

            return description;
        }


        public static void RunParallel<T1>(List<T1> list,Func<T1,bool> func, int noOfParallelThreads)
        {
            var pairList = ListDividier(list, noOfParallelThreads);
            var threads = list.Select(item => new Thread(() => { func(item); })).ToList();
            threads.ForEach(t => t.Start());
            threads.ForEach(t => t.Join());
        }


        public static long GetLong(long? value, long defaultValue = 0)
        {
            try
            {
                return value ?? 0;
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static long GetLong(string value, long defaultValue = 0)
        {
            try
            {
                return long.Parse(value);
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static long GetLong(object value, long defaultValue = 0)
        {
            try
            {
                return (long)(value);
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }

        public static double GetDouble(double? value, double defaultValue = 0)
        {
            try
            {
                return value ?? 0;
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static double GetDouble(string value, double defaultValue = 0)
        {
            try
            {
                return double.Parse(value);
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static double GetDouble(object value, double defaultValue = 0)
        {
            try
            {
                return (double)(value);
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }

        public static int GetInt(int? value, int defaultValue = 0)
        {
            try
            {
                return value ?? 0;
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static int GetInt(string value, int defaultValue = 0)
        {
            try
            {
                return int.Parse(value);
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static int GetInt(object value, int defaultValue = 0)
        {
            try
            {
                return (int)(value);
            }

            catch (Exception e)
            {

                return defaultValue;
            }
        }
        public static T ParseJson<T>(this string json)
        {
            try
            {
                return JsonConvert.DeserializeObject<T>(json);
            }
            catch (Exception ex)
            {
                return default(T);
            }
        }

        public static string ToJson<T>(this T self, bool allowNull = true, bool indentedResult = false)
        {
            try
            {
                var settings = Converter.Settings;
                if (allowNull == false)
                    settings.NullValueHandling = NullValueHandling.Ignore;
                if (indentedResult)
                    settings.Formatting = Newtonsoft.Json.Formatting.Indented;
                return JsonConvert.SerializeObject(self, settings);
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static T FromJson<T>(this string json)
        {
            try
            {
                return JsonConvert.DeserializeObject<T>(json, Converter.Settings);
            }
            catch (Exception ex) { return default(T); }
        }

        public static bool CompareComplesStrings(this string str1, string str2)
        {
            var seperator = new[] { '-', '_', ' ' };
            var list1 = str1.Split(seperator).ToList();
            var list2 = str2.Split(seperator).ToList();
            return list1.FirstOrDefault(word =>
                       !string.IsNullOrWhiteSpace(word) &&
                       list2.FirstOrDefault(w =>
                           !string.IsNullOrWhiteSpace(w) &&
                           w.ToLower().Trim() == word.ToLower().Trim()
                       ) != null) != null;
        }
#pragma warning restore 0168
    }


    public static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            NullValueHandling = NullValueHandling.Ignore,
            Converters =
            {
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }
}
