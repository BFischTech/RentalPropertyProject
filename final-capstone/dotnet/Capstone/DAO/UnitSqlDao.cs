using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Capstone.DAO {
    public class UnitSqlDao : IUnitDao {
        private readonly string _connectionString;

        public UnitSqlDao(string dbConnectionString) {
            _connectionString = dbConnectionString;
        }

        public IList<Unit> GetAllUnits() {
            IList<Unit> unitList = new List<Unit>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();
                    string sql = 
                        "SELECT unit_id, bedroom_count, bathroom_count, pet_friendly, non_smoking, pool_access, parking_spots, rent_amount, is_rented, rent_due_date, property_id " +
                        "FROM unit;";
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read()) {
                        unitList.Add(GetAllUnitsFromReader(reader));
                    }
                }
            } catch (Exception) {
                throw;
            }
            return unitList;
        }

        public IList<Unit> GetUnitsByPropertyId(int id)
        {
            IList<Unit> unitList = new List<Unit>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = "SELECT unit_id, bedroom_count, bathroom_count, pet_friendly, non_smoking, pool_access, parking_spots, rent_amount, is_rented, rent_due_date, property_id " +
                                 "FROM unit " +
                                 "WHERE property_id = @id;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        unitList.Add(GetAllUnitsFromReader(reader));
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            return unitList;
        }

        private Unit GetAllUnitsFromReader(SqlDataReader reader) {
            Unit units = new Unit() {
                unitId = Convert.ToInt32(reader["unit_id"]),
                bedroomCount = Convert.ToInt32(reader["bedroom_count"]),
                bathroomCount = Convert.ToDecimal(reader["bathroom_count"]),
                petFriendly = Convert.ToBoolean(reader["pet_friendly"]),
                nonSmoking = Convert.ToBoolean(reader["non_smoking"]),
                poolAccess = Convert.ToBoolean(reader["pool_access"]),
                parkingSpots = Convert.ToDecimal(reader["parking_spots"]),
                rentAmount = Convert.ToDecimal(reader["rent_amount"]),
                isRented = Convert.ToBoolean(reader["is_rented"]),
                rentDueDate = Convert.ToString(reader["rent_due_date"]),
                propertyId = Convert.ToInt32(reader["property_id"])
            };
            return units;
        }
    }
}

