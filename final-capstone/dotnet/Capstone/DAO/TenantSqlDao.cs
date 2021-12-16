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

        public void TenantRent(TenantRent tenantRent)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = "UPDATE tenant SET rent_paid = rent_paid + @rentPaid, date_rent_paid = GETDATE() WHERE tenant_id = @tenantId";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    
                    cmd.Parameters.AddWithValue("@rentPaid", tenantRent.amount);
                    cmd.Parameters.AddWithValue("@tenantId", tenantRent.tenantId);
                    cmd.ExecuteNonQuery();
                }
            } catch (SqlException)
            {
                throw;
            } 
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

        public void AssignTenantToAvailableUnit(UnitAndTenant unitAndTenant) {
            try {
                using (SqlConnection conn = new SqlConnection(_connectionString)) {
                    conn.Open();

                    var sql = 
                        "UPDATE tenant SET unit_rented_id = @unitId WHERE tenant_id = @tenantId;" +
                        "UPDATE units SET is_rented = 1 WHERE unit_id = @unitId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@unitId", unitAndTenant.unitId);
                    cmd.Parameters.AddWithValue("@tenantId", unitAndTenant.tenantId);

                    cmd.ExecuteNonQuery();
                }
            } catch (SqlException) {
                throw;
            }

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
