using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Capstone.DAO
{

    public class UnitSqlDao : IUnitDao
    {
        private readonly string _connectionString;

        public UnitSqlDao(string dbConnectionString)
        {
            _connectionString = dbConnectionString;
        }

        //Method that returns a detailed view of a unit by unitId
        public DetailedUnit GetUnitDetails(int unitId)
        {
            DetailedUnit unit = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = "SELECT u.property_id, u.unit_id, ut.unit_type_name, u.rent_amount, ul.unit_building_number, ul.unit_number, ul.unit_street_address, ul.unit_city, ul.unit_zip_code, um.image_url, a.bedroom_count, a.bathroom_count, a.pet_allowed, a.smoking_allowed, a.pool_access, a.parking_spots " +
                                 "FROM units u " +
                                 "JOIN unit_location ul ON u.unit_id = ul.unit_location_id " +
                                 "JOIN unit_types ut on u.unit_type_id = ut.unit_type_id " +
                                 "JOIN unit_images um ON um.unit_id = u.unit_id " +
                                 "JOIN amenities a ON a.unit_id = u.unit_id " +
                                 "WHERE u.unit_id = @unitId;";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@unitId", unitId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        unit = GetDetailedUnitReader(reader);
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }

            return unit;
        }

        //Method that returns a list of units info that currently be rented out.
        public IList<AvailableUnits> GetAllAvailableUnits()
        {
            IList<AvailableUnits> unitList = new List<AvailableUnits>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = "SELECT u.unit_id, u.property_id, ut.unit_type_name, u.rent_amount, ul.unit_building_number, ul.unit_number, ul.unit_street_address, ul.unit_city, ul.unit_zip_code, um.image_url " +
                        "FROM units u " +
                        "JOIN unit_location ul ON u.unit_id = ul.unit_location_id " +
                        "JOIN unit_types ut on u.unit_type_id = ut.unit_type_id " +
                        "JOIN unit_images um ON um.unit_id = u.unit_id " +
                        "WHERE u.is_rented = 0;";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        unitList.Add(GetAvaiableUnitsReader(reader));
                    }
                }
            }
            catch (SqlException)
            {

                throw;
            }
            return unitList;
        }

        public IList<Unit> GetAllUnits()
        {
            IList<Unit> unitList = new List<Unit>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql =
                        "SELECT unit_id, bedroom_count, bathroom_count, pet_friendly, non_smoking, pool_access, parking_spots, rent_amount, is_rented, rent_due_date, property_id " +
                        "FROM unit;";
                    SqlCommand cmd = new SqlCommand(sql, conn);

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

        public IList<Unit> GetUnitsByPropertyId(int id)
        {
            IList<Unit> unitList = new List<Unit>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = 
                        "SELECT u.unit_id, a.bedroom_count, a.bathroom_count, a.pet_allowed, a.smoking_allowed, a.pool_access," +
                        " a.parking_spots, u.rent_amount, u.is_rented, u.rent_due_date FROM" +
                        " units u JOIN amenities a ON u.unit_id = a.unit_id WHERE u.property_id = @propertyId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@propertyId", id);

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

        //Helper method that is used for GetUnitDetails()
        private DetailedUnit GetDetailedUnitReader(SqlDataReader reader)
        {
            DetailedUnit unit = new DetailedUnit();

            unit.propertyId = Convert.ToInt32(reader["property_id"]);
            unit.unitId = Convert.ToInt32(reader["unit_id"]);
            unit.unitType = Convert.ToString(reader["unit_type_name"]);
            unit.unitRentAmount = Convert.ToInt32(reader["rent_amount"]);
            unit.buildingNumber = Convert.ToInt32(reader["unit_building_number"]);
            unit.unitNumber = Convert.ToString(reader["unit_number"]);
            unit.unitAddress = Convert.ToString(reader["unit_street_address"]);
            unit.unitCity = Convert.ToString(reader["unit_city"]);
            unit.unitZipCode = Convert.ToString(reader["unit_zip_code"]);
            unit.imgUrl = Convert.ToString(reader["image_url"]);
            unit.bedroomCount = Convert.ToInt32(reader["bedroom_count"]);
            unit.bathroomCount = Convert.ToInt32(reader["bathroom_count"]);
            unit.petFriendly = Convert.ToBoolean(reader["pet_allowed"]);
            unit.smokingAllowed = Convert.ToBoolean(reader["smoking_allowed"]);
            unit.poolAccess = Convert.ToBoolean(reader["pool_access"]);
            unit.parkingSpots = Convert.ToInt32(reader["parking_spots"]);

            return unit;

        }

        //Helper method that is used for GetAllAvailableUnits()
        private AvailableUnits GetAvaiableUnitsReader(SqlDataReader reader)
        {
            AvailableUnits unit = new AvailableUnits();

            unit.unitId = Convert.ToInt32(reader["unit_id"]);
            unit.propertyId = Convert.ToInt32(reader["property_id"]);
            unit.unitType = Convert.ToString(reader["unit_type_name"]);
            unit.unitRentAmount = Convert.ToDecimal(reader["rent_amount"]);
            unit.buildingNumber = Convert.ToInt32(reader["unit_building_number"]);
            unit.unitNumber = Convert.ToString(reader["unit_number"]);
            unit.unitAddress = Convert.ToString(reader["unit_street_address"]);
            unit.unitCity = Convert.ToString(reader["unit_city"]);
            unit.unitZipCode = Convert.ToString(reader["unit_zip_code"]);
            unit.imgUrl = Convert.ToString(reader["image_url"]);


            return unit;
        }

        private Unit GetAllUnitsFromReader(SqlDataReader reader)
        {
            Unit units = new Unit()
            {
                unitId = Convert.ToInt32(reader["unit_id"]),
                bedroomCount = Convert.ToInt32(reader["bedroom_count"]),
                bathroomCount = Convert.ToDecimal(reader["bathroom_count"]),
                petFriendly = Convert.ToBoolean(reader["pet_allowed"]),
                nonSmoking = Convert.ToBoolean(reader["smoking_allowed"]),
                poolAccess = Convert.ToBoolean(reader["pool_access"]),
                parkingSpots = Convert.ToInt32(reader["parking_spots"]),
                rentAmount = Convert.ToDecimal(reader["rent_amount"]),
                isRented = Convert.ToBoolean(reader["is_rented"]),
                rentDueDate = Convert.ToString(reader["rent_due_date"]),
                //propertyId = Convert.ToInt32(reader["property_id"])
            };
            return units;
        }

    }
}

