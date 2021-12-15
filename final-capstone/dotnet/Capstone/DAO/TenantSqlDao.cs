using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;

namespace Capstone.DAO
{
    public class TenantSqlDao : ITenantDao
    {

        private readonly string _connectionString;

        public TenantSqlDao(string dbConnectionString)
        {
            _connectionString = dbConnectionString;
        }

        public IList<TenantWithoutRentedUnit> GetAllTenantWithoutRentedUnit() {
            IList<TenantWithoutRentedUnit> tenantWithoutRentedUnit = new List<TenantWithoutRentedUnit>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();
                    string sql =
                        "SELECT " +
                            "tenant_id, " +
                            "first_name, " +
                            "last_name, " +
                            "email, " +
                            "mobile_number " +
                        "FROM tenant " +
                        "WHERE  " +
                            "unit_rented_id IS NULL;";
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read()) {
                        tenantWithoutRentedUnit.Add(GetAllTenantWithoutRentedUnitFromReader(reader));
                    }
                }
            } catch (SqlException) {
                throw;
            }
            return tenantWithoutRentedUnit;
        }

        
        //Helper method that is used for GetAllAvailableUnitsByOwnerId()
        private TenantWithoutRentedUnit GetAllTenantWithoutRentedUnitFromReader(SqlDataReader reader) {
            TenantWithoutRentedUnit tenantWithoutRentedUnit = new TenantWithoutRentedUnit();

            tenantWithoutRentedUnit.tenantId = Convert.ToInt32(reader["tenant_id"]);
            tenantWithoutRentedUnit.firstName = Convert.ToString(reader["first_name"]);
            tenantWithoutRentedUnit.lastName = Convert.ToString(reader["last_name"]);
            tenantWithoutRentedUnit.email = Convert.ToString(reader["email"]);
            tenantWithoutRentedUnit.mobileNumber = Convert.ToString(reader["mobile_number"]);

            return tenantWithoutRentedUnit;
        }
    }
}
