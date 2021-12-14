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

        public void CreateRequest(MaintenanceRequest request, int tenantId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))

                {
                    conn.Open();
                    string sql = "INSERT INTO maintenance_requests (tenant_id, request_type_id, concern, request_date_time, request_status_id) " +
                                 "VALUES (@tenant_id, @request_type_id, @concern, @request_date_time, @request_status_id)";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@tenant_id", tenantId);
                    cmd.Parameters.AddWithValue("@request_type_id", request.requestTypeId);
                    cmd.Parameters.AddWithValue("@concern", request.concern);
                    cmd.Parameters.AddWithValue("@request_date_time", request.DateTime);
                    cmd.Parameters.AddWithValue("@request_status_id", request.requestStatusId);
                    

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {

                throw;
            }
        }

        public IList<MaintenanceRequestsViewsForEmployee> GetMaintenanceRequestsForEmployee(int employeeeId)
        {
            IList<MaintenanceRequestsViewsForEmployee> requests = new List<MaintenanceRequestsViewsForEmployee>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                   
                    string sql = 
                        "SELECT " +
                            "mr.maintenance_request_id AS 'maintenance_request_id', " +
                            "u.property_id AS 'property_id', " +
                            "ut.unit_type_name AS 'unit_type', " +
                            "(t.last_name + ', ' + t.first_name) AS 'tenant_name', " +
                            "ul.unit_building_number AS 'building_no', " +
                            "ul.unit_number AS 'unit_number', " +
                            "ul.unit_street_address AS 'address', " +
                            "mrt.maintenance_request_type_name AS 'maintenance_type', " +
                            "mr.concern AS 'concern', " +
                            "mr.request_date_time AS 'request_date_time', " +
                            "mrs.maintenance_request_status_name AS 'status', " +
                            "(e.last_name + ', ' + e.first_name) AS 'employee_name' " +
                        "FROM maintenance_requests mr " +
                        "LEFT JOIN tenant t ON mr.tenant_id = t.tenant_id  " +
                        "LEFT JOIN units u ON t.unit_rented_id = u.unit_id  " +
                        "LEFT JOIN unit_location ul ON u.unit_id = ul.unit_location_id  " +
                        "LEFT JOIN employee e ON mr.employee_assigned_id = e.employee_id " +
                        "LEFT JOIN maintenance_request_types mrt ON mr.request_type_id = mrt.maintenance_request_type_id  " +
                        "LEFT JOIN maintenance_request_status mrs ON mr.request_status_id = mrs.maintenance_request_status_id  " +
                        "LEFT JOIN properties p ON u.property_id = p.property_id " +
                        "LEFT JOIN unit_types ut ON u.unit_id = ut.unit_type_id " +
                        "WHERE mr.employee_assigned_id = @employeeId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@employeeId", employeeeId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        requests.Add(GetRequestsForEmployeeReader(reader));
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return requests;
        }

        public IList<MaintenanceRequestsViewsForOwner> GetMaintenanceRequestsForOwner(int ownerId) {
            IList<MaintenanceRequestsViewsForOwner> requests = new List<MaintenanceRequestsViewsForOwner>();

            try {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    string sql = 
                        "SELECT " +
                            "mr.maintenance_request_id AS 'maintenance_request_id', " +
                            "u.property_id AS 'property_id', " +
                            "ut.unit_type_name AS 'unit_type', " +
                            "(t.last_name + ', ' + t.first_name) AS 'tenant_name', " +
                            "ul.unit_building_number AS 'building_no', " +
                            "ul.unit_number AS 'unit_number', " +
                            "ul.unit_street_address AS 'address', " +
                            "mrt.maintenance_request_type_name AS 'maintenance_type', " +
                            "mr.concern AS 'concern', " +
                            "mr.request_date_time AS 'request_date_time', " +
                            "mrs.maintenance_request_status_name AS 'status', " +
                            "(e.last_name + ', ' + e.first_name) AS 'employee_name' " +
                        "FROM maintenance_requests mr " +
                        "LEFT JOIN tenant t ON mr.tenant_id = t.tenant_id " +
                        "LEFT JOIN units u ON t.unit_rented_id = u.unit_id " +
                        "LEFT JOIN unit_location ul ON u.unit_id = ul.unit_location_id " +
                        "LEFT JOIN employee e ON mr.employee_assigned_id = e.employee_id " +
                        "LEFT JOIN maintenance_request_types mrt ON mr.request_type_id = mrt.maintenance_request_type_id " +
                        "LEFT JOIN maintenance_request_status mrs ON mr.request_status_id = mrs.maintenance_request_status_id " +
                        "LEFT JOIN properties p ON u.property_id = p.property_id " +
                        "WHERE owner_id = @ownerId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@ownerId", ownerId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        requests.Add(GetRequestsForOwnerReader(reader));
                    }
                }
            }
            catch (SqlException) {
                throw;
            }
            return requests;
        }


        public IList<MaintenanceRequestsViewsForTenant> GetMaintenanceRequestsForTenant(int tenantId)
        {
            IList<MaintenanceRequestsViewsForTenant> requests = new List<MaintenanceRequestsViewsForTenant>();

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    string sql = 
                        "SELECT " +
                            "mr.maintenance_request_id, " +
                            "mrt.maintenance_request_type_name, " +
                            "mr.request_date_time AS 'request_date_time', " +
                            "mrs.maintenance_request_status_name AS 'status', " +
                            "(e.last_name + ', ' + e.first_name) AS 'employee_name' " +
                        "FROM maintenance_requests mr " +
                        "LEFT JOIN tenant t ON mr.tenant_id = t.tenant_id  " +
                        "LEFT JOIN units u ON t.unit_rented_id = u.unit_id  " +
                        "LEFT JOIN unit_location ul ON u.unit_id = ul.unit_location_id  " +
                        "LEFT JOIN employee e ON mr.employee_assigned_id = e.employee_id " +
                        "LEFT JOIN maintenance_request_types mrt ON mr.request_type_id = mrt.maintenance_request_type_id  " +
                        "LEFT JOIN maintenance_request_status mrs ON mr.request_status_id = mrs.maintenance_request_status_id  " +
                        "LEFT JOIN properties p ON u.property_id = p.property_id " +
                        "WHERE t.tenant_id = @tenantId;";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@tenantId", tenantId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        requests.Add(GetRequestsFOrTenantFromReader(reader));
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }
            return requests;
        }
        //Helper method for GetMaintenanceRequestsForEmployee
        private MaintenanceRequestsViewsForEmployee GetRequestsForEmployeeReader(SqlDataReader reader)
        {
            MaintenanceRequestsViewsForEmployee request = new MaintenanceRequestsViewsForEmployee();

            request.maintenanceRequestId = Convert.ToInt32(reader["maintenance_request_id"]);
            request.propertyId = Convert.ToInt32(reader["property_id"]);
            request.unitType = Convert.ToString(reader["unit_type"]);
            request.fromTenant = Convert.ToString(reader["tenant_name"]);
            request.unitBuildingNumber = Convert.ToInt32(reader["building_no"]);
            request.unitNumber = Convert.ToString(reader["unit_number"]);
            request.unitAdresss = Convert.ToString(reader["address"]);
            request.requestType = Convert.ToString(reader["maintenance_type"]);
            request.concern = Convert.ToString(reader["concern"]);
            request.dateTimeRequestMade = Convert.ToString(reader["request_date_time"]);
            request.requestStatus = Convert.ToString(reader["status"]);
            request.EmployeeeAssigned = Convert.ToString(reader["employee_name"]);

            return request;
        }

        //Helper method for GetMaintenanceRequestsForOwner
        private MaintenanceRequestsViewsForOwner GetRequestsForOwnerReader(SqlDataReader reader)
        {
            MaintenanceRequestsViewsForOwner request = new MaintenanceRequestsViewsForOwner();

            request.maintenanceRequestId = Convert.ToInt32(reader["maintenance_request_id"]);
            request.propertyId = Convert.ToInt32(reader["property_id"]);
            request.unitType = Convert.ToString(reader["unit_type"]);
            request.fromTenant = Convert.ToString(reader["tenant_name"]);
            request.unitBuildingNumber = Convert.ToInt32(reader["building_no"]);
            request.unitNumber = Convert.ToString(reader["unit_number"]);
            request.unitAdresss = Convert.ToString(reader["address"]);
            request.requestType = Convert.ToString(reader["maintenance_type"]);
            request.concern = Convert.ToString(reader["concern"]);
            request.dateTimeRequestMade = Convert.ToString(reader["request_date_time"]);
            request.requestStatus = Convert.ToString(reader["status"]);
            request.EmployeeeAssigned = Convert.ToString(reader["employee_name"]);

            return request;
        }

        //Helper method for GetMaintenanceRequestsForTenant()
        private MaintenanceRequestsViewsForTenant GetRequestsFOrTenantFromReader(SqlDataReader reader)
        {
            MaintenanceRequestsViewsForTenant request = new MaintenanceRequestsViewsForTenant();

            request.maintenanceRequestId = Convert.ToInt32(reader["maintenance_request_id"]);
            request.requestType = Convert.ToString(reader["maintenance_request_type_name"]);
            request.concern = Convert.ToString(reader["concern"]);
            request.dateTimeRequestMade = Convert.ToString(reader["request_date_time"]);
            request.requestStatus = Convert.ToString(reader["maintenance_request_status_name"]);
            request.EmployeeeAssigned = Convert.ToString(reader["first_name"]);

            return request;
        }

    }
}
