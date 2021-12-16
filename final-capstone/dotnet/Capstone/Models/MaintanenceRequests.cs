using System;

namespace Capstone.Models

{
    public class MaintenanceRequestsViewsForOwner
    {
        public int maintenanceRequestId { get; set; }
        public int propertyId { get; set; }
        public string unitType { get; set; }
        public string fromTenant { get; set; }
        public int unitBuildingNumber { get; set; }
        public string unitNumber { get; set; }
        public string unitAdresss { get; set; }
        public string requestType { get; set; }
        public string concern { get; set; }
        public string dateTimeRequestMade { get; set; }
        public string requestStatus { get; set; }
        public string EmployeeeAssigned { get; set; }

    }

    public class MaintenanceRequestsViewsForTenant
    {
        public int maintenanceRequestId { get; set; }
        public string requestType { get; set; }
        public string concern { get; set; }
        public string dateTimeRequestMade { get; set; }
        public string requestStatus { get; set; }
        public string EmployeeeAssigned { get; set; }

    }

    public class MaintenanceRequestsViewsForEmployee
    {
        public int maintenanceRequestId { get; set; }
        public int propertyId { get; set; }
        public string unitType { get; set; }
        public string fromTenant { get; set; }
        public int unitBuildingNumber { get; set; }
        public string unitNumber { get; set; }
        public string unitAdresss { get; set; }
        public string requestType { get; set; }
        public string concern { get; set; }
        public string dateTimeRequestMade { get; set; }
        public string requestStatus { get; set; }
        public string EmployeeeAssigned { get; set; }
    }

    public class MaintenanceRequest
    {
        public int tenantId { get; set; }
        public int requestTypeId { get; set; }
        public string concern { get; set; }
        public string DateTime { get; set; }
        public int requestStatusId { get; set; } = 1;

    }

    public class StatusIdRequestId
    {
        public int statusId { get; set;}
        public int requestId { get; set;}
    }
}