using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IMaintenceRequestsDao
    {
        IList<MaintenanceRequestsViewsForOwner> GetMaintenanceRequestsForOwner(int ownerId);

        IList<MaintenanceRequestsViewsForTenant> GetMaintenanceRequestsForTenant(int tenantId);

        IList<MaintenanceRequestsViewsForEmployee> GetMaintenanceRequestsForEmployee(int employeeeId);
    }
}
