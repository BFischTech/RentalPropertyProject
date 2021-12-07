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
                    "SELECT property_id, address, city, state, zip_code, unit, rent_amount, is_rented, rent_due_date " +
                    "FROM properties";
                SqlCommand cmd = new SqlCommand(sql, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    var property = new Properties();
                    property.propertyId = Convert.ToInt32(reader["property_id"]);
                    property.address = Convert.ToString(reader["address"]);
                    property.city = Convert.ToString(reader["city"]);
                    property.state = Convert.ToString(reader["state"]);
                    property.zipcode = Convert.ToString(reader["zip_code"]);
                    property.unit = Convert.ToString(reader["unit"]);
                    property.rentAmount = Convert.ToDecimal(reader["rent_amount"]);
                    property.isRented = Convert.ToBoolean(reader["is_rented"]);
                    property.rentDueDate = Convert.ToString(reader["rent_due_date"]);
                    properties.Add(property);
                }                
            }
            return properties;
        }
    }
}
