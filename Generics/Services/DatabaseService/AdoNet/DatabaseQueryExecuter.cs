using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Generics.Services.DatabaseService.AdoNet
{
    public class DatabaseQueryExecuter<T> where T : new()
    {
        public static string Conn = null;
        private static SqlConnection singletonConn;

        private static string GetConnectionString()
        {
            return Constants.ConnectionString;
        }
        private static bool OpenConnection()
        {
            try
            {
                if(singletonConn == null || singletonConn.State != System.Data.ConnectionState.Open)
                {
                    singletonConn = singletonConn ?? new SqlConnection(GetConnectionString());
                    singletonConn.Open();
                }
                return true;
            }catch(Exception ex)
            {
                Console.Error.WriteLine(ex);
                return false;
            }
        }

        public static T Get(string query, SqlConnection conn = null) 
        {
            var localConn = conn;
            if(localConn == null)
            {
                OpenConnection();
                localConn = singletonConn;
            }
            try
            {
                var command = new SqlCommand(query, localConn) { CommandTimeout = 0 };
                var reader = command.ExecuteReader();

                var obj = new ObjectMapper<T>().MapReaderToObject(reader);
                reader.Close();
                
                if(conn != null)
                    conn.Close();
                
                return obj;

            }
            catch (Exception)
            {
                conn?.Close();
                throw;
            }
        }
        public static List<T> GetAll(string query,SqlConnection conn = null)
        {
            var localConn = conn;
            if (localConn == null)
            {
                OpenConnection();
                localConn = singletonConn;
            }
            try
            {

                var command = new SqlCommand(query, localConn) { CommandTimeout = 0 };
                var reader = command.ExecuteReader();

                var obj = new ObjectMapper<T>().MapReaderToObjectList(reader);

                reader.Close();

                if (conn != null)
                    conn.Close();

                return obj;

            }
            catch (Exception)
            {
                conn?.Close();
                throw;
            }

        }


        public static int Execute(string query, SqlConnection conn = null)
        {
            var localConn = conn;
            if (localConn == null)
            {
                OpenConnection();
                localConn = singletonConn;
            }
            try
            {
                var command = new SqlCommand(query, localConn) { CommandTimeout = 0 };
                var reader = command.ExecuteNonQuery();
                
                if (conn != null)
                    conn.Close();

                return reader;

            }
            catch (Exception)
            {
                conn?.Close();
                throw;
            }
        }


    }

    
}
