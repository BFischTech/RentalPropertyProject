using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;
using System.Data.SqlClient;


namespace Capstone.DAO
{
    public class PropertiesSqlDao : IPropertiesDao
    {
        private readonly string connectionString;
        public PropertiesSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }
        public IList<Properties> GetAllProperties()
        {
            IList<Properties> properties = new List<Properties>();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                var sql = 
                    "";

            }
         
        }
    }
}
