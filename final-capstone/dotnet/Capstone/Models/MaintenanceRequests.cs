using System;

namespace Capstone.Models

{
    public class MaintenanceRequestsByOwner
    {
       public int maintenanceRequestId { get; set; }
       public string from { get; set; }
       public int propertyNo { get; set; }
       public int unitNo { get; set; }
       public string requestType { get; set; }
       public string concern { get; set; }
       public string dateTimeRequestMade { get; set; }
       public string requestStatus { get; set; }

    }

    public class MaintenanceRequestsByTenant
    {
        public int maintenanceRequestId { get; set; }
        public string from { get; set; }
        public int unitNo { get; set; }
        public string requestType { get; set; }
        public string concern { get; set; }
        public string dateTimeRequestMade { get; set; }
        public string requestStatus { get; set; }

    }
}