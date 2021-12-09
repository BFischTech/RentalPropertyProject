using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class UnitSqlDao : IUnitDao
    {
        private readonly string connectionString;
        public UnitSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public IList<Unit> GetAllUnits()
        {
            IList<Unit> unitList = new List<Unit>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string sql = "SELECT unit_id, bedroom_count, bathroom_count, pet_friendly, non_smoking, pool_access, parking_spots, rent_amount, is_rented, rent_due_date, property_id " +
                                 "FROM unit;";
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Unit unit = new Unit();
                        

                        unit.unitId = Convert.ToInt32(reader["unit_id"]);
                        unit.bedroomCount = Convert.ToInt32(reader["bedroom_count"]);
                        unit.bathroomCount = Convert.ToDecimal(reader["bathroom_count"]);
                        unit.petFriendly = Convert.ToBoolean(reader["pet_friendly"]);
                        unit.nonSmoking = Convert.ToBoolean(reader["non_smoking"]);
                        //run time error when passing NULL values... needs fixxed!!!!!!!!!!!!!!!!.
                        unit.poolAccess = Convert.ToBoolean(reader["pool_access"]);
                        unit.parkingSpots = Convert.ToDecimal(reader["parking_spots"]);
                        unit.rentAmount = Convert.ToDecimal(reader["rent_amount"]);
                        unit.isRented = Convert.ToBoolean(reader["is_rented"]);
                        unit.rentDueDate = Convert.ToString(reader["rent_due_date"]);
                        unit.propertyId = Convert.ToInt32(reader["property_id"]);

                        unitList.Add(unit);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return unitList;
        }
    }
}

