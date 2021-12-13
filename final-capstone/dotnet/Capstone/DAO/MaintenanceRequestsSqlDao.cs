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

        public IList<MaintenanceRequestsViewsForEmployee> GetMaintenanceRequestsForEmployee(int employeeeId)
        {
            IList<MaintenanceRequestsViewsForEmployee> requests = new List<MaintenanceRequestsViewsForEmployee>();
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                   
                    string sql = "SELECT mr.maintenance_request_id, u.property_id, ut.unit_type_name, t.first_name, ul.unit_building_number, ul.unit_number, ul.unit_street_address, mrt.maintenance_request_type_name, mr.concern, mr.request_date_time, mrs.maintenance_request_status_name, e.first_name " +
                                 "FROM maintenance_requests mr   " +
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

                    //var sql =
                    //    "SELECT " +
                    //    "mr.maintenance_request_id AS 'ID', " +
                    //    "(t.first_name + ' ' + t.last_name) AS 'From', " +
                    //    "p.property_id AS 'Property No.', " +
                    //    "t.unit_rented_id AS 'Unit No.', " +
                    //    "mrt.maintenance_request_type_name AS 'Request Type', " +
                    //    "mr.concern AS 'Concern', " +
                    //    "mr.request_date_time AS 'Date & Time Request Made', " +
                    //    "mrs.maintenance_request_status_name AS 'Status' " +
                    //    "FROM maintenance_requests mr " +
                    //    "INNER JOIN tenant t ON t.tenant_id = mr.tenant_id " +
                    //    "INNER JOIN users u ON u.user_id = t.tenant_id " +
                    //    "INNER JOIN units un ON un.unit_id = t.unit_rented_id " +
                    //    "INNER JOIN properties p ON p.property_id = un.property_id " +
                    //    "INNER JOIN maintenance_request_types mrt ON mrt.maintenance_request_type_id = mr.request_type_id " +
                    //    "INNER JOIN maintenance_request_status mrs ON mrs.maintenance_request_status_id = mr.request_status_id " +
                    //    "WHERE p.owner_id = @ownerId;";
                    string sql = "select mr.maintenance_request_id, u.property_id, t.first_name, ul.unit_street_address, mrt.maintenance_request_type_name, mr.concern, mr.request_date_time, mrs.maintenance_request_status_name, e.first_name " +
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

                    //var sql =
                    //    "SELECT " +
                    //        "mr.maintenance_request_id AS 'ID', " +
                    //        "(t.first_name + ' ' + t.last_name) AS 'From', " +
                    //        "t.unit_rented_id AS 'Unit No.', " +
                    //        "mrt.maintenance_request_type_name AS 'Request Type', " +
                    //        "mr.concern AS 'Concern', " +
                    //        "mr.request_date_time AS 'Date & Time Request Made', " +
                    //        "mrs.maintenance_request_status_name AS 'Status' " +
                    //    "FROM maintenance_requests mr " +
                    //    "INNER JOIN tenant t ON t.tenant_id = mr.tenant_id " +
                    //    "INNER JOIN users u ON u.user_id = t.tenant_id " +
                    //    "INNER JOIN units un ON un.unit_id = t.unit_rented_id " +
                    //    "INNER JOIN maintenance_request_types mrt ON mrt.maintenance_request_type_id = mr.request_type_id " +
                    //    "INNER JOIN maintenance_request_status mrs ON mrs.maintenance_request_status_id = mr.request_status_id " +
                    //    "WHERE mr.tenant_id = @tenantId;";
                    string sql = "SELECT mr.maintenance_request_id, mrt.maintenance_request_type_name, mr.concern, mr.request_date_time, mrs.maintenance_request_status_name, e.first_name " +
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
            request.unitType = Convert.ToString(reader["unit_type_name"]);
            request.fromTenant = Convert.ToString(reader["first_name"]);
            request.unitBuildingNumber = Convert.ToInt32(reader["unit_building_number"]);
            request.unitNumber = Convert.ToString(reader["unit_number"]);
            request.unitAdresss = Convert.ToString(reader["unit_street_address"]);
            request.requestType = Convert.ToString(reader["maintenance_request_type_name"]);
            request.concern = Convert.ToString(reader["concern"]);
            request.dateTimeRequestMade = Convert.ToString(reader["request_date_time"]);
            request.requestStatus = Convert.ToString(reader["maintenance_request_status_name"]);
            request.EmployeeeAssigned = Convert.ToString(reader["first_name"]);

            return request;
        }

        //Helper method for GetMaintenanceRequestsForOwner
        private MaintenanceRequestsViewsForOwner GetRequestsForOwnerReader(SqlDataReader reader)
        {
            MaintenanceRequestsViewsForOwner request = new MaintenanceRequestsViewsForOwner();

            //maintenanceRequestsByOwner.maintenanceRequestId = Convert.ToInt32(reader["ID"]);
            //maintenanceRequestsByOwner.from = Convert.ToString(reader["From"]);
            //maintenanceRequestsByOwner.propertyNo = Convert.ToInt32(reader["Property No."]);
            //maintenanceRequestsByOwner.unitNo = Convert.ToInt32(reader["Unit No."]);
            //maintenanceRequestsByOwner.requestType = Convert.ToString(reader["Request Type"]);
            //maintenanceRequestsByOwner.concern = Convert.ToString(reader["Concern"]);
            //var dateTime = Convert.ToDateTime(reader["Date & Time Request Made"]);
            //maintenanceRequestsByOwner.dateTimeRequestMade = dateTime.ToString("MM/dd/yyyy h:mm tt");
            //maintenanceRequestsByOwner.requestStatus = Convert.ToString(reader["Status"]);

            request.maintenanceRequestId = Convert.ToInt32(reader["maintenance_request_id"]);
            request.propertyId = Convert.ToInt32(reader["property_id"]);
            request.fromTenant = Convert.ToString(reader["first_name"]);
            request.unitAdresss = Convert.ToString(reader["unit_street_address"]);
            request.requestType = Convert.ToString(reader["maintenance_request_type_name"]);
            request.concern = Convert.ToString(reader["concern"]);
            request.dateTimeRequestMade = Convert.ToString(reader["request_date_time"]);
            request.requestStatus = Convert.ToString(reader["maintenance_request_status_name"]);
            request.EmployeeeAssigned = Convert.ToString(reader["first_name"]);

            return request;
        }

        //Helper method for GetMaintenanceRequestsForTenant()
        private MaintenanceRequestsViewsForTenant GetRequestsFOrTenantFromReader(SqlDataReader reader)
        {
            MaintenanceRequestsViewsForTenant request = new MaintenanceRequestsViewsForTenant();

            //maintenanceRequestsByTenant.maintenanceRequestId = Convert.ToInt32(reader["ID"]);
            //maintenanceRequestsByTenant.from = Convert.ToString(reader["From"]);
            //maintenanceRequestsByTenant.unitNo = Convert.ToInt32(reader["Unit No."]);
            //maintenanceRequestsByTenant.requestType = Convert.ToString(reader["Request Type"]);
            //maintenanceRequestsByTenant.concern = Convert.ToString(reader["Concern"]);
            //var dateTime = Convert.ToDateTime(reader["Date & Time Request Made"]);
            //maintenanceRequestsByTenant.dateTimeRequestMade = dateTime.ToString("MM/dd/yyyy h:mm tt");
            //maintenanceRequestsByTenant.requestStatus = Convert.ToString(reader["Status"]);

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
