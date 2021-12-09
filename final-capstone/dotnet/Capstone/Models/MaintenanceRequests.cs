namespace Capstone.Models

{
    public class MaintenanceRequests
    {
       public int maintenanceRequestId { get; set; }
       public int unitId { get; set; }
       public string description { get; set; }
       public bool isCompleted { get; set; }
       public int requesterUserId { get; set; }
       public int maintenanceUserId { get; set; }

    }
}