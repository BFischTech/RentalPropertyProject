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

        public void UpdateProperty(Property property, int ownerId, int propertyId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = "UPDATE properties SET name = @name, description = @description, address = @address, city = @city, state = @state, zip_code = @zip_code, image_url = @image_url, owner_id = @owner_id " +
                                 "WHERE property_id = @property_id;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@name", property.propertyName);
                    cmd.Parameters.AddWithValue("@description", property.propertyDescription);
                    cmd.Parameters.AddWithValue("@address", property.propertyAddress);
                    cmd.Parameters.AddWithValue("@city", property.propertyCity);
                    cmd.Parameters.AddWithValue("@state", property.propertyState);
                    cmd.Parameters.AddWithValue("@zip_code", property.propertyZipCode);
                    cmd.Parameters.AddWithValue("@image_url", property.propertyImgUrl);
                    cmd.Parameters.AddWithValue("@owner_id", ownerId);
                    cmd.Parameters.AddWithValue("@property_id", propertyId);

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }

        public IList<PropertiesWithAvailableUnits> GetAllPropertiesWithAvailableUnits() {
            IList<PropertiesWithAvailableUnits> propertyWithAvailableUnitsList = new List<PropertiesWithAvailableUnits>();
            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();

                    var sql =
                        "SELECT p.property_id AS 'id' , ut.unit_type_name AS 'type', name, description, address, city, state, zip_code, image_url, COUNT(u.is_rented) AS 'available_units' " +
                        "FROM properties p  " +
                        "INNER JOIN units u ON u.property_id = p.property_id " +
                        "INNER JOIN unit_types ut ON ut.unit_type_id = u.unit_type_id " +
                        "WHERE u.is_rented <> 1  " +
                        "GROUP BY " +
                        "p.property_id , ut.unit_type_name, p.name, p.description, p.address, p.city, p.state, p.zip_code, p.image_url " +
                        "ORDER BY " +
                        "p.property_id ASC;";
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

       
        public void CreateNewProperty(Property property, int ownerId)
        {

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = "INSERT INTO properties (name, description, address, city, state, zip_code, image_url, owner_id) " +
                                 "VALUES (@name, @desctription, @address, @city, @state, @zipcode, @imageUrl, @ownerId)";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@name", property.propertyName);
                    cmd.Parameters.AddWithValue("@desctription", property.propertyDescription);
                    cmd.Parameters.AddWithValue("@address", property.propertyAddress);
                    cmd.Parameters.AddWithValue("@city", property.propertyCity);
                    cmd.Parameters.AddWithValue("@state", property.propertyState);
                    cmd.Parameters.AddWithValue("@zipcode", property.propertyZipCode);
                    cmd.Parameters.AddWithValue("@imageUrl", property.propertyImgUrl);
                    cmd.Parameters.AddWithValue("@ownerId", ownerId);

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {

                throw;
            }

        }

        //Helper method to Convert DB data based off the correct model
        private PropertiesWithAvailableUnits GetAllPropertiesWithAvailableUnitsFromReader(SqlDataReader reader) {
            PropertiesWithAvailableUnits propertyWithAvailableUnits = new PropertiesWithAvailableUnits();

            propertyWithAvailableUnits.propertyId = Convert.ToInt32(reader["id"]);
            propertyWithAvailableUnits.propertyType = Convert.ToString(reader["type"]);
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
