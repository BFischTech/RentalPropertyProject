using System;
using System.Collections.Generic;
using Capstone.Models;
using System.Data.SqlClient;


namespace Capstone.DAO
{
    public class PropertiesSqlDao : IPropertiesDao
    {
        private readonly string _connectionString;

        public PropertiesSqlDao(string dbConnectionString) {
            _connectionString = dbConnectionString;
        }

        public IList<PropertiesWithAvailableUnits> GetAllPropertiesWithAvailableUnits() {
            IList<PropertiesWithAvailableUnits> propertyWithAvailableUnitsList = new List<PropertiesWithAvailableUnits>();
            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();

                    var sql =
                        "SELECT p.property_id , name, description, address, city, state, zip_code, image_url, COUNT(u.is_rented) AS 'available_units' " +
                        "FROM properties p " +
                        "INNER JOIN units u ON u.property_id = p.property_id " +
                        "WHERE u.is_rented <> 1 " +
                        "GROUP BY " +
                        "p.property_id, p.name, p.description, p.address, p.city, p.state, p.zip_code, p.image_url;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read()) {
                        propertyWithAvailableUnitsList.Add(GetAllPropertiesWithAvailableUnitsFromReader(reader));
                    }
                }
            } catch (SqlException) {
                throw;
            }
            return propertyWithAvailableUnitsList;
        }

        //Helper method to Convert DB data based off the correct model
        private PropertiesWithAvailableUnits GetAllPropertiesWithAvailableUnitsFromReader(SqlDataReader reader) {
            PropertiesWithAvailableUnits propertyWithAvailableUnits = new PropertiesWithAvailableUnits();

            propertyWithAvailableUnits.propertyId = Convert.ToInt32(reader["property_id"]);
            propertyWithAvailableUnits.name = Convert.ToString(reader["name"]);
            propertyWithAvailableUnits.description = Convert.ToString(reader["description"]);
            propertyWithAvailableUnits.address = Convert.ToString(reader["address"]);
            propertyWithAvailableUnits.city = Convert.ToString(reader["city"]);
            propertyWithAvailableUnits.state = Convert.ToString(reader["state"]);
            propertyWithAvailableUnits.zipCode = Convert.ToString(reader["zip_code"]);
            propertyWithAvailableUnits.imageUrl = Convert.ToString(reader["image_url"]);
            propertyWithAvailableUnits.availableUnits = Convert.ToInt32(reader["available_units"]);

            return propertyWithAvailableUnits;
        }
    }
}
