using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;
using System.Data.SqlClient;


namespace Capstone.DAO {
    public class PropertiesSqlDao : IPropertiesDao {
        private readonly string _connectionString;
        public PropertiesSqlDao(string dbConnectionString) {
            _connectionString = dbConnectionString;
        }
        public IList<Properties> GetAllProperties() {
            IList<Properties> propertyList = new List<Properties>();

            using (SqlConnection conn = new SqlConnection(_connectionString)) {
                conn.Open();

                var sql = 
                    "SELECT property_id, property_name, property_description, address, city, state, zip_code " +
                    "FROM properties;";
                SqlCommand cmd = new SqlCommand(sql, conn);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read()) {
                    propertyList.Add(GetAllPropertiesFromReader(reader));
                }                
            }
            return propertyList;
        }

        private Properties GetAllPropertiesFromReader(SqlDataReader reader) {
            Properties properties = new Properties() {
                propertyId = Convert.ToInt32(reader["property_id"]),
                propertyName = Convert.ToString(reader["property_name"]),
                propertyDescription = Convert.ToString(reader["property_description"]),
                address = Convert.ToString(reader["address"]),
                city = Convert.ToString(reader["city"]),
                state = Convert.ToString(reader["state"]),
                zipCode = Convert.ToString(reader["zip_code"])
            };
            return properties;
        }
    }
}
