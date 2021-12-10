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
        private readonly string _connectionString;

        public PropertiesSqlDao(string dbConnectionString)
        {
            _connectionString = dbConnectionString;
        }

        public IList<Properties> GetAllProperties()
        {
            IList<Properties> propertyList = new List<Properties>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    var sql =
                        "SELECT property_id, property_name, property_description, property_img, address, city, state, zip_code " +
                        "FROM properties;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        propertyList.Add(GetAllPropertiesFromReader(reader));
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            return propertyList;
        }

        // Important to note that this will only return rows that have info matching from all three tables.. right now this is only returning two rows.
        public IList<PropertiesUnitsImages> GetAllPropertiesUnitsImages()
        {
            IList<PropertiesUnitsImages> propertyList = new List<PropertiesUnitsImages>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    var sql =
                        "SELECT " +
                        "p.property_id AS propertyId, p.property_name AS propertyName, p.property_description AS propertyDescription, p.property_img AS propertyImg, p.address AS address, p.city AS city, p.state AS state, p.zip_code AS zipCode, " +
                        "u.bedroom_count AS bedroomCount, u.bathroom_count AS bathroomCount, u.pet_friendly AS petFriendly, u.non_smoking AS nonSmoking, u.pool_access AS poolAccess, u.parking_spots AS parkingSpots, u.rent_amount As rentAmount, u.is_rented AS isRented, u.rent_due_date AS rentDueDate, " +
                        "i.image_url AS imageUrl " +
                        "FROM properties p " +
                        "INNER JOIN unit u ON u.property_id = p.property_id " +
                        "INNER JOIN unit_images i ON i.unit_id = u.unit_id;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        propertyList.Add(GetAllPropertiesUnitsImagaesFromReader(reader));
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            return propertyList;
        }

        //Helper method to Convert DB data based off the correct model
        private Properties GetAllPropertiesFromReader(SqlDataReader reader)
        {
            Properties property = new Properties();

            property.propertyId = Convert.ToInt32(reader["property_id"]);
            property.propertyName = Convert.ToString(reader["property_name"]);
            property.propertyDescription = Convert.ToString(reader["property_description"]);
            property.propertyImg = Convert.ToString(reader["property_img"]);
            property.address = Convert.ToString(reader["address"]);
            property.city = Convert.ToString(reader["city"]);
            property.state = Convert.ToString(reader["state"]);
            property.zipCode = Convert.ToString(reader["zip_code"]);


            return property;
        }

        //Helper method to Convert DB data based off the correct model
        private PropertiesUnitsImages GetAllPropertiesUnitsImagaesFromReader(SqlDataReader reader)
        {

            PropertiesUnitsImages properties = new PropertiesUnitsImages()
            {
                propertyId = Convert.ToInt32(reader["propertyId"]),
                propertyName = Convert.ToString(reader["propertyName"]),
                propertyDescription = Convert.ToString(reader["propertyDescription"]),
                propertyImg = Convert.ToString(reader["propertyImg"]),
                address = Convert.ToString(reader["address"]),
                city = Convert.ToString(reader["city"]),
                state = Convert.ToString(reader["state"]),
                zipCode = Convert.ToString(reader["zipCode"]),
                bedroomCount = Convert.ToInt32(reader["bedroomCount"]),
                bathroomCount = Convert.ToDecimal(reader["bathroomCount"]),
                petFriendly = Convert.ToBoolean(reader["petFriendly"]),
                nonSmoking = Convert.ToBoolean(reader["nonSmoking"]),
                poolAccess = Convert.ToBoolean(reader["poolAccess"]),
                parkingSpots = Convert.ToDecimal(reader["parkingSpots"]),
                rentAmount = Convert.ToDecimal(reader["rentAmount"]),
                isRented = Convert.ToBoolean(reader["isRented"]),
                rentDueDate = Convert.ToString(reader["rentDueDate"]),
                imageUrl = Convert.ToString(reader["imageUrl"])
            };
            return properties;
        }

    }
}
