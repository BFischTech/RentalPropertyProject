using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;

namespace Capstone.DAO
{
    public class MaintenanceRequestsSqlDao : IMaintenceRequestsDao
    {
        private string _connectionString;

        public MaintenanceRequestsSqlDao(string connectionString)
        {
            this._connectionString = connectionString;
        }

        public IList<MaintenanceRequestsByOwner> GetMaintenanceRequestsByOwner(int ownerId) {
            IList<MaintenanceRequestsByOwner> maintenanceRequestsByOwner = new List<MaintenanceRequestsByOwner>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    var sql =
                        "SELECT " +
                        "mr.maintenance_request_id AS 'ID', " +
                        "(t.first_name + ' ' + t.last_name) AS 'From', " +
                        "p.property_id AS 'Property No.', " +
                        "t.unit_rented_id AS 'Unit No.', " +
                        "mrt.maintenance_request_type_name AS 'Request Type', " +
                        "mr.concern AS 'Concern', " +
                        "mr.request_date_time AS 'Date & Time Request Made', " +
                        "mrs.maintenance_request_status_name AS 'Status' " +
                        "FROM maintenance_requests mr " +
                        "INNER JOIN tenant t ON t.tenant_id = mr.tenant_id " +
                        "INNER JOIN users u ON u.user_id = t.tenant_id " +
                        "INNER JOIN units un ON un.unit_id = t.unit_rented_id " +
                        "INNER JOIN properties p ON p.property_id = un.property_id " +
                        "INNER JOIN maintenance_request_types mrt ON mrt.maintenance_request_type_id = mr.request_type_id " +
                        "INNER JOIN maintenance_request_status mrs ON mrs.maintenance_request_status_id = mr.request_status_id " +
                        "WHERE p.owner_id = @ownerId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@ownerId", ownerId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        maintenanceRequestsByOwner.Add(GetMaintenanceRequestsByOwnerFromReader(reader));
                    }
                }
            }
            catch (SqlException) {
                throw;
            }
            return maintenanceRequestsByOwner;
        }

        //Helper method to Convert DB data based off the correct model
        private MaintenanceRequestsByOwner GetMaintenanceRequestsByOwnerFromReader(SqlDataReader reader)
        {
            MaintenanceRequestsByOwner maintenanceRequestsByOwner = new MaintenanceRequestsByOwner();

            maintenanceRequestsByOwner.maintenanceRequestId = Convert.ToInt32(reader["ID"]);
            maintenanceRequestsByOwner.from = Convert.ToString(reader["From"]);
            maintenanceRequestsByOwner.propertyNo = Convert.ToInt32(reader["Property No."]);
            maintenanceRequestsByOwner.unitNo = Convert.ToInt32(reader["Unit No."]);
            maintenanceRequestsByOwner.requestType = Convert.ToString(reader["Request Type"]);
            maintenanceRequestsByOwner.concern = Convert.ToString(reader["Concern"]);
            var dateTime = Convert.ToDateTime(reader["Date & Time Request Made"]);
            maintenanceRequestsByOwner.dateTimeRequestMade = dateTime.ToString("MM/dd/yyyy h:mm tt");
            maintenanceRequestsByOwner.requestStatus = Convert.ToString(reader["Status"]);

            return maintenanceRequestsByOwner;
        }

            public IList<MaintenanceRequestsByTenant> GetMaintenanceRequestsByTenant(int tenantId) {
            IList<MaintenanceRequestsByTenant> maintenanceRequestsByTenant = new List<MaintenanceRequestsByTenant>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    var sql =
                        "SELECT " +
                            "mr.maintenance_request_id AS 'ID', " +
                            "(t.first_name + ' ' + t.last_name) AS 'From', " +
                            "t.unit_rented_id AS 'Unit No.', " +
                            "mrt.maintenance_request_type_name AS 'Request Type', " +
                            "mr.concern AS 'Concern', " +
                            "mr.request_date_time AS 'Date & Time Request Made', " +
                            "mrs.maintenance_request_status_name AS 'Status' " +
                        "FROM maintenance_requests mr " +
                        "INNER JOIN tenant t ON t.tenant_id = mr.tenant_id " +
                        "INNER JOIN users u ON u.user_id = t.tenant_id " +
                        "INNER JOIN units un ON un.unit_id = t.unit_rented_id " +
                        "INNER JOIN maintenance_request_types mrt ON mrt.maintenance_request_type_id = mr.request_type_id " +
                        "INNER JOIN maintenance_request_status mrs ON mrs.maintenance_request_status_id = mr.request_status_id " +
                        "WHERE mr.tenant_id = @tenantId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@tenantId", tenantId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        maintenanceRequestsByTenant.Add(GetMaintenanceRequestsByTenantFromReader(reader));
                    }
                }
            }
            catch (SqlException) {
                throw;
            }
            return maintenanceRequestsByTenant;
        }

        //Helper method to Convert DB data based off the correct model
        private MaintenanceRequestsByTenant GetMaintenanceRequestsByTenantFromReader(SqlDataReader reader)
        {
            MaintenanceRequestsByTenant maintenanceRequestsByTenant = new MaintenanceRequestsByTenant();

            maintenanceRequestsByTenant.maintenanceRequestId = Convert.ToInt32(reader["ID"]);
            maintenanceRequestsByTenant.from = Convert.ToString(reader["From"]);
            maintenanceRequestsByTenant.unitNo = Convert.ToInt32(reader["Unit No."]);
            maintenanceRequestsByTenant.requestType = Convert.ToString(reader["Request Type"]);
            maintenanceRequestsByTenant.concern = Convert.ToString(reader["Concern"]);
            var dateTime = Convert.ToDateTime(reader["Date & Time Request Made"]);
            maintenanceRequestsByTenant.dateTimeRequestMade = dateTime.ToString("MM/dd/yyyy h:mm tt") ;
            maintenanceRequestsByTenant.requestStatus = Convert.ToString(reader["Status"]);

            return maintenanceRequestsByTenant;
        }

    }
}
