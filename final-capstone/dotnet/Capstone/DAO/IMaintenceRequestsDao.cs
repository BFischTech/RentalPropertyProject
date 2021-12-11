using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IMaintenceRequestsDao
    {
        IList<MaintenanceRequestsByOwner> GetMaintenanceRequestsByOwner(int ownerId);

        IList<MaintenanceRequestsByTenant> GetMaintenanceRequestsByTenant(int tenantId);
    }
}
