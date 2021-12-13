using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class MaintenanceRequestController : ControllerBase
    {
        private readonly IMaintenceRequestsDao _maintenceRequestsDao;

        public MaintenanceRequestController(IMaintenceRequestsDao maintenceRequestsDao) {
            _maintenceRequestsDao = maintenceRequestsDao;
        }

        [HttpGet("owner/{ownerId}")]
        [AllowAnonymous]
        //[Authorize(Roles ="Admin, Owner")]
        public ActionResult<IList<MaintenanceRequestsViewsForOwner>> GetMaintenanceRequestsForOwner(int ownerId) {
            //return Ok(_maintenceRequestsDao.GetMaintenanceRequestsByOwner(Convert.ToInt32(User.FindFirst("sub")?.Value)));
            return Ok(_maintenceRequestsDao.GetMaintenanceRequestsForOwner(ownerId));
        }

        [HttpGet("tenant/{tenantId}")]
        [AllowAnonymous]
        //[Authorize(Roles = "Admin, Tenant")]
        public ActionResult<IList<MaintenanceRequestsViewsForTenant>> GetMaintenanceRequestsByTenant(int tenantId)
        {
            /*return Ok(_maintenceRequestsDao.GetMaintenanceRequestsByTenant(Convert.ToInt32(User.FindFirst("sub")?.Value)));*/
            return Ok(_maintenceRequestsDao.GetMaintenanceRequestsForTenant(tenantId));
        }

        [HttpGet("employee/{employeeId}")]
        [AllowAnonymous]
        //[Authorize(Roles = "Admin, Employee")]
        public ActionResult<IList<MaintenanceRequestsViewsForTenant>> GetMaintenanceRequestsByEmployee(int employeeId)
        {
            
            return Ok(_maintenceRequestsDao.GetMaintenanceRequestsForEmployee(employeeId));
        }
    }
}
